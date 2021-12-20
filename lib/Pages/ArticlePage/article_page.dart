import 'dart:async';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mews/Models/article.dart';
import 'package:mews/Models/article_list.dart';
import 'package:mews/Widgets/app_bar.dart';
import 'package:mews/Widgets/custom_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticlePage extends StatefulWidget {
  final Article? article;

  ArticlePage({Key? key, this.article}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final favorites = ArticleList();
  final recents = ArticleList();
  final local = LocalStorage('news');
  bool isLoading = true;
  bool initialized = false;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  _addToFavorite(Article article) {
    setState(() {
      favorites.list.insert(0, article);
      _saveToStorage('favorites', favorites);
    });
  }

  _addToRecent(Article article) {
    if (!_checkRecentsDuplicated(article.url!)) {
      recents.list.insert(0, article);
      if (recents.list.length > 10) {
        recents.list.removeAt(recents.list.length - 1);
      }
      _saveToStorage('recents', recents);
    }
  }

  _initRecent() {
    _saveToStorage('recents', recents);
  }

  _removeFromFavorite(String url) {
    setState(() {
      favorites.list.removeWhere((element) => element.url == url);
      _saveToStorage('favorites', favorites);
    });
  }

  _saveToStorage(String type, ArticleList articleList) {
    local.setItem(type, articleList.toJSON());
  }

  _clearStorage() async {
    await local.clear();
    setState(() {
      favorites.list = local.getItem('favorites') ?? [];
    });
  }

  bool _isFavorite(String url) {
    for (var item in favorites.list) {
      if (url == item.url) return true;
    }
    return false;
  }

  bool _checkRecentsDuplicated(String url) {
    for (var item in recents.list) {
      if (url == item.url) return true;
    }
    return false;
  }

  @override
  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      title: CustomText(
        widget.article!.source!.name!,
        fontWeight: FontWeight.w600,
      ),
      actions: [
        _buildFavorites(),
        Container(
          width: 20,
        )
      ],
    );
  }

  Future<bool> _willPopCallback() async {
    WebViewController webViewController = await _controller.future;
    bool canNavigate = await webViewController.canGoBack();
    if (canNavigate) {
      webViewController.goBack();
      return false;
    } else {
      return true;
    }
  }

  Future<bool> _willPushCallback() async {
    WebViewController webViewController = await _controller.future;
    bool canNavigate = await webViewController.canGoForward();
    if (canNavigate) {
      webViewController.goForward();
      return false;
    } else {
      return true;
    }
  }

  Future<bool> _reloadCallback() async {
    WebViewController webViewController = await _controller.future;
    webViewController.reload();
    setState(() {
      isLoading = true;
    });
    return true;
  }

  Widget _buildForwardArrow() {
    return GestureDetector(
      child: const Icon(
        Icons.arrow_forward,
        color: Colors.black,
      ),
      onTap: () {
        _willPushCallback();
      },
    );
  }

  Widget _buildBackwardArrow() {
    return GestureDetector(
      child: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onTap: () {
        _willPopCallback();
      },
    );
  }

  Widget _buildFavorites() {
    return GestureDetector(
      child: _isFavorite(widget.article!.url!)
          ? const Icon(
              Icons.favorite,
              color: Colors.pink,
            )
          : const Icon(
              Icons.favorite_outline,
              color: Colors.black,
            ),
      onTap: () {
        if (_isFavorite(widget.article!.url!)) {
          _removeFromFavorite(widget.article!.url!);
        } else {
          _addToFavorite(widget.article!);
        }
      },
    );
  }

  Widget _buildReloadArrow() {
    return GestureDetector(
      child: const Icon(
        Icons.refresh,
        color: Colors.black,
      ),
      onTap: () {
        _reloadCallback();
      },
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Builder(builder: (BuildContext context) {
        return Stack(children: [
          WebView(
            initialUrl: widget.article!.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onProgress: (int progress) {
              print('WebView is loading (progress : $progress%)');
              if (progress > 70) {
                setState(() {
                  isLoading = false;
                });
              }
            },
            navigationDelegate: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (finish) {
              print('Page finished loading');
            },
            gestureNavigationEnabled: true,
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(),
        ]);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: local.ready,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!initialized) {
            var favorites = local.getItem('favorites');
            if (favorites != null) {
              this.favorites.list = List<Article>.from(
                (favorites as List).map(
                  (item) => Article.fromJsonDynamic(item),
                ),
              );
            }
            var recents = local.getItem('recents');
            if (recents != null) {
              this.recents.list = List<Article>.from(
                (recents as List).map(
                  (item) => Article.fromJsonDynamic(item),
                ),
              );
              _addToRecent(widget.article!);
            } else {
              _initRecent();
            }
            initialized = true;
          }
          return Scaffold(
            appBar: _buildAppBar(),
            body: _buildBody(),
            bottomSheet: Container(
              height: 50,
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  _buildBackwardArrow(),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildForwardArrow(),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildReloadArrow(),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
