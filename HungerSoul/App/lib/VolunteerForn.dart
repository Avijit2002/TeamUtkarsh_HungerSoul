import 'package:flutter/material.dart';
import 'models/Volunteer-form-model.dart';
import 'services/api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class VolunteerForm extends StatefulWidget {
  const VolunteerForm({Key? key}) : super(key: key);
  static String id = 'volunteer-form';
  @override
  State<VolunteerForm> createState() => _VolunteerFormState();
}

class _VolunteerFormState extends State<VolunteerForm> {

  Volunteer donation=Volunteer();


  final _formKey = GlobalKey<FormState>();

  List<String> _ngos = [
    'NGO A',
    'NGO B',
    'NGO C',
    'NGO D',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer Registration  Form'),
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
                    labelText: 'Volunteer\'s Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter donor\'s name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    donation.volunteerName = value.toString();
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
                    labelText: 'Aadhar number',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter type ypur aadhar number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    donation.aadharno = value.toString();
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
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Set Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please set your address';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    //print(value);
                    donation.password = value!;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your address';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    //print(value);
                    donation.password = value!;
                  },
                ),
                SizedBox(height: 16.0),
                Text('Your volunteer account will be activated after verification by NGO',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),),
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
                      //Api.createDonation(data);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

