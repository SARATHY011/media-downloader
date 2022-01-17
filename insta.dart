import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';



class HomePage extends StatefulWidget {
  String value ;
  HomePage({key,required this.value }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState(value);
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  String value;
  _HomePageState(this.value);
  FlutterInsta flutterInsta = FlutterInsta();

  bool downloading = false;

  @override
  void initState() {
    super.initState();

    downloadReels();
  }

  void initializeDownloader() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(debug: true // optional: set false to disable printing logs to console
    );
  }

  void downloadReels() async {
    var s = await flutterInsta.downloadReels("https://www.instagram.com/p/CDlGkdZgB2y");
    print(s);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title:  Text('INSTAGRAM Downloader')
        ),

      body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              downloading = true;
            });
            download();
          },
          child: Text("Download"),
        ),
        downloading
            ? Center(
          child: CircularProgressIndicator(), //if downloading is true show Progress Indicator
        )
            : Container()
      ],
      )
    );
  }


  void download() async {
    var myvideourl = await flutterInsta.downloadReels(value);
     final status =await Permission.storage.request();

      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
       await FlutterDownloader.enqueue(url: myvideourl, savedDir: appDocPath,
        showNotification: true, // show download progress in status bar (for Android)
        openFileFromNotification: true, // click on notification to open downloaded file (for Android)
      ).whenComplete(() {
      setState(() {
        downloading = false; // set to false to stop Progress indicator
      });
    } );
  }
}
