import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/HallInfo/Hall_History/HallHistoryPart1.dart';

import '../../colorScheme.dart';
import '../../SignInSignUp/email_login.dart';
import '../../HomePage/home.dart';
import 'HallHistoryPart2.dart';
import 'HallHistoryPart3.dart';
import 'HallHistoryPart4.dart';
import 'dart:math';

class HallHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget hallHistoryBlocks(
        String imgName, String title, String subtitle, StatelessWidget Page) {
      return Row(
          key: Key('Hall History block'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/image/$imgName',
              width: 170,
            ),
            SizedBox(width: 10.0),
            ElevatedButton(
              key: Key('Sample history button'),
              style: ElevatedButton.styleFrom(
                primary: KELightRed,
              ),
              child: Container(
                  width: 160.0,
                  height: 120.0,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 2.0),
                      Text(title,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: KERed)),
                      SizedBox(height: 5.0),
                      Text(subtitle,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: KERed)),
                      SizedBox(height: 10.0),
                      Expanded(
                        child: Container(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "view more >>",
                              style: TextStyle(
                                color: KERed,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Page));
              },
            ),
          ]);
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: CustomPaint(
            painter: PathPainter(),
          ),
        ),
        Positioned(
          top: 25,
          left: 15,
          child: IconButton(
            key: Key('Back Button'),
            icon: Icon(Icons.arrow_back_rounded, color: KERed, size: 30),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Positioned(
          top: 25,
          right: 55,
          child: IconButton(
            icon: Icon(Icons.home_rounded, color: KERed, size: 30),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                  (Route<dynamic> route) => false);
            },
          ),
        ),
        Positioned(
          top: 25,
          right: 15,
          child: IconButton(
            icon: Icon(
              Icons.exit_to_app_rounded,
              color: KERed,
              size: 30,
            ),
            onPressed: () {
              logOutNotice(context);
            },
          ),
        ),
        Positioned(
          top: 75,
          left: 25,
          child: Text(
            "Hall History",
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: KERed),
          ),
        ),
        Positioned(
          top: 125,
          left: 25,
          right: 25,
          child: Container(
            padding: EdgeInsets.only(right: 12),
            width: MediaQuery.of(context).size.width,
            child: Text(
              "History of King Edward VII Hall",
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: KERed),
            ),
          ),
        ),
        Positioned(
            top: 150,
            left: 10,
            right: 10,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.78,
              margin: EdgeInsets.only(top: 10.0),
              child: ListView(
                  key: Key('Scrollable History'),
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    hallHistoryBlocks(
                        "KingEdwardFMS.jpg",
                        "Federated Malay States Hostel",
                        "Sepoy Lines (1916-1956)",
                        HallHistoryPart1()),
                    Container(
                        key: Key('first stage'),
                        child: Align(
                          alignment: Alignment(0.6, 0.6),
                          child: Transform.rotate(
                              angle: 270 * pi / 180,
                              child: Icon(
                                Icons.arrow_back_rounded,
                                size: 50,
                              )),
                        )),
                    hallHistoryBlocks("KingEdwardHolneChase.jpg", "Holne Chase",
                        "Grange Road (1938-1956)", HallHistoryPart2()),
                    Container(
                        key: Key('second stage'),
                        child: Align(
                          alignment: Alignment(0.6, 0.6),
                          child: Transform.rotate(
                              angle: 270 * pi / 180,
                              child: Icon(
                                Icons.arrow_back_rounded,
                                size: 50,
                              )),
                        )),
                    hallHistoryBlocks(
                        "KingEdwardOld.jpg",
                        "King Edward VII Hall",
                        "Sepoy Lines, 12 College Road (1957-1987)",
                        HallHistoryPart3()),
                    Container(
                        key: Key('third stage'),
                        child: Align(
                          alignment: Alignment(0.6, 0.6),
                          child: Transform.rotate(
                              angle: 270 * pi / 180,
                              child: Icon(
                                Icons.arrow_back_rounded,
                                size: 50,
                              )),
                        )),
                    Container(
                        key: Key('fourth stage'),
                        child: hallHistoryBlocks(
                            "KE7HallHistory.jpg",
                            "King Edward VII Hall",
                            "1A Kent Ridge Road (1987-Present)",
                            HallHistoryPart4())),
                  ]),
            ))
      ]),
    );
  }

  void logOutNotice(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("Are you sure you want to Log Out?", style: TextStyle(fontWeight: FontWeight.bold, color: KERed),),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            print("Cancel");
            Navigator.of(context).pop(false);
          },
          child: Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold, color: KERed),),
        ),
        FlatButton(
          onPressed: () {
            print("Logout");
            FirebaseAuth auth = FirebaseAuth.instance;
            auth.signOut().then((res) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => EmailLogIn()),
                      (Route<dynamic> route) => false);
            });
          },
          child: Text('Logout', style: TextStyle(fontWeight: FontWeight.bold, color: KERed),),
        )
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint();
    paint.color = KELightYellow;

    Path path = new Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.3, 0);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.03,
        size.width * 0.42, size.height * 0.17);
    path.quadraticBezierTo(
        size.width * 0.35, size.height * 0.32, 0, size.height * 0.29);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

Container categoryContainer(String imgName, String title) {
  return Container(
      width: 130,
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/image/$imgName',
            height: 150.0,
            width: 150.0,
          ),
          Text(
            "$title",
            style: TextStyle(
                fontWeight: FontWeight.w800, fontSize: 17, color: Colors.black),
          )
        ],
      ));
}
