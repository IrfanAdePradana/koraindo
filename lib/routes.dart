import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_apps/src/features/home/home.model.dart';
import 'package:news_apps/src/features/home/home.view.dart';
import 'package:news_apps/src/features/news-detail/news_detail.view.dart';
import 'package:news_apps/src/features/news-source/news_source.view.dart';
import 'package:news_apps/src/widgets/page_route_transition.dart';

class Routers {
  Route<dynamic> initRouter(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return PageRouteTransition(
          page: HomeScreen()
        );
      case '/news-detail':
        final data = Article.fromJson(jsonDecode(settings.arguments));
        return PageRouteTransition(
          page: NewsDetailScreen(
            author: data.author,
            description: data.description,
            content: data.content,
            imageUrl: data.urlToImage,
            title: data.title,
            source: data.source,
            url: data.url,
            publishAt: data.publishedAt,
          )
        );
      case '/news-source':
        final data = settings.arguments;
        return PageRouteTransition(
          page: NewsSourceScreen(
            url: data,
          )
        );
      default:
        return PageRouteTransition(
          page:  Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}')
          ),
        )
      );
    }
  }
}
