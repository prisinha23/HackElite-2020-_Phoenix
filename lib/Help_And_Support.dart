import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Help extends StatefulWidget {
  Help({Key key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  String mail;
  String problem;

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HELP DESK'),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Lottie.asset('lottie/help.json'),
                      height: 180.0,
                      margin: EdgeInsets.all(10.0),
                    ),
                  ),
                ],
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
                            labelText: 'EMAIL ID',
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
                          mail = value;
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
                          }
                          return null;
                        },
                        onChanged: (value) {
                          problem = value;
                        },
                        maxLines: 3,
                        decoration: InputDecoration(
                            labelText: 'PROBLEM FACED',
                            prefixIcon: Icon(Icons.line_style),
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
                                  await FirebaseFirestore.instance
                                      .collection('help')
                                      .doc(mail)
                                      .set({'email': mail, 'problem': problem});
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: Text('Help And Support'),
                                            content: Text(
                                                'Your Problem Has been Registeres We will Reach you Soon.... \nThank You..'),
                                          ));
                                } catch (e) {
                                  print(e);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: Text('Help And Support'),
                                            content: Text(e.toString()),
                                          ));
                                }
                              }
                            },
                            minWidth: 200.0,
                            height: 42.0,
                            child: Text(
                              'POST',
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
