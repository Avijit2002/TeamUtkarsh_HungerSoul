import 'package:flutter/material.dart';
import 'package:food_donation_app/volunteer_dashboard/VolunteerHomePage.dart';
import 'volenteer_dashboard.dart';
import 'DonationDetailsPage.dart';
import '../services/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Accepted details page.dart';

class AcceptedRequestPage extends StatefulWidget {
  static String id = "accepted-request-page";
  AcceptedRequestPage({this.loggedemail}); // receiving data loading screen
  late var loggedemail;

  @override
  State<AcceptedRequestPage> createState() => _AcceptedRequestPageState();
}

class _AcceptedRequestPageState extends State<AcceptedRequestPage> {
  //late Future<dynamic> isAccepted;
  late bool accept = false;


  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accepted Donation call List'),
      ),
      body: FutureBuilder<dynamic>(
          future: Api.getAcceptedList({'volunteerid':widget.loggedemail}), // API call to get donation list
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text('No Accepted calls'),
              );
            } else {
              List acceptedList = snapshot.data;
              //print(donationList[0]);
              return Column(
                children: [
                  //Text('Requests'),
                  SizedBox(height: 16),
                  Text(
                    'Accepted Donation Calls',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: acceptedList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: ListTile(
                            title: Text(
                                'Donation call from ${acceptedList[index]['donorname']}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Quantity: ${acceptedList[index]['quantity']}'),
                                Text(
                                    'Location: ${acceptedList[index]['address']}'),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        accept = await Navigator.push(context,
                                            MaterialPageRoute(builder: (context) {
                                              return AcceptedDetailsPage(
                                                  donationList: acceptedList[
                                                   index]); //sending data to details page
                                            }));
                                        print(accept);
                                      },
                                      child: Text('View Details'),
                                    ), //view details
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

}
