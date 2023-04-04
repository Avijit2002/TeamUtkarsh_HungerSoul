import 'package:flutter/material.dart';
import 'package:food_donation_app/services/api.dart';

class QRform extends StatefulWidget {
  @override
  State<QRform> createState() => _QRformState();
}

class _QRformState extends State<QRform> {
  final _formKey = GlobalKey<FormState>();
  String? donationId;
  dynamic yourData;
  dynamic details;
  bool _isChecked = false;

  String? NGOvolname;
  String? NGOvolid;

  String? DISvolname;
  String? DISvolid;
  String? location_to_be;

  String? _area;
  String? _gender;
  bool _isSuffering = false;
  String? _message;


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final modalRoute = ModalRoute.of(context);
    if (modalRoute != null) {
      yourData = modalRoute.settings.arguments;
      print(yourData);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    switch (yourData[0]['currentstep']) {
      case 2:
        content = Pickup();
        break;
      case 3:
        content = ReachedNGO();
        break;
      case 4:
        content = Dispatched();
        break;
      case 5:
        content = Distributed();
        break;
      default:
        content = Text('data');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('UpdateQR Form'),
      ),
      body: content,
    );
  }

  Widget Pickup() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(
        children: [
          Column(
            children: [
              Text(
                'This is donation pick up form. Fill donation id in the given field. Details regarding this donation will be automatically fetched from server.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 15,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Donation ID',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a donation ID';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        donationId = value;
                      },
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Do something with the donation ID, such as submit it to a server
                          print('Submitted donation ID: $donationId');
                          Map data = {'_id': '$donationId'};
                          dynamic datae = await Api.getDonationdetailforqr(
                              data); // api call to get data
                          setState(() {
                            details = datae;
                          });
                          print(details);
                        }
                      },
                      child: Text('Submit'),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              (details != null)
                  ? DonationDetails(details: details, QRdata: yourData)
                  : Padding(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                          child: Text(
                        'Submit donatioID to get details',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Widget ReachedNGO() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verify all the details, check the food packet and submit this form after updating your details.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Donation and Donor details: ',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Donation ID:${yourData[0]['donationid']}',
                    style: TextStyle(
                      fontSize: 16.0,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Donor Name: ${yourData[0]['donorname']}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Donor Phone: ${yourData[0]['phone']}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Donor email: ${yourData[0]['email']}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Donation Type: ${yourData[0]['food']}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Donation Quantity: ${yourData[0]['quantity']}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Best before: ${yourData[0]['bestbefore']}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Donation Description: ',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Address: ${yourData[0]['address']}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'NGO Name: ${yourData[0]['selectedngo']}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Volunteer(Pick up) details: ',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    'Volunteer Name: ${yourData[0]['volunteername']}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Volunteer Id: ',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Enter your details: ',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Your Name',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            NGOvolname = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Your Id',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Id';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            NGOvolid = value;
                          },
                        ),
                        SizedBox(height: 16.0),
                        CheckboxListTile(
                          title: Text('I verify that food packet has reached ' +
                              yourData[0]['selectedngo']), // label for checkbox
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked =
                                  value!; // update the value of the checkbox when it is checked or unchecked
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CheckboxListTile(
                          title: Text(
                              'I verify that all the details given by donor is correct'), // label for checkbox
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked =
                                  value!; // update the value of the checkbox when it is checked or unchecked
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              // Do something with the donation ID, such as submit it to a server
                              //print('Submitted donation ID: $donationId');
                              Map data = {
                                'QRid': yourData[0]['QRid'],
                                'NGOvolname': '$NGOvolname',
                                'NGOvolid': '$NGOvolid'
                              };
                              dynamic datae = await Api.NGOreachupdate(
                                  data); // api call to get data
                              print(datae);
                              Navigator.pop(context);
                            }
                          },
                          child: Text('Submit'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget Dispatched() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter your details and details of area where this packet is going to be distributed.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 15,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Your Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        DISvolname = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Your Id',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Id';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        DISvolid = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Area of donation',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter area';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        location_to_be = value;
                      },
                    ),
                    SizedBox(height: 16.0),
                    CheckboxListTile(
                      title: Text(
                          'I verify that is inspected the packet properly'), // label for checkbox
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked =
                              value!; // update the value of the checkbox when it is checked or unchecked
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Do something with the donation ID, such as submit it to a server
                          //print('Submitted donation ID: $donationId');
                          Map data = {
                            'QRid': yourData[0]['QRid'],
                            'DISvolname': '$DISvolname',
                            'DISvolid': '$DISvolid',
                            'location_to_be': '$location_to_be'
                          };
                          await Api.Dispatched(data); // api call to get data
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Submit'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget Distributed() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(
        children: [
          Text(
            'Enter the details of distribution and make sure to not reveal the identity of receiver by any means.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 15,),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter area of donation',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the area of donation';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _area = value;
                  },
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select gender',
                  ),
                  value: _gender,
                  items: [
                    DropdownMenuItem(
                      value: 'male',
                      child: Text('Male'),
                    ),
                    DropdownMenuItem(
                      value: 'female',
                      child: Text('Female'),
                    ),
                    DropdownMenuItem(
                      value: 'child',
                      child: Text('Child'),
                    ),
                    DropdownMenuItem(
                      value: 'others',
                      child: Text('Others'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a gender';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Checkbox(
                      value: _isSuffering,
                      onChanged: (value) {
                        setState(() {
                          _isSuffering = value!;
                        });
                      },
                    ),
                    Text('Suffering from malnutrition'),
                  ],
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Message to donor',
                  ),
                  maxLines: 3,
                  onSaved: (value) {
                    _message = value;
                  },
                ),
                SizedBox(height: 16.0),
                CheckboxListTile(
                  title: const Text(
                      'I verify that I distributed this donated food to a needy one suffering from hunger'), // label for checkbox
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked =
                      value!; // update the value of the checkbox when it is checked or unchecked
                    });
                  },
                ),
                ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () async{
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Map data = {
                        'QRid': yourData[0]['QRid'],
                        'area': '$_area',
                        'gender': '$_gender',
                        'isSuffering': '$_isSuffering',
                        'message': '$_message'
                      };
                      await Api.Donated(data); // api call to get data
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DonationDetails extends StatefulWidget {
  DonationDetails({Key? key, required this.details, required this.QRdata})
      : super(key: key);

  final details;
  final QRdata;

  @override
  State<DonationDetails> createState() => _DonationDetailsState();
}

class _DonationDetailsState extends State<DonationDetails> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Before confirming pickup: ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Verify all the details given of donor and inspect food properly.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Pack the food properly and attach the QR.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Donation ID:${widget.details['_id']}',
            style: TextStyle(
              fontSize: 17.0,
              //fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Donor Name: ${widget.details['donorname']}',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 10.0),
          Text(
            'Donor Phone: ${widget.details['phone']}',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 10.0),
          Text(
            'Donor email: ${widget.details['email']}',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 10.0),
          Text(
            'Donation Type: ${widget.details['food']}',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 10.0),
          Text(
            'Donation Quantity: ${widget.details['quantity']}',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 10.0),
          Text(
            'Best before: ${widget.details['bestbefore']}',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 10.0),
          Text(
            'Donation Description: ',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 10.0),
          Text(
            'Address: ${widget.details['address']}',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 10.0),
          Text(
            'NGO Name: ${widget.details['selectedngo']}',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(
            height: 25,
          ),
          CheckboxListTile(
            title: Text(
                'I verify that I inspected the food properly'), // label for checkbox
            value: _isChecked,
            onChanged: (bool? value) {
              setState(() {
                _isChecked =
                    value!; // update the value of the checkbox when it is checked or unchecked
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          CheckboxListTile(
            title: Text(
                'I verify that all the details given by donor is correct'), // label for checkbox
            value: _isChecked,
            onChanged: (bool? value) {
              setState(() {
                _isChecked =
                    value!; // update the value of the checkbox when it is checked or unchecked
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                //print(widget.QRdata);
                Map data = {
                  'qr_id': widget.QRdata[0]['QRid'],
                  'donationid': widget.details['_id']
                };
                await Api.updateQRstep_3(data); // api call to get data
                Navigator.pop(context);
              },
              child: Text('Confirm pickup'))
        ],
      ),
    );
  }
}
