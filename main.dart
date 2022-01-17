import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:mediadownloader/webdownload.dart';

import 'package:uri/uri.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'insta.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: text(),
    );
  }
}

class text extends StatefulWidget {

  const text({Key? key}) : super(key: key);

  @override
  _textState createState() => _textState();
}


class _textState extends State<text> {
  TextEditingController controller = TextEditingController();
String resuly = '';
  Future _getServiceHtmlData() async{

    return await http.get(Uri.parse(resuly));}
  late Future _future;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = _getServiceHtmlData();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Media Downloader'),
        backgroundColor: Colors.limeAccent
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(controller: controller,
            decoration: InputDecoration(
              hintText: 'URL goes here'
            ),
          ),
          RaisedButton(child: Icon(Icons.gps_not_fixed_outlined),
              onPressed: () async {setState(() {
                resuly= controller.text;
              });
            String lauch1 = Uri.parse(resuly).host;
                String launc2 = Uri.parse('https://www.instagram.com/p/CDlGkdZgB2y').host;
                if(launc2==lauch1){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(value:resuly),
                  ),

                  );
                }else

                  {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>webpage1(value:resuly)));
                }
         }
     )

        ],
      ),
    );

  }
}

