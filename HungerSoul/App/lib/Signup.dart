import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'volunteer_dashboard/volenteer_dashboard.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_donation_app/TrackingPage.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);
  static String id = 'signup-page';
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isDonorUser = true;
  String? _email;
  String? _password;

  @override

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    if (_isDonorUser) {
      createdonorUser(_email,_password);
    } else {
      createvolunteerUser(_email,_password);
    }
  }

  createdonorUser(email,pass) async{
      try{
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email,
          password: pass,
        );
        if(credential!=null){
          Navigator.pushNamed(context, Home.id);
        }
      }
      catch(e){
        print(e);
      }
    }

  createvolunteerUser(email,pass)async{
    try{
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      if(credential!=null){
        Navigator.pushNamed(context, VolunteerDashboard.id);
      }
    }
    catch(e){
      print(e);
    }

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xFFE7ECF8),
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 20, left: 13, right: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "HungerSoul",
                  style: (TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 21,
                      color: Color(0xFF1F284D))),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Sign in',
                    style: TextStyle(color: Color(0xFF1F284D),
                      fontSize: 19,
                      fontFamily: 'Pacifico',),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: const Color(0xFFE7ECF8),
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Image.asset(
                    'assets/HungerSoul (1).png',
                    height: 300,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Color(0xFF1F284D)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFF1F284D)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFF1F284D)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFF1F284D)),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Color(0xFF1F284D)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFF1F284D)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFF1F284D)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFF1F284D)),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(color: Color(0xFF1F284D)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFF1F284D)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFF1F284D)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFF1F284D)),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Sign up'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Color(0xFF1F284D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      OutlinedButton.icon(
                        onPressed: () {
                          // Sign in with Google
                        },
                        icon: Icon(Icons.login_rounded),
                        label: Text('Sign up with Google'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Color(0xFF1F284D),
                          side: BorderSide(color: Color(0xFF1F284D)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                )

/*Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: SignInButton(

                    Buttons.Google,
                    text: "Sign up with google",
                    onPressed: () {},
                  ),
                ),*/
// with custom text
              ],
            ),
          ),
        ),
      ),
    );
  }
}
