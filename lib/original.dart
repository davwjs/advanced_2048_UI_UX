import 'package:new2048/grid_properties.dart';
import 'package:new2048/six_by_six.dart';
import 'package:new2048/three_by_three.dart';
import 'package:flutter/material.dart';

import 'eight_by_eight.dart';
import 'five_by_five.dart';
import 'four_by_four.dart';

class Original extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orange,
        title: Text(
          "Original 2048",
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
                      MaterialPageRoute(builder: (context) => ThreeByThree()));
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
                    "3 X 3",
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
                      MaterialPageRoute(builder: (context) => FourByFour()));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: orange,
                    borderRadius: BorderRadius.circular(cornerRadius),
                  ),
                  height: 80,
                  width: 400,
                  child: Text("4 X 4",
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
                      MaterialPageRoute(builder: (context) => FiveByFive()));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: orange,
                    borderRadius: BorderRadius.circular(cornerRadius),
                  ),
                  height: 80,
                  width: 400,
                  child: Text("5 X 5",
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
                      MaterialPageRoute(builder: (context) => SixBySix()));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: orange,
                    borderRadius: BorderRadius.circular(cornerRadius),
                  ),
                  height: 80,
                  width: 400,
                  child: Text("6 X 6",
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
                      MaterialPageRoute(builder: (context) => EightByEight()));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: orange,
                    borderRadius: BorderRadius.circular(cornerRadius),
                  ),
                  height: 80,
                  width: 400,
                  child: Text("8 X 8",
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