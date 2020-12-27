import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hack_athon/profilefolder/instantvaccine.dart';
import 'package:hack_athon/profilefolder/profilesection.dart';
import 'package:hack_athon/splashscreen.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String place;
  String issue;
  String name;
  String contact;
  int date = 1;
  int value;
  String count;
  static String email = FirebaseAuth.instance.currentUser.email;
  DocumentReference db =
      FirebaseFirestore.instance.collection('users').doc(email);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
        stream: db.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          place = snapshot.data["district"].toString().toUpperCase();
          issue = snapshot.data["issue"];
          print(place);
          print(issue);
          DocumentReference fb = FirebaseFirestore.instance
              .collection(place)
              .doc('user')
              .collection(issue)
              .doc(email);
          return StreamBuilder(
            stream: fb.snapshots(),
            builder: (context, base) {
              if (!base.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              name = base.data["name"].toString().toUpperCase();
              contact = base.data["contact"].toString();
              count = base.data["vaccine_count"];
              value = int.parse(count);
              print(name);
              print(contact);
              print(value);
              if (value < 10) {
                date = 1;
              } else if (value > 10 && value < 20) {
                date = 2;
              } else if (value > 10 && value < 30) {
                date = 3;
              } else if (value > 30 && value < 40) {
                date = 4;
              } else if (value > 40 && value < 50) {
                date = 5;
              } else if (value > 50 && value < 60) {
                date = 6;
              } else {
                date = 10;
              }
              return Scaffold(
                body: Stack(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.31,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              alignment: Alignment.topCenter,
                              image:
                                  AssetImage('lottie/images/top_header.png'))),
                    ),
                    Container(
                      height: size.height * 1,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              alignment: Alignment.bottomCenter,
                              image: AssetImage('lottie/images/bottom.png'))),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SafeArea(
                          child: Column(
                        children: <Widget>[
                          Container(
                            height: 64,
                            margin: EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                      AssetImage('lottie/images/User.png'),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      name,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Montserrat Medium",
                                          color: Colors.black),
                                    ),
                                    Text(
                                      contact,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontFamily: "Montserrat Medium",
                                          color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            primary: false,
                            children: <Widget>[
                              Card(
                                  margin: EdgeInsets.only(top: 50, left: 15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: Colors.transparent,
                                  elevation: 0,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Profile()));
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        SvgPicture.asset(
                                          "lottie/images/userpic.svg",
                                          height: 101,
                                        ),
                                        //Text(""),
                                        Text(
                                          'Profile',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Montserrat Regular',
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  )),
                              Card(
                                margin: EdgeInsets.only(top: 50, left: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.transparent,
                                elevation: 0,
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: const Text(
                                                  'Days Left For Vaccination'),
                                              content: Text(date.toString() +
                                                  "\t" +
                                                  "Days Are Left for Your Vaccination"),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, 'Ok');
                                                  },
                                                  child: Text('Ok'),
                                                ),
                                              ],
                                            ));
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        "lottie/images/date.svg",
                                        height: 101,
                                      ),
                                      //Text(""),
                                      Text(
                                        '$date Days Left',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Montserrat Regular',
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                margin: EdgeInsets.only(top: 0, left: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.transparent,
                                elevation: 0,
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Instant()));
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        SvgPicture.asset(
                                          "lottie/images/vaccine.svg",
                                          height: 101,
                                          width: 70,
                                        ),
                                        //Text(""),
                                        Text(
                                          'Instant Vaccine Demand',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Montserrat Regular',
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )),
                              ),
                              Card(
                                margin: EdgeInsets.only(top: 0, left: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.transparent,
                                elevation: 0,
                                child: InkWell(
                                    onTap: () {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  title: const Text('Sign Out'),
                                                  content: const Text(
                                                      'Are You Sure You Want To SignOut'),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      onPressed: () async {
                                                        print(FirebaseAuth
                                                            .instance
                                                            .currentUser
                                                            .email);
                                                        print(FirebaseAuth
                                                            .instance
                                                            .currentUser
                                                            .uid);
                                                        await FirebaseAuth
                                                            .instance
                                                            .signOut();
                                                        exit(0);
                                                      },
                                                      child: Text('Yes'),
                                                    ),
                                                  ],
                                                ));
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.logout,
                                          size: 100,
                                          color: Colors.red,
                                        ),
                                        //Text(""),
                                        Text(
                                          'SignOut',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.red,
                                              fontFamily: 'Montserrat Regular',
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )),
                              )
                            ],
                          ))
                        ],
                      )),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
