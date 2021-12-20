import 'package:flutter/material.dart';
import 'package:mews/Pages/NewsPage/category_news_page.dart';
import 'package:mews/Services/api_services.dart';
import 'package:mews/Values/colors.dart';
import 'package:mews/Values/font_sizes.dart';
import 'package:mews/Widgets/app_bar.dart';
import 'package:mews/Widgets/custom_text.dart';
import 'package:mews/constants.dart';
import 'package:mews/routes.dart';

class NewsPage extends StatefulWidget {
  @override
  State<NewsPage> createState() => _NewsPageState();
}

List<Widget> _listWidgets = [
  CategoryNewsPage(category: NewsCategory.general),
  CategoryNewsPage(category: NewsCategory.business),
  CategoryNewsPage(category: NewsCategory.science),
  CategoryNewsPage(category: NewsCategory.technology),
  CategoryNewsPage(category: NewsCategory.health),
  CategoryNewsPage(category: NewsCategory.entertainment),
  CategoryNewsPage(category: NewsCategory.sports),
];

class _NewsPageState extends State<NewsPage> {
  ApiService client = ApiService();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _listWidgets.length,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      leading: Container(),
      title: CustomText(
        'Home',
        fontWeight: FontWeight.w700,
        fontSize: FontSize.BIG,
      ),
      actions: [
        Menu(),
        const SizedBox(
          width: 10,
        )
      ],
      bottom: PreferredSize(
        preferredSize: const Size(0, 25),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TabBar(
            unselectedLabelColor: AppColor.colorGrey,
            labelColor: Colors.red,
            indicatorColor: AppColor.colorPrimary,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            tabs: [
              _buildTabText('General'),
              _buildTabText('Business'),
              _buildTabText('Science'),
              _buildTabText('Technology'),
              _buildTabText('Health'),
              _buildTabText('Entertainment'),
              _buildTabText('Sports')
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabText(String title) {
    return CustomText(title);
  }

  Widget _buildBody() {
    return TabBarView(
      children: _listWidgets,
    );
  }
}

enum MenuOptions {
  recents,
  favorites,
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOptions>(
      icon: const Icon(
        Icons.menu,
        color: Colors.black,
      ),
      key: const ValueKey<String>('ShowPopupMenu'),
      onSelected: (MenuOptions value) {
        switch (value) {
          case MenuOptions.favorites:
            Navigator.pushNamed(context, RoutePaths.FAVORITE);
            break;
          case MenuOptions.recents:
            Navigator.pushNamed(context, RoutePaths.RECENT);
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
        PopupMenuItem<MenuOptions>(
          value: MenuOptions.recents,
          child: Row(
            children: const [
              Icon(Icons.timer, color: Colors.black),
              SizedBox(
                width: 15,
              ),
              Expanded(child: Text('Recents')),
            ],
          ),
        ),
        PopupMenuItem<MenuOptions>(
          value: MenuOptions.favorites,
          child: Row(
            children: const [
              Icon(Icons.favorite_outline, color: Colors.black),
              SizedBox(
                width: 15,
              ),
              Expanded(child: Text('Favorites')),
            ],
          ),
        ),
      ],
    );
  }
}
