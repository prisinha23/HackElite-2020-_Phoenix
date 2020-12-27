import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hack_athon/profilefolder/profilesection.dart';
import 'package:hack_athon/splashscreen.dart';

import 'Help_And_Support.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                        backgroundImage: AssetImage('lottie/images/User.png'),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'Kunal',
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: "Montserrat Medium",
                                color: Colors.white),
                          ),
                          Text(
                            '12345',
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
                            mainAxisAlignment: MainAxisAlignment.center,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            "lottie/images/date.svg",
                            height: 101,
                          ),
                          //Text(""),
                          Text(
                            'Days Remaining',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Montserrat Regular',
                                fontWeight: FontWeight.bold),
                          )
                        ],
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
                                    builder: (context) => Help()));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                "lottie/images/help.svg",
                                height: 101,
                                width: 70,
                              ),
                              //Text(""),
                              Text(
                                'Help',
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
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text('Sign Out'),
                                      content: const Text(
                                          'Are You Sure You Want To SignOut'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('No'),
                                          onPressed: () {
                                            Navigator.pop(context, 'No');
                                          },
                                        ),
                                        FlatButton(
                                          onPressed: () {
                                            print(FirebaseAuth
                                                .instance.currentUser.email);
                                            print(FirebaseAuth
                                                .instance.currentUser.uid);
                                            FirebaseAuth.instance.signOut();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SplashScreen()));
                                          },
                                          child: Text('Yes'),
                                        ),
                                      ],
                                    ));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.logout,
                                size: 84,
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
          )
        ],
      ),
    );
  }
}
