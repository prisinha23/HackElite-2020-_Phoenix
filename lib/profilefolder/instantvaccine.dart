import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class Instant extends StatefulWidget {
  Instant({Key key}) : super(key: key);

  @override
  _InstantState createState() => _InstantState();
}

class _InstantState extends State<Instant> {
  String uid = FirebaseAuth.instance.currentUser.email;
  final _formkey = GlobalKey<FormState>();
  File _imagefile;
  final ImagePicker _picker = ImagePicker();
  String url;
  String name;
  String contact;
  String location;

  Future openGallery() async {
    final PickedFile pickedFile =
        await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imagefile = File(pickedFile.path);
    });
    try {
      await FirebaseStorage.instance.ref(uid).putFile(_imagefile);
      await FirebaseStorage.instance.ref(uid).getDownloadURL().then((urlfile) {
        setState(() {
          url = urlfile;
        });
      });
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Health Report '),
                content: Text(
                    ' Your Report Has Been Uploaded \n We Will Verify it Soon...'),
              ));
      print('Done');
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
              title: Text('Health Report '), content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('INSTANT VACCINE REQUIREMNET'),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        //on changed here//
                        onChanged: (value) {
                          name = value;
                        },
                        decoration: InputDecoration(
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Fill this Field';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 25.0,
                        width: 25.0,
                      ),
                      TextFormField(
                        //on changed here//
                        onChanged: (value) {
                          contact = value;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Contact',
                            prefixIcon: Icon(Icons.contact_phone),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Fill this Section';
                          }
                          if (!(value.length == 10)) {
                            return 'Not valid Number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 25.0,
                        width: 25.0,
                      ),
                      TextFormField(
                        //on changed here//
                        onChanged: (value) {
                          location = value;
                        },
                        decoration: InputDecoration(
                            labelText: 'District',
                            prefixIcon: Icon(Icons.location_city),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Fill this Section';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 25.0,
                        width: 25.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.transparent),
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: InkWell(
                          onTap: () {
                            openGallery();
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.camera,
                                size: 84,
                                color: Colors.red[200],
                              ),
                              Text(
                                'Upload Your Health Report',
                                style: TextStyle(color: Colors.grey[700]),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                        width: 25.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Material(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30.0),
                          elevation: 5.0,
                          child: MaterialButton(
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                try {
                                  await FirebaseFirestore.instance
                                      .collection('instant')
                                      .doc(location.toUpperCase())
                                      .collection('users')
                                      .doc(uid)
                                      .set({
                                    'name': name,
                                    'email': uid,
                                    'contact': contact,
                                    'location': location,
                                    'health_report': url
                                  });
                                  String capsname = name.toUpperCase();
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title:
                                                Text('INSTANT VACCINE DEMAND'),
                                            content: Text(
                                                ' Your instant Vaccine Demand has been Accepted \n We Will Receach You Soon....\n$capsname '),
                                          ));
                                } catch (e) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title:
                                                Text('INSTANT VACCINE DEMAND'),
                                            content: Text(e.toString()),
                                          ));
                                }
                              }
                            },
                            minWidth: 200.0,
                            height: 42.0,
                            child: Text(
                              'REQUEST VACCINE',
                              style: TextStyle(color: Colors.white),
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
