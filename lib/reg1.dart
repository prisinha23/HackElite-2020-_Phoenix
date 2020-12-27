import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hack_athon/profilefolder/dashboard.dart';

class Reg1 extends StatefulWidget {
  @override
  _Reg1State createState() => _Reg1State();
}

class _Reg1State extends State<Reg1> {
  bool _checkbox = false;
  final _formkey = GlobalKey<FormState>();
  String _place;
  String _name;
  int _age;
  int _aadhar;
  int _contact;
  String uid = FirebaseAuth.instance.currentUser.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PERSONAL INFORMATION REGISTRATION'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.0,
                width: 30.0,
              ),
              TextFormField(
                //on changed here//
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Fill this Section';
                  }
                  return null;
                },
                onChanged: (value) {
                  _name = value;
                },
                decoration: InputDecoration(
                    labelText: 'Enter your Name',
                    prefixIcon: Icon(Icons.assignment_ind),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(
                height: 20.0,
                width: 20.0,
              ),
              TextFormField(
                //on changed here//
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Fill this Section';
                  } else if (value.length != 10) {
                    return 'Not a Valid Number';
                  } else if (!(value.startsWith('9', 0) ||
                          value.startsWith('8', 0)) ||
                      (value.startsWith('7', 0) || value.startsWith('6', 0))) {
                    return 'False Contact Number';
                  }
                  return null;
                },
                onChanged: (value) {
                  _contact = int.parse(value);
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Enter your contact number',
                    prefixIcon: Icon(Icons.add_call),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(
                height: 20.0,
                width: 20.0,
              ),
              TextFormField(
                //on changed here//
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Fill this Section';
                  }
                  return null;
                },
                onChanged: (value) {
                  _place = value;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: 'District',
                    prefixIcon: Icon(Icons.location_city),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(
                height: 20.0,
                width: 20.0,
              ),
              TextFormField(
                //on changed here//
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Fill this Section';
                  }
                  if (!(int.parse(value) > 0 && int.parse(value) < 200)) {
                    return 'Enter a valid Age';
                  }
                  return null;
                },
                onChanged: (value) {
                  _age = int.parse(value);
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Age',
                    prefixIcon: Icon(Icons.date_range),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(
                height: 20.0,
                width: 20.0,
              ),
              TextFormField(
                //on changed here//
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Fill this Section';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _aadhar = int.parse(value);
                },
                decoration: InputDecoration(
                    labelText: 'Enter Aadhar number',
                    prefixIcon: Icon(Icons.art_track),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(
                height: 20.0,
                width: 20.0,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.transparent),
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      checkColor: Colors.blue,
                      activeColor: Colors.white,
                      value: _checkbox,
                      onChanged: (value) {
                        setState(() {
                          _checkbox = value;
                        });
                      },
                    ),
                    Text(
                      'If suffering from any disease please Check',
                      style: TextStyle(color: Colors.grey[700]),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40.0,
                width: 40.0,
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
                        if (registration(_name, _contact, _place, _age, _aadhar,
                            _checkbox)) {
                          vaccinecount(_place, _age, _checkbox, uid);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: Text('Registration is Completed'),
                                    content: Text(
                                        ' Name:$_name \n Age:$_age \n Place:$_place'),
                                    actions: <Widget>[
                                      FlatButton( onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Dashboard()));
                                        },
                                        child: Text('I Am Ready'),
                                      )
                                    ],
                                  ));
                        }
                      }
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Register Me',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool registration(
      String name, int contact, String place, int age, int aadhar, bool value) {
    try {
      if (age < 16) {
        FirebaseFirestore.instance
            .collection(place.toUpperCase())
            .doc('user')
            .collection('child')
            .doc(uid)
            .set({
          'name': name,
          'contact': contact,
          'place': place,
          'age': age,
          'aadhar': aadhar,
          'issue': value,
          'vaccine_count': 0,
        });
      } else if (age > 17 && age < 55) {
        if (value == true) {
          FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('user')
              .collection('adult_health')
              .doc(uid)
              .set({
            'name': name,
            'contact': contact,
            'place': place,
            'age': age,
            'aadhar': aadhar,
            'issue': value,
            'vaccine_count': 0,
          });
        }
        if (value != true) {
          FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('user')
              .collection('adult_fine')
              .doc(uid)
              .set({
            'name': name,
            'contact': contact,
            'place': place,
            'age': age,
            'aadhar': aadhar,
            'issue': value,
            'vaccine_count': 0,
          });
        }
      } else if (age > 55) {
        if (value == true) {
          FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('user')
              .collection('old_health')
              .doc(uid)
              .set({
            'name': name,
            'contact': contact,
            'place': place,
            'age': age,
            'aadhar': aadhar,
            'issue': value,
            'vaccine_count': 0,
          });
        }
        if (value != true) {
          FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('user')
              .collection('old_fine')
              .doc(uid)
              .set({
            'name': name,
            'contact': contact,
            'place': place,
            'age': age,
            'aadhar': aadhar,
            'issue': value,
            'vaccine_count': 0,
          });
        }
      }

      print('created Registration');
    } catch (e) {
      _name = "";
      _aadhar = 0;
      _age = 0;
      _place = "";
      _checkbox = false;
      _contact = 0;
      print(e.toString());
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Error During Registration'),
                content: Text('Could Not Register:$e'),
              ));
    }
    return true;
  }

  vaccinecount(String place, int age, bool checkbox, String email) async {
    try {
      if (age < 17) {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection(place.toUpperCase())
            .doc('vaccine')
            .collection('old_fine')
            .doc('information')
            .get();
        DocumentSnapshot data = await FirebaseFirestore.instance
            .collection(place.toUpperCase())
            .doc('vaccine')
            .collection('old_health')
            .doc('information')
            .get();
        DocumentSnapshot data2 = await FirebaseFirestore.instance
            .collection(place.toUpperCase())
            .doc('vaccine')
            .collection('child')
            .doc('information')
            .get();
        String count1;
        String count2;
        String count3;
        count3 = data2['count'];
        count2 = data['count'];
        count1 = snapshot['count'];
        int value =
            int.parse(count1) + 1 + int.parse(count2) + int.parse(count3);
        count1 = value.toString();
        FirebaseFirestore.instance
            .collection(place.toUpperCase())
            .doc('vaccine')
            .collection('child')
            .doc('information')
            .set({'count': count1});
        FirebaseFirestore.instance
            .collection(place.toUpperCase())
            .doc('user')
            .collection('child')
            .doc(uid)
            .update({
          'vaccine_count': count1,
        });
        FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update({'district': place, 'issue': 'child'});
        print(count1);
        print(value);
      } else if (age > 17 && age < 55) {
        if (checkbox == true) {
          DocumentSnapshot snapshot = await FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('vaccine')
              .collection('old_health')
              .doc('information')
              .get();
          DocumentSnapshot data = await FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('vaccine')
              .collection('old_fine')
              .doc('information')
              .get();
          DocumentSnapshot data2 = await FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('vaccine')
              .collection('child')
              .doc('information')
              .get();
          DocumentSnapshot data3 = await FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('vaccine')
              .collection('adult_health')
              .doc('information')
              .get();
          String count;
          String count2;
          String count3;
          String count4;
          count3 = data2['count'];
          count4 = data3['count'];
          count2 = data['count'];
          count = snapshot['count'];
          int value = int.parse(count) +
              1 +
              int.parse(count2) +
              int.parse(count3) +
              int.parse(count4);
          count = value.toString();
          FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('vaccine')
              .collection('adult_health')
              .doc('information')
              .set({'count': count});
          FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('user')
              .collection('adult_health')
              .doc(uid)
              .update({'vaccine_count': count});
          FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .update({'district': place, 'issue': 'adult_health'});
          print(count);
          print(value);
        } else {
          DocumentSnapshot snapshot = await FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('vaccine')
              .collection('old_health')
              .doc('information')
              .get();
          DocumentSnapshot data = await FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('vaccine')
              .collection('old_fine')
              .doc('information')
              .get();
          DocumentSnapshot data1 = await FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('vaccine')
              .collection('child')
              .doc('information')
              .get();
          DocumentSnapshot data2 = await FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('vaccine')
              .collection('adult_health')
              .doc('information')
              .get();
          DocumentSnapshot data3 = await FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('vaccine')
              .collection('adult_fine')
              .doc('information')
              .get();
          String count;
          String count2;
          String count3;
          String count4;
          String count5;
          count3 = data1['count'];
          count4 = data2['count'];
          count5 = data3['count'];
          count2 = data['count'];
          count = snapshot['count'];
          int value = int.parse(count) +
              1 +
              int.parse(count2) +
              int.parse(count3) +
              int.parse(count4) +
              int.parse(count5);
          count = value.toString();
          FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('vaccine')
              .collection('adult_fine')
              .doc('information')
              .set({'count': count});
          FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('user')
              .collection('adult_fine')
              .doc(uid)
              .update({'vaccine_count': count});
          FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .update({'district': place, 'issue': 'adult_fine'});
          print(count);
          print(value);
        }
      } else if (age > 55) {
        if (checkbox == true) {
          DocumentSnapshot snapshot = await FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('vaccine')
              .collection('old_health')
              .doc('information')
              .get();
          String count;
          count = snapshot['count'];
          int value = int.parse(count) + 1;
          count = value.toString();
          FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('vaccine')
              .collection('old_health')
              .doc('information')
              .set({'count': count});
          FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('user')
              .collection('old_health')
              .doc(uid)
              .update({'vaccine_count': count});
          FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .update({'district': place, 'issue': 'old_health'});
          print(count);
          print(value);
        } else {
          DocumentSnapshot snapshot = await FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('vaccine')
              .collection('old_health')
              .doc('information')
              .get();
          DocumentSnapshot data = await FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('vaccine')
              .collection('old_fine')
              .doc('information')
              .get();
          String count;
          String count2;
          count2 = data['count'];
          count = snapshot['count'];
          int value = int.parse(count) + 1 + int.parse(count2);
          count = value.toString();
          FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('vaccine')
              .collection('old_fine')
              .doc('information')
              .set({'count': count});
          FirebaseFirestore.instance
              .collection(place.toUpperCase())
              .doc('user')
              .collection('old_fine')
              .doc(uid)
              .update({'vaccine_count': count});
          FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .update({'district': place, 'issue': 'old_fine'});
          print(count);
          print(value);
        }
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text('Registration is Completed'),
                  content: Text(' Name:$_name \n Age:$age \n Place:$place'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard()));
                      },
                      child: Text('I Am Ready'),
                    )
                  ],
                ));
      }
    } catch (e) {
      print(e.toString());
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Error During Registration'),
                content: Text('Could Not Register:$e'),
              ));
    }
    print(email);
    print(place);
    print(uid);
    print('done');
    return true;
  }
}
