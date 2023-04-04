import 'dart:convert';
import 'package:flutter/material.dart';
import 'welcome_page.dart';
import 'home_page.dart';
import 'donation_form.dart';
import 'TrackingPage.dart';
import 'volunteer_dashboard/volenteer_dashboard.dart';
import 'notification.dart';
import 'package:food_donation_app/volunteer_dashboard/RequestPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Signup.dart';
import 'volunteer_dashboard/AcceptedRequestList.dart';
import 'VolunteerForn.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'volunteer_dashboard/QRScannerPage.dart';
import './volunteer_dashboard/QR.dart';
import 'DonationList.dart';




//final GlobalKey<NavigatorState> navigatorKey = GlobalKey();


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value)=>{
    print('connected')
  });

  //LocalNotificationService.initialize();



  runApp(
    MaterialApp(
      //navigatorKey: navigatorKey,
      initialRoute:WelcomePage.id,
      routes: {
        WelcomePage.id : (context) => WelcomePage(),
        Signup.id:(context)=>Signup(),
        Home.id: (context)=> Home(),
        DonationForm.id: (context)=>DonationForm(),
        FoodDonationTrackingPage.id: (context)=>FoodDonationTrackingPage(),
        VolunteerDashboard.id:(context)=>VolunteerDashboard(),
        NotificationPage.id: (context)=>NotificationPage(),
        FoodDonationTrackingPage.id :(context)=>FoodDonationTrackingPage(),
        RequestPage.id : (context)=>RequestPage(),
        AcceptedRequestPage.id:(context)=>AcceptedRequestPage(),
        VolunteerForm.id:(context)=>VolunteerForm(),
        //MyApp.id : (context)=>MyApp(),
        //DonationsList.id:(context)=>DonationsList(),

      },
    ),
  );

}

