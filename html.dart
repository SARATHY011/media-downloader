import 'dart:convert';

import 'dart:async';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/dom_parsing.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:url_launcher/url_launcher.dart';


class ff extends StatefulWidget {
  String value ;
 ff({key,required this.value }) : super(key: key);


  @override
  _ffState createState() => _ffState(value);
}

class _ffState extends State<ff> {
  String value;
  _ffState(this.value);

  Future _getServiceHtmlData() async{

    return await http.get(Uri.parse(value));
  }
  String data = "hello";
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
      body: FutureBuilder(
          future: _getServiceHtmlData(),
          builder: (context, snapshot) {
            if(snapshot.hasData){

              return  Center(

                  child: SafeArea(child: Html(data: data)
                  )

              );


            }else{
              if(snapshot.connectionState==ConnectionState.waiting){
                return CircularProgressIndicator();
              }else{
                return Text('Error');
              }
            }
          }
      ),
    );
  }
}