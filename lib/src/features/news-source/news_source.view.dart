import 'package:flutter/material.dart';
import 'package:news_apps/src/features/news-source/news_source.view_model.dart';
import 'package:news_apps/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsSourceScreen extends StatefulWidget {
  final String url;

  NewsSourceScreen({@required this.url});

  @override
  _NewsSourceScreenState createState() => _NewsSourceScreenState();
}

class _NewsSourceScreenState extends State<NewsSourceScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
      body: Consumer<NewsSourceViewModel>(
        builder: (_, model, __) {
          return Stack(
            children: [
              WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onPageStarted: (_) {
                  model.setStateLoading(true);
                },
                onPageFinished: (_) {
                  model.setStateLoading(false);
                },
              ),
              model.isLoading ? Center(
                child: CircularProgressIndicator(),
              ) : Stack()
            ],
          );
        }
      ),
    );
  }
}
