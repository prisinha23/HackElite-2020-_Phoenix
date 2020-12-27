import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hack_athon/Help_And_Support.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String place;
  String issue;
  String name;
  String contact;
  String age;
  int date = 1;
  int value;
  String count;
  String mail;
  String problem;
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
              name = base.data["name"];
              contact = base.data["contact"].toString();
              age = base.data["age"].toString();
              place = base.data["place"].toString().toUpperCase();
              count = base.data["vaccine_count"];
              value = int.parse(count);
              print(name);
              print(count);
              print(age);
              print(place);
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
                            image: AssetImage('lottie/images/top_header.png'))),
                  ),
                  Container(
                    height: size.height * 1,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            alignment: Alignment.bottomCenter,
                            image: AssetImage(
                              'lottie/images/personal_image.png',
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topCenter,
                          height: size.height * 0.2,
                          child: CircleAvatar(
                            radius: 90,
                            backgroundImage:
                                AssetImage('lottie/images/user2.png'),
                          ),
                        ),
                        Text(
                          name,
                          style: TextStyle(
                              fontFamily: 'Montserrat Medium',
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        ListTile(
                          leading: Icon(Icons.tag_faces),
                          title: Text(
                            'Age     : $age',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat Medium'),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        ListTile(
                          leading: Icon(Icons.location_city_rounded),
                          title: Text(
                            'Place  :  $place',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat Medium'),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        ListTile(
                          leading: Icon(Icons.confirmation_num),
                          title: Text(
                            'Listed Number :  $count',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat Medium'),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        ListTile(
                          leading: Icon(Icons.date_range_rounded),
                          title: Text(
                            'Days Left :  $date',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat Medium'),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Material(
                            color: Colors.blueAccent,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Help()));
                              },
                              minWidth: 200.0,
                              height: 42.0,
                              child: Text(
                                'Help Section',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat Medium'),
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ));
            },
          );
        },
      ),
    );
  }
}
