import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'reg1.dart';
import 'package:lottie/lottie.dart';
import 'login.dart';

class Reg0 extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EMAIL REGISTRATION'),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage("lottie/mainimg.png"),
                radius: 105.0,
              ),
              SizedBox(
                height: 45.0,
                width: 45.0,
              ),
              Container(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        //on changed here//

                        decoration: InputDecoration(
                            labelText: 'enter Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        validator: (value) {
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value.toString())) {
                            return 'Enter a Valid Email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _email = value;
                        },
                      ),
                      SizedBox(
                        height: 25.0,
                        width: 25.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Fill this Section';
                          } else if (value.length < 6) {
                            return 'Password Small(Enter 6 Letters Password)';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _password = value;
                        },
                        decoration: InputDecoration(
                            labelText: 'Enter your password',
                            prefixIcon: Icon(Icons.security),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                      SizedBox(
                        height: 25.0,
                        width: 25.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Material(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(30.0),
                          elevation: 5.0,
                          child: MaterialButton(
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                try {
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: _email, password: _password);
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(_email)
                                      .set({
                                    'email': _email,
                                    'password': _password,
                                    'district': "",
                                    'issue': "",
                                    'age': 0,
                                  });
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: Text('Email is Registered'),
                                            content: Text(
                                                'Your Entered Mail has been Registered'),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Continue'),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Reg1()));
                                                },
                                              )
                                            ],
                                          ));
                                } catch (e) {
                                  _email = "";
                                  _password = "";
                                  print(e.toString());
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: Text(
                                                'Error During Registration'),
                                            content:
                                                Text('Could Not Register:$e'),
                                          ));
                                }
                              }
                            },
                            minWidth: 200.0,
                            height: 42.0,
                            child: Text(
                              'Enter',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
