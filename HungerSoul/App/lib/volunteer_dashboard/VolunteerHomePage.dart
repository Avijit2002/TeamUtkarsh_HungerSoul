import 'package:flutter/material.dart';
import 'package:food_donation_app/volunteer_dashboard/AcceptedRequestList.dart';
import 'package:permission_handler/permission_handler.dart';
import 'RequestPage.dart';
import 'package:flutter/services.dart';
import 'package:food_donation_app/services/api.dart';
import 'QRform.dart';
import 'QRScannerPage.dart';
import 'QR.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:firebase_auth/firebase_auth.dart';


class VolunteerHomePage extends StatefulWidget {
  const VolunteerHomePage({Key? key}) : super(key: key);

  @override
  State<VolunteerHomePage> createState() => _VolunteerHomePageState();
}

class _VolunteerHomePageState extends State<VolunteerHomePage> {
  //String? qrcodedata = "";
  String _scanBarcode = 'Unknown';

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      openform();
    });
  }

  void openform() async{
    print(_scanBarcode);
    Map data={'qr_id':'$_scanBarcode'};
    dynamic qr_data = await Api.getQRdata(data); // api call to get data
    print(qr_data);
    if(qr_data!='yes'){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => QRform(),
        settings: RouteSettings(arguments:qr_data),
      ),);
    }

  }

  dynamic loggedinUser = "";
  dynamic loggedemail;
  getcurrentuser()async{
    try{
      final user = await FirebaseAuth.instance.currentUser;
      loggedinUser = user;
      //print(loggedinUser.uid);
      print(loggedinUser.email);
      loggedemail = loggedinUser.email;
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
    return Scaffold(
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text(
              'Welcome, Rohit!',
              style:
              TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            Card(
              margin:
              EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListTile(
                title: Text(
                  'Scan QR',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Attach QR with packet and update details',
                  style: TextStyle(fontSize: 16),
                ),
                trailing: Icon(Icons.qr_code),
                onTap: () => scanQR()
              ),
            ),
            SizedBox(height: 15),
            Card(
              margin:
              EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListTile(
                title: Text(
                  'Donation Calls',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'See the list of incoming donation calls',
                  style: TextStyle(fontSize: 16),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pushNamed(context, RequestPage.id);
                },
              ),
            ),
            const SizedBox(height: 15),
            Card(
              margin:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListTile(
                title: const Text(
                  'Accepted Active Calls',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle:const Text(
                  'See the details of accepted call',
                  style: TextStyle(fontSize: 16),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return AcceptedRequestPage(loggedemail:loggedemail);  //sending data to weatherpage
                  }));
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  }
