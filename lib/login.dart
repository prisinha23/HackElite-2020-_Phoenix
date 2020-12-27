import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hack_athon/database/getvalue.dart';
import 'package:hack_athon/profilefolder/dashboard.dart';

class Login extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SIGN IN'),
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
                backgroundImage: AssetImage("lottie/loginpg.png"),
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

                        decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                      SizedBox(
                        height: 25.0,
                        width: 25.0,
                      ),
                      TextFormField(
                        //on changed here//
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
                            labelText: 'Password',
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
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: _email, password: _password);
                                print('Done');
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: Text('Signed In'),
                                          content: Text(
                                              'Welcome to Covac For Vaccine Distribution'),
                                          actions: <Widget>[
                                            FlatButton( onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Dashboard()));
                                              },
                                              child: Text('Continue'),
                                            )
                                          ],
                                        ));
                              } catch (e) {
                                print(e.toString());
                                _email = "";
                                _password = "";
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: Text('Sign In'),
                                          content: Text('Error:$e'),
                                        ));
                              }
                            },
                            minWidth: 200.0,
                            height: 42.0,
                            child: Text(
                              'Sign In',
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
