import 'package:flutter/material.dart';
import 'package:news_apps/utils/size_config.dart';

class ExploreNewsScreen extends StatefulWidget {
  @override
  _ExploreNewsScreenState createState() => _ExploreNewsScreenState();
}

class _ExploreNewsScreenState extends State<ExploreNewsScreen> {
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
      body: Center(
        child: Text('test'),
      )
    );
  }
}
