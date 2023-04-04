import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/Signup.dart';
import 'home_page.dart';
import 'volunteer_dashboard/volenteer_dashboard.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_donation_app/TrackingPage.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
  static String id = 'welcome-page';
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

Future<void> _FirebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("ham lol");
  print(message.notification!.title);
}

class _WelcomePageState extends State<WelcomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isDonorUser = true;
  String? _email;
  String? _password;
  //bool login = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //IF app is in background but running
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      //print("message received when app running");
      //print(message.data['step']);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FoodDonationTrackingPage(),
          settings: RouteSettings(arguments: message.data),
        ),
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      //print("message received when app running on background");
      //print(message.data['step']);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FoodDonationTrackingPage(),
          settings: RouteSettings(arguments: message.data),
        ),
      );
    });
    // IF app is in background but not running
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) => {
              if (message != null)
                {
                  //print("message received when app not running"),
                  //print(message.data['step']),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodDonationTrackingPage(),
                      settings: RouteSettings(arguments: message.data),
                    ),
                  )
                }
            });

    // Update app silently
    FirebaseMessaging.onBackgroundMessage(_FirebaseMessagingBackgroundHandler);
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    if (_isDonorUser) {
      authenticateDonorUser(_email,_password);
      // Validate donor user credentials and sign in
      // Navigate to donor user home page
    } else {
      authenticateVolunteerUser(_email,_password);
      // Validate volunteer user credentials and sign in
      // Navigate to volunteer user home page
    }
  }

  authenticateDonorUser(email,password)async{
    try{
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      if(user!=null){
        Navigator.pushNamed(context, Home.id);
      }
    }catch(e){
      print(e);
    }
  }

  authenticateVolunteerUser(email,password)async{
    try{
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      if(user!=null){
        Navigator.pushNamed(context, VolunteerDashboard.id);
      }
    }catch(e){
      print(e);
    }
  }

  var loggedemail;
  getcurrentuser()async{
    final user = await FirebaseAuth.instance.currentUser!.email;
    loggedemail.user;
  }
  @override
  Widget build(BuildContext context) {
    //getcurrentuser();
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
                    Navigator.pushNamed(context, Signup.id);
                  },
                  child: Text(
                    'Sign up',
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
                      DropdownButtonFormField(
                        value: _isDonorUser ? 'Donor' : 'Volunteer',
                        decoration: InputDecoration(
                          labelText: 'Select user type',
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
                        onChanged: (value) {
                          setState(() {
                            _isDonorUser = value == 'Donor';
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: 'Donor',
                            child: Text('Donor'),
                          ),
                          DropdownMenuItem(
                            value: 'Volunteer',
                            child: Text('Volunteer'),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
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
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Sign In'),
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
                        label: Text('Sign in with Google'),
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
