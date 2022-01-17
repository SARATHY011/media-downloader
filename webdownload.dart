import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:mediadownloader/webdownload.dart';
import 'package:mediadownloader/html.dart';

import 'package:path_provider/path_provider.dart';
import 'package:uri/uri.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';


class webpage1 extends StatefulWidget {
  String value ;
  webpage1({key,required this.value }) : super(key: key);
  @override
  void initializeDownloader() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(debug: true // optional: set false to disable printing logs to console
    );}
  _webpage1State createState() => _webpage1State(value);
}

class _webpage1State extends State<webpage1> {
  String value;
  _webpage1State(this.value);
  bool downloading = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
appBar: AppBar(
title: Text('no content? press here=>'),
  actions: [
    RaisedButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ff(value: value,)));
    },)
  ],
),

      body:
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl:value,
          ),

        floatingActionButton: FloatingActionButton(
              child: Icon(Icons.download),
              onPressed:() async {
                Directory tempDir = await getTemporaryDirectory();
                String tempPath = tempDir.path;

                Directory appDocDir = await getApplicationDocumentsDirectory();
                String appDocPath = appDocDir.path;

                await FlutterDownloader.enqueue(url: value,
                  savedDir: appDocPath,
                  showNotification: true,
                  // show download progress in status bar (for Android)
                  openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                ).whenComplete(() {
                  setState(() {
                    downloading = false; // set to false to stop Progress indicator
                  });
                }
                );
              }

)

      );
  }
  }