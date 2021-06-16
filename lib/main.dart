import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:news_apps/routes.dart';
import 'package:news_apps/src/features/explore-news/explore_news.view_model.dart';
import 'package:news_apps/src/features/home/home.view_model.dart';
import 'package:news_apps/src/features/menu/menu.view.dart';
import 'package:news_apps/src/features/menu/menu.view_model.dart';
import 'package:news_apps/src/features/news-source/news_source.view_model.dart';
import 'package:provider/provider.dart';

main() async {
  await DotEnv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
          create: (_) => HomeViewModel(),
        ),
        ChangeNotifierProvider<MenuViewModel>(
          create: (_) => MenuViewModel()
        ),
        ChangeNotifierProvider(
          create: (_) => NewsSourceViewModel()
        ),
        ChangeNotifierProvider(
          create: (_) => ExploreNewsViewModel()
        )
      ],
      child: MaterialApp(
        title: 'Koraindo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Roboto',
          primaryColor: Colors.black
        ),
        debugShowCheckedModeBanner: false,
        home: MenuScreen(),
        onGenerateRoute: Routers().initRouter,
      ),
    );
  }
}
