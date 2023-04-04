import 'package:flutter/material.dart';

class DonationsList extends StatefulWidget {
  static String id = 'donation-list';
  @override
  _DonationsListState createState() => _DonationsListState();
}

class _DonationsListState extends State<DonationsList> {
  List<String> currentDonations = [    'Donation 1',    'Donation 2',    'Donation 3',  ];

  List<String> pastDonations = [    'Donation 4',    'Donation 5',    'Donation 6',  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donations'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Current Active Donations',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: currentDonations.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(currentDonations[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DonationDetailsPage(
                          donationTitle: currentDonations[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Past Donations',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: pastDonations.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(pastDonations[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DonationDetailsPage(
                          donationTitle: pastDonations[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DonationDetailsPage extends StatelessWidget {
  final String donationTitle;

  DonationDetailsPage({required this.donationTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(donationTitle),
      ),
      body: Center(
        child: Text('Details for $donationTitle'),
      ),
    );
  }
}
