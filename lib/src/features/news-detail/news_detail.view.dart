import 'package:flutter/material.dart';
import 'package:news_apps/src/features/home/home.model.dart';
import 'package:news_apps/utils/size_config.dart';
import 'package:news_apps/utils/date_format.dart';

class NewsDetailScreen extends StatefulWidget {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final String content;
  final DateTime publishAt;

  NewsDetailScreen({
    @required this.source,
    @required this.author,
    @required this.title,
    @required this.description,
    @required this.url,
    @required this.imageUrl,
    @required this.content,
    @required this.publishAt
  });
  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print(widget.content);
    print(widget.description);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Koraindo",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Satisfy',
            fontSize: SizeConfig.safeBlockHorizontal * 6
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            width: double.infinity,
            height: SizeConfig.safeBlockVertical * 35,
            child: widget.imageUrl != null ? Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
            ) : Image.asset(
              "assets/images/preload.png",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 1),
            child: ListTile(
              title: Text(
                widget.author != null ? "${widget.author} - ${widget.source.name}" : widget.source.name,
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 5,
                ),
              ),
              subtitle: Text(
                dateFormat(widget.publishAt),
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 4
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: SizeConfig.safeBlockHorizontal * 4
            ),
            child: Column(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 5,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.safeBlockVertical * 2
                  ),
                  child: Text(
                    widget.content != null ? widget.content : widget.description,
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 4.5
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/news-source', arguments: widget.url);
                  },
                  child: Text(
                    "Lihat selengkapnya",
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 4,
                      color: Colors.blue
                    ),
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }
}
