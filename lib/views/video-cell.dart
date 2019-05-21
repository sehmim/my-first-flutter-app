import 'package:flutter/material.dart';

class VideoCell extends StatelessWidget {
  final videoMap;
  VideoCell(this.videoMap);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(videoMap["imageUrl"]),
                Text(videoMap["name"]),
              ],
            )),
      ],
    );
  }
}
