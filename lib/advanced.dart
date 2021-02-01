import 'package:new2048/extreme.dart';
import 'package:new2048/grid_properties.dart';
import 'package:new2048/hard.dart';
import 'package:new2048/normal.dart';
import 'package:flutter/material.dart';

class Advanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orange,
        title: Text(
          "Advanced 2048",
          style: TextStyle(fontSize: 30),
        ),
      ),
      backgroundColor: tan,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Normal()));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: orange,
                    borderRadius: BorderRadius.circular(cornerRadius),
                  ),
                  height: 80,
                  width: 400,
                  child: Text(
                    "Normal",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Hard()));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: orange,
                    borderRadius: BorderRadius.circular(cornerRadius),
                  ),
                  height: 80,
                  width: 400,
                  child: Text("Hard",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Extreme()));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: orange,
                    borderRadius: BorderRadius.circular(cornerRadius),
                  ),
                  height: 80,
                  width: 400,
                  child: Text("Extreme",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
