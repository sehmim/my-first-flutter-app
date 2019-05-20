import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

void main() => runApp(RealWorldApp());

class RealWorldApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RealWorldAppState();
  }
}

class RealWorldAppState extends State<RealWorldApp> {
  var _isLoading = false;

  var fetchedDataVideos;
  _httpCall() async {
    final url = "https://api.letsbuildthatapp.com/youtube/home_feed";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _isLoading = false;
        this.fetchedDataVideos = data["videos"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('RealWorldApp'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              _httpCall();
            },
          )
        ],
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: this.fetchedDataVideos == null
                    ? 0
                    : this.fetchedDataVideos.length,
                itemBuilder: (BuildContext context, i) {
                  final videoEach = this.fetchedDataVideos[i];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.network(videoEach["imageUrl"]),
                      Text(videoEach["name"]),
                      Divider()
                    ],
                  );
                },
              ),
      ),
    ));
  }
}
