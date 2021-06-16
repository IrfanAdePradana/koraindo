import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_apps/src/features/home/home.model.dart';
import 'package:news_apps/src/features/home/home.view_model.dart';

import 'package:news_apps/utils/date_format.dart';
import 'package:news_apps/utils/size_config.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final bloc = Provider.of<HomeViewModel>(context, listen: false);

      bloc.getTopHeadlineNews();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Koraindo",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Satisfy',
            fontSize: SizeConfig.safeBlockHorizontal * 6
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Consumer<HomeViewModel>(
        builder: (_, model, __) {
          if(model.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if(model.status == HomeStateStatus.Failed) {
              return Center(
                child: Text("Connection error"),
              );
            } else if(model.status == HomeStateStatus.Success) {
              return ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeBlockHorizontal * 4,
                  vertical: SizeConfig.safeBlockVertical * 3
                ),
                children: [
                  Container(
                    child: Text(
                      'Top Headline',
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 7,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Column(
                    children: model.newsTopHeadline.map((data) {
                      return GestureDetector(
                        onTap: () {
                          if(data.content != null) {
                            Navigator.of(context).pushNamed('/news-detail', arguments: articleToJson(data));
                          } else {
                            Navigator.of(context).pushNamed('/news-source', arguments: data.url);
                          }
                        },
                        child: NewsCard(
                          imageUrl: data.urlToImage,
                          source: data.source,
                          title: data.title,
                          publishAt: data.publishedAt,
                        ),
                      );
                    }).toList(),
                  )
                ],
              );
            }
          }
          return Container();
        }
      )
    );
  }
}

class NewsCard extends StatelessWidget {
  final String title;
  final Source source;
  final String imageUrl;
  final DateTime publishAt;

  NewsCard({
    @required this.title, @required this.source, @required this.imageUrl, @required this.publishAt
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: SizeConfig.safeBlockVertical * 1
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 1,
        child: Container(
          height: SizeConfig.safeBlockVertical * 22,
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$title",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 4,
                        ),
                      ),
                      Text(
                        "${source.name} - ${dateFormat(publishAt)}",
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 3.2,
                          fontWeight: FontWeight.w100
                        ),
                      ),
                    ],
                  ),
                )
              ),
              Container(
                height: SizeConfig.safeBlockVertical * 20,
                width: SizeConfig.safeBlockHorizontal * 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/images/preload.png'),
                    image: imageUrl != null ? NetworkImage("$imageUrl") : AssetImage('assets/images/preload.png'),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  )
                )
              )
            ],
          ),
        )
      )
    );
  }
}
