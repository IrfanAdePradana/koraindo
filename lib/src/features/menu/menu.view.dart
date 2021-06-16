import 'package:flutter/material.dart';
import 'package:news_apps/src/features/explore-news/explore_news.view.dart';
import 'package:news_apps/src/features/home/home.view.dart';
import 'package:news_apps/src/features/menu/menu.view_model.dart';
import 'package:news_apps/utils/size_config.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<MenuViewModel>(
      builder: (_, model, __) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: model.indexMenu,
            onTap: (int index) {
              model.setStateIndexMenu(index);
            },
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Explore'
              )
            ],
          ),
          body: IndexedStack(
            index: model.indexMenu,
            children: [
              HomeScreen(),
              ExploreNewsScreen()
            ],
          )
        );
      }
    );
  }
}
