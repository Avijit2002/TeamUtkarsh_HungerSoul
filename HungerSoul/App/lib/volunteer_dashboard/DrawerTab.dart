import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_donation_app/welcome_page.dart';

class DrawerTab extends StatefulWidget {
  const DrawerTab({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerTab> createState() => _DrawerTabState();
}



class _DrawerTabState extends State<DrawerTab> {

  dynamic loggedinUser = "";
  getcurrentuser()async{
    try{
      final user = await FirebaseAuth.instance.currentUser!.email;
      loggedinUser = user;
    }
    catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getcurrentuser();
    //print(loggedinUser.email);
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://cdn5.vectorstock.com/i/1000x1000/51/99/icon-of-user-avatar-for-web-site-or-mobile-app-vector-3125199.jpg'),
                ),
                const SizedBox(height: 10),
                Text(
                  loggedinUser,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async{
              await FirebaseAuth.instance.signOut();
              Navigator.popUntil(context, ModalRoute.withName(WelcomePage.id));
            },
          ),
        ],
      ),
    );
  }
}

