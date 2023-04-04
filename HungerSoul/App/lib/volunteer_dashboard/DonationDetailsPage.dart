import 'package:flutter/material.dart';

class DonationDetailsPage extends StatelessWidget {
  final Map<String,dynamic> donationList;

  late bool accept =false;

  DonationDetailsPage({required this.donationList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Donation ID:${donationList['_id']}',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Donor Name: ${donationList['donorname']}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Donor Phone: ${donationList['phone']}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Donor email: ${donationList['email']}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Donation Type: ${donationList['food']}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Donation Quantity: ${donationList['quantity']}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Best before: ${donationList['bestbefore']}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Donation Description: ',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Address: ${donationList['address']}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'NGO Name: ${donationList['selectedngo']}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                accept = true;
                Navigator.pop(context,accept);
              },
              child: Text('Accept Request'),
            ),
          ],
        ),
      ),
    );
  }
}
