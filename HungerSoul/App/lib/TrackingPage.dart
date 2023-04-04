import 'package:flutter/material.dart';

class FoodDonationTrackingPage extends StatefulWidget {

  static String id = 'donation-track';
  FoodDonationTrackingPage({this.data}); // receiving data loading screen
  late var data;
  @override
  State<FoodDonationTrackingPage> createState() => _FoodDonationTrackingPageState();
}

class _FoodDonationTrackingPageState extends State<FoodDonationTrackingPage> {

  String donationid ='';
  bool step_1 = false;
  bool step_2 = false;
  bool step_3 = false;
  bool step_4 = false;
  bool step_5 = false;
  bool step_6 = false;

  String step_1_text = "";
  String step_1_time = "Will be updated soon.";

  String step_2_text = "";
  String step_2_time = "Will be updated soon.";

  String step_3_text = "";
  String step_3_time = "Will be updated soon.";

  String step_4_text = "";
  String step_4_time = "Will be updated soon.";

  String step_5_text = "";
  String step_5_time = "Will be updated soon.";

  String step_6_text = "";
  String step_6_time = "Will be updated soon.";

  String message ="Will be updated soon";



  dynamic yourData;

  @override
  void initState() {
    super.initState();

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final modalRoute = ModalRoute.of(context);
    if (modalRoute != null) {
      yourData = modalRoute.settings.arguments;
      print(yourData);
      switch(yourData['step']){
        case '1': setState(() {
          step_1 = true;
          step_1_time = yourData['time_1'];
          step_1_text = "By You";
          donationid = yourData['donationid'];
        });
        break;
        case '2': setState(() {
          step_1 = true;
          step_2 = true;
          step_1_time = yourData['time_1'];
          step_1_text = "By You";
          step_2_time = yourData['time_2'];
          step_2_text = yourData["volunteername"]+" is on the way" ;
          donationid = yourData['donationid'];
        });
        break;
        case '3': setState(() {
          step_1 = true;
          step_2 = true;
          step_3 = true;
          step_1_time = yourData['time_1'];
          step_1_text = "By You";
          step_2_time = yourData['time_2'];
          step_2_text = yourData["volunteername"]+" is on the way" ;
          step_3_time = yourData['time_3'];
          step_3_text = "By "+yourData["volunteername"] ;
          donationid = yourData['donationid'];
        });
        break;
        case '4': setState(() {
          step_1 = true;
          step_2 = true;
          step_3 = true;
          step_4 = true;
          step_1_time = yourData['time_1'];
          step_1_text = "By You";
          step_2_time = yourData['time_2'];
          step_2_text = yourData['volunteername']+" is on the way" ;
          step_3_time = yourData['time_3'];
          step_3_text = "By "+yourData['volunteername'] ;
          step_4_time = yourData['time_4'];
          step_4_text = "Reached "+yourData['selectedNGO'] ;
          donationid = yourData['donationid'];
        });
        break;
        case '5': setState(() {
          step_1 = true;
          step_2 = true;
          step_3 = true;
          step_4 = true;
          step_5 = true;
          step_1_time = yourData['time_1'];
          step_1_text = "By You";
          step_2_time = yourData['time_2'];
          step_2_text = yourData['volunteername']+" is on the way" ;
          step_3_time = yourData['time_3'];
          step_3_text = "By "+yourData['volunteername'] ;
          step_4_time = yourData['time_4'];
          step_4_text = "Reached "+yourData['selectedNGO'] ;
          step_5_time = yourData['time_5'];
          step_5_text = "Your donation to be distributed near "+yourData['location_to_be']+" by "+yourData['DISvolname'] ;
          donationid = yourData['donationid'];
        });
        break;
        case '6': setState(() {
          step_1 = true;
          step_2 = true;
          step_3 = true;
          step_4 = true;
          step_5 = true;
          step_6 = true;
          step_1_time = yourData['time_1'];
          step_1_text = "By You";
          step_2_time = yourData['time_2'];
          step_2_text = yourData['volunteername']+" is on the way" ;
          step_3_time = yourData['time_3'];
          step_3_text = "By "+yourData['volunteername'] ;
          step_4_time = yourData['time_4'];
          step_4_text = "Reached "+yourData['selectedNGO'] ;
          step_5_time = yourData['time_5'];
          step_5_text = "To be distributed near "+yourData['location_to_be']+" by "+yourData['DISvolname'] ;
          step_6_time = yourData['time_6'];
          step_6_text = "Received by "+ yourData['gender']+" near "+yourData['area'];
          message = yourData['message'];
          donationid = yourData['donationid'];
        });
        break;
        default : break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Donation Tracking'),
      ),
      body: SafeArea(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text('DonationID: $donationid',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900
              ),),
            ),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 16),
                  _buildStep('Donation Call',step_1_time,step_1_text, step_1, step_1),
                  _buildStep('Request Accepted by volunteer',step_2_time,step_2_text, step_2, step_2),
                  _buildStep('Pick up',step_3_time,step_3_text, step_3, step_3),
                  _buildStep('Reached NGO',step_4_time,step_4_text, step_4, step_4),
                  _buildStep('Dispaching for distribution',step_5_time,step_5_text, step_5, step_5),
                  _buildStep('Distributed and feedback collected',step_6_time,step_6_text, step_6, step_6),
                ],
              ),
            ),
            Text('Message Received from Receiver of food: ',
            style: TextStyle(fontSize: 16,
            fontWeight: FontWeight.w600),),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Container(
                alignment: Alignment.center,
                height: 75,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String label,String time,String volunteername, bool isActive, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? Colors.blue : Colors.grey[400],
                ),
                child: Icon(
                  isCompleted ? Icons.check : Icons.circle,
                  color: isCompleted ? Colors.white : isActive ? Colors.white : Colors.grey[600],
                  size: 16,
                ),
              ),
              SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isActive ? Colors.blue : Colors.grey[600],
                ),
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 47,top: 2),
            child: Row(children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isActive ? Colors.blue : Colors.grey[600],
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                volunteername,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isActive ? Colors.blue : Colors.grey[600],
                ),
              ),
            ],),
          ),
          SizedBox(height: 5,)
        ],
      ),
    );
  }
}
