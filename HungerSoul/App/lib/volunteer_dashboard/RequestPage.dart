import 'package:flutter/material.dart';
import 'package:food_donation_app/volunteer_dashboard/VolunteerHomePage.dart';
import 'volenteer_dashboard.dart';
import 'DonationDetailsPage.dart';
import '../services/api.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RequestPage extends StatefulWidget {
  static String id = "request-page";
  const RequestPage({Key? key}) : super(key: key);

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  late Future<dynamic> isAccepted;
  late bool accept = false;

  dynamic loggedinUser = "";
  getcurrentuser()async{
    try{
      final user = await FirebaseAuth.instance.currentUser;
      loggedinUser = user;
      //print(loggedinUser.uid);
      //print(loggedinUser.email);
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
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Calls'),
      ),
      body: FutureBuilder<dynamic>(
          future: Api.getDonationRequestList(), // API call to get donation list
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text('No Active Call for donation'),
              );
            } else {
              List donationList = snapshot.data;
              //print(donationList[0]);
              return Column(
                children: [
                  //Text('Requests'),
                  SizedBox(height: 16),
                  Text(
                    'Donation Calls',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: donationList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: ListTile(
                            title: Text(
                                'Donation call from ${donationList[index]['donorname']}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Quantity: ${donationList[index]['quantity']}'),
                                Text(
                                    'Location: ${donationList[index]['address']}'),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        accept = await Navigator.push(context,
                                            MaterialPageRoute(builder: (context) {
                                              return DonationDetailsPage(
                                                  donationList: donationList[
                                                  index]); //sending data to details page
                                            }));
                                        print(accept);
                                      },
                                      child: Text('View Details'),
                                    ), //view details
                                    SizedBox(width: 8),
                                    ElevatedButton(
                                      onPressed: () {
                                        Map<String, dynamic> data = {
                                          "donationRequestID": donationList[index]['_id'],
                                          "volunteerName": "Rohit",
                                          "volunteerid": loggedinUser.email.toString(),
                                        };
                                        isAccepted = Api.acceptRequest(data);
                                        DialogBox(context);  // this method is extracted from here. This shows the dialog box
                                      },
                                      child: Text('Accept Request'),
                                    ),
                                    SizedBox(width: 8),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          }),
    );


  }

  Future<dynamic> DialogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<dynamic>(
            future: isAccepted,
            builder: (context, snapshot) {
              bool isaccept = snapshot.data;
              if(snapshot.hasData){
                if (isaccept) {
                  return AlertDialog(
                    title: Text('Request Accepted'),
                    actions: [
                      TextButton(
                        child: Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                } else if(!isaccept){
                  return AlertDialog(
                    title: Text('Failed!! Try Again'),
                    actions: [
                      TextButton(
                        child: Text('Ok'),
                        onPressed: () {
                          Navigator.popUntil(context, ModalRoute.withName(VolunteerDashboard.id));
                        },
                      ),
                    ],
                  );
                }
              }
              else if(!snapshot.hasData){
                return Text('data');
              }
              return Text('data');
            });
      },
    );
  }
}
