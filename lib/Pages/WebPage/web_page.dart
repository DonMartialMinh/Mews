import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mews/Widgets/app_bar.dart';
import 'package:mews/Widgets/custom_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  String url;
  String title;

  WebPage({Key? key, required this.url, required this.title}) : super(key: key);

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  bool isLoading = true;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
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
        widget.title,
        fontWeight: FontWeight.w600,
      ),
      actions: [
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
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onProgress: (int progress) {
              print('WebView is loading (progress : $progress%)');
            },
            navigationDelegate: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
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
  }
}
