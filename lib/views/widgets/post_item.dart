import 'dart:math';

import 'package:flutter/material.dart';
import 'package:social_app_ui/homedance.dart';

import 'package:social_app_ui/main.dart';

class PostItem extends StatefulWidget {
  final String dp;
  final String name;
  final String time;
  final String img;
  final String caption;

  PostItem(
      {Key key,
      @required this.dp,
      @required this.caption,
      @required this.name,
      @required this.time,
      @required this.img})
      : super(key: key);
  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  static Random random = Random();
  String x = (random.nextInt(10) + 10).toString();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                  "${widget.dp}",
                ),
              ),
              contentPadding: EdgeInsets.all(0),
              title: Text(
                "${widget.name}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                "${widget.time}",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 11,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Scored $x k points, beat his score',
                  style: TextStyle(fontSize: 16),
                ),
                Container(
                  color: Colors.greenAccent,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return HomeDancePage(cameras);
                      }));
                    },
                    child: Text(
                      'Accept',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
            Image.asset(
              "${widget.img}",
              height: 170,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
