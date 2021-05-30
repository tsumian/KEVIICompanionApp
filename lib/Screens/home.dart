import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/AddBooking.dart';
import 'package:keviiapp/Panels/homePanel.dart';
import 'package:keviiapp/Screens/FacilitiesBookingPage.dart';
import 'package:keviiapp/Screens/accountPage.dart';
import 'package:keviiapp/Screens/email_login.dart';

import 'LatestNewsPage.dart';

class Home extends StatefulWidget {
  Home({this.uid});

  final String uid;

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final String title = "KEVII Community";
  User user = FirebaseAuth.instance.currentUser;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF820312),
      appBar: AppBar(
        backgroundColor: Color(0xFF820312),
        elevation: 0.0,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.w600,
            fontSize: 30.0,
            fontFamily: 'Montserrat',
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.amber,
            ),
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut().then((res) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => EmailLogIn()),
                    (Route<dynamic> route) => false);
              });
            },
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.0),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text(
                        "Welcome ",
                        style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.amber,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }
                    Map<String, dynamic> data = snapshot.data.data();
                    return Text(
                      "Welcome ${data['nusid']}",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.amber,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
                Expanded(
                    child: Column(children: [
                  DefaultTabController(
                      length: (4),
                      child: Expanded(
                          child: Column(children: [
                        TabBar(
                            indicatorColor: Colors.amber,
                            unselectedLabelColor: Colors.amberAccent,
                            labelColor: Colors.white,
                            labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
                            tabs: [
                              Tab(text: "Latest Events"),
                              Tab(
                                text: "Hall Info",
                              ),
                              Tab(text: "CCA Info"),
                              Tab(text: "Facilities")
                            ]),
                        SizedBox(height: 20.0),
                        Container(
                            height: 410.0,
                            child: TabBarView(children: [
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('Home Panel News')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: Text("Loading"),
                                      );
                                    }
                                    return Container(
                                        child: ListView.builder(
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot document =
                                            snapshot.data.docs[index];
                                        return homePanel(
                                            document['ImageURL'],
                                            document['Headline'],
                                            document['Subheading'],
                                            document['News'],
                                            LatestNewsPage(document['Headline'],
                                                document['Subheading']));
                                      },
                                      scrollDirection: Axis.horizontal,
                                    ));
                                  }),
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('Hall Information')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Text('Loading, please wait');
                                    }
                                    return Container(
                                        child: ListView.builder(
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot document =
                                            snapshot.data.docs[index];
                                        return homePanel(
                                            document['ImageURL'],
                                            document['Headline'],
                                            document['Subheading'],
                                            document['News'],
                                            LatestNewsPage(document['Headline'],
                                                document['Subheading']));
                                      },
                                      scrollDirection: Axis.horizontal,
                                    ));
                                  }),
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('CCA Information')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Text('Loading, please wait');
                                    }
                                    return Container(
                                        child: ListView.builder(
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot document =
                                            snapshot.data.docs[index];
                                        return homePanel(
                                            document['ImageURL'],
                                            document['Headline'],
                                            document['Subheading'],
                                            document['News'],
                                            LatestNewsPage(document['Headline'],
                                                document['Subheading']));
                                      },
                                      scrollDirection: Axis.horizontal,
                                    ));
                                  }),
                              Container(
                                  child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                    homePanel(
                                      "https://scontent-xsp1-2.xx.fbcdn.net/v/t1.6435-9/149120258_1400615820287555_8073421677754248923_n.jpg?_nc_cat=104&ccb=1-3&_nc_sid=973b4a&_nc_ohc=6K0JZvb-_YgAX9YNiRP&_nc_ht=scontent-xsp1-2.xx&oh=49731e8e72eee2233b6834e268316740&oe=60D35263",
                                      "Check Current Bookings",
                                      "Click for bookings",
                                      "Empty",
                                      FacilitiesBookingPage(),
                                    ),
                                    homePanel(
                                      "https://scontent-xsp1-2.xx.fbcdn.net/v/t1.6435-9/161352609_1418565688492568_6792285338831241728_n.jpg?_nc_cat=101&ccb=1-3&_nc_sid=0debeb&_nc_ohc=9QLgA4qc2lwAX-YcnXO&_nc_ht=scontent-xsp1-2.xx&oh=16c93196e6e9c15d7f40f02d3e5126cd&oe=60D89D24",
                                      "Make A Booking",
                                      "Click to book",
                                      "Empty",
                                      FacilitiesBookingPage(),
                                    ),
                                  ]))
                            ]))
                      ])))
                ])),
              ])),
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          backgroundColor: Color(0xFF820312),
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.amber,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box),
              label: "Book",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded), label: "Account")
          ]),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class NavigateDrawer extends StatefulWidget {
  final String uid;

  NavigateDrawer({Key key, this.uid}) : super(key: key);

  @override
  _NavigateDrawerState createState() => _NavigateDrawerState();
}

class _NavigateDrawerState extends State<NavigateDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: FutureBuilder(
                future: FirebaseDatabase.instance
                    .reference()
                    .child("Users")
                    .child(widget.uid)
                    .once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.value['email']);
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            accountName: FutureBuilder(
                future: FirebaseDatabase.instance
                    .reference()
                    .child("Users")
                    .child(widget.uid)
                    .once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.value['name']);
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.home, color: Colors.black),
              onPressed: () => null,
            ),
            title: Text('Home'),
            onTap: () {
              print(widget.uid);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home(uid: widget.uid)),
              );
            },
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.settings, color: Colors.black),
              onPressed: () => null,
            ),
            title: Text('Settings'),
            onTap: () {
              print(widget.uid);
            },
          ),
        ],
      ),
    );
  }
}
