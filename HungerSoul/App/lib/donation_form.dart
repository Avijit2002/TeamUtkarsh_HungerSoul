import 'package:flutter/material.dart';
import 'models/donated_food_model.dart';
import 'services/api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class DonationForm extends StatefulWidget {
  const DonationForm({Key? key}) : super(key: key);
  static String id = 'donation-form';
  @override
  State<DonationForm> createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {

    Donation donation=Donation();

    String? donorToken;
    void gettoken() async{
      await FirebaseMessaging.instance.getToken().then((value)=>{
        donorToken = value
      }
      );
    }

    final _formKey = GlobalKey<FormState>();

    List<String> _ngos = [
      'NGO A',
      'NGO B',
      'NGO C',
      'NGO D',
    ];

    @override
  void initState() {
    super.initState();
    gettoken();
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Donation Request Form'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Select NGO',
                    ),
                    value: donation.selectedNGO.isNotEmpty ? donation.selectedNGO : null, // guard it with null if empty
                    //value: _selectedNGO,
                    items: _ngos
                        .map(
                          (ngo) => DropdownMenuItem<String>(
                        value: ngo,
                        child: Text(ngo),
                      ),
                    )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        donation.selectedNGO = value.toString();
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select an NGO';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Donor\'s Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter donor\'s name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      donation.donorName = value.toString();
                      donation.donortoken = donorToken;
                      print(donorToken);
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter phone number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      donation.phoneNumber = value.toString();
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      donation.email = value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Type of Food',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter type of food';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      donation.food = value.toString();
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Quantity';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      donation.quantity = value.toString();
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Best Before (in hours)',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Best before time';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      donation.bestbefore = value.toString();
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Address',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      //print(value);
                      donation.address = value!;
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        //print(donation);
                        Map data=donation.createJSON(donation);
                        //print(data);
                        Api.createDonation(data);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Donate'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

  }

