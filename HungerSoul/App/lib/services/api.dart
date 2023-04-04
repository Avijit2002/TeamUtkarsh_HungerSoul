import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static const baseurl = 'http://34.125.212.22:8080/donation/';
  //34.125.212.22 -- VM
  //192.168.52.1 -- myIP


  // For Donor UI
  static createDonation(Map data) async {
    print(data);
    var url = Uri.parse("${baseurl}createdonation");
    print(url);
    final headers = {'Content-Type': 'application/json'};
    try {
      final res = await http.post(url,
          headers: headers,
          body: jsonEncode(data));

      if (res.statusCode == 201) {
        var data = jsonDecode(res.body.toString());
        print(data);
      }
      else {
        print("failed ");
      }
    }
    catch (e) {
      print(e.toString());
    }
  }


  // For Volunteer UI
  static getDonationRequestList() async {
    List<dynamic> donationList = [];
    var url = Uri.parse("${baseurl}getdonationrequestlist");
    //print(url);
    try {
      final res = await http.get(url);
      print(res.body);
      if (res.statusCode == 202) {
        var data = jsonDecode(res.body);
        //print(data['data']);
        //print(data['data'].runtimeType);
        donationList = data['data'];
      }
      else {
        print("failed ");
      }
    }
    catch (e) {
      print(e.toString());
    }
    return donationList;
  }

  static acceptRequest(Map data) async {
    print(data);
    var url = Uri.parse("${baseurl}acceptrequest");
    print(url);
    final headers = {'Content-Type': 'application/json'};
    try {
      final res = await http.post(url,
          headers: headers,
          body: jsonEncode(data));

      if (res.statusCode == 203) {
        var data = jsonDecode(res.body.toString());
        print(data['data']);
        if(data['data']=='accepted'){
          return true;
        }
        else{
          return false;
        }
      }
      else {
        print("failed ");
      }
    }
    catch (e) {
      print(e.toString());
    }
  }


  static getQRdata(Map data) async {
    dynamic qrdata;
    var url = Uri.parse("${baseurl}getqrdata");
    print(url);
    print(data);
    final headers = {'Content-Type': 'application/json'};
    try {
      final res = await http.post(url,
          headers: headers,
          body: jsonEncode(data)
      );
      //print(res.body);
      if (res.statusCode==200) {
        var d = jsonDecode(res.body);
        qrdata = d;
        return qrdata['data'];
      }else if(res.statusCode==201){
        var d = jsonDecode(res.body);
        //print(d['data']);
        //print(d['data'].runtimeType);
        qrdata = d;
        return qrdata['notfound'];
      }
      else {
        print("failed ");
      }
    }
    catch (e) {
      //print(e.toString());
    }

    return qrdata['data'];
  }


  static getDonationdetailforqr(Map data) async {
    dynamic donationdetail;
    var url = Uri.parse("${baseurl}getdonationdetailforqr");
    print(url);
    print(data);
    final headers = {'Content-Type': 'application/json'};
    try {
      final res = await http.post(url,
          headers: headers,
          body: jsonEncode(data)
      );
      print(res.body);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        //print(data['data']);
        //print(data['data'].runtimeType);
        donationdetail = data['data'][0];
      }
      else {
        print("failed ");
      }
    }
    catch (e) {
      print(e.toString());
    }
    return donationdetail;
  }


  static updateQRstep_3(Map data) async {
    //dynamic donationdetail;
    var url = Uri.parse("${baseurl}updateQRstep_3");
    print(url);
    print(data);
    final headers = {'Content-Type': 'application/json'};
    try {
      final res = await http.post(url,
          headers: headers,
          body: jsonEncode(data)
      );
      print(res.body);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        //print(data['data']);
        //print(data['data'].runtimeType);
        //donationdetail = data['data'][0];
      }
      else {
        print("failed ");
      }
    }
    catch (e) {
      print(e.toString());
    }
    //return donationdetail;
  }

  static NGOreachupdate(Map data) async {
    //dynamic donationdetail;
    var url = Uri.parse("${baseurl}NGOreachupdate");
    print(url);
    print(data);
    final headers = {'Content-Type': 'application/json'};
    try {
      final res = await http.post(url,
          headers: headers,
          body: jsonEncode(data)
      );
      print(res.body);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        print(data['data']);
        //print(data['data'].runtimeType);
        //donationdetail = data['data'][0];
      }
      else {
        print("failed ");
      }
    }
    catch (e) {
      print(e.toString());
    }
    return data['data'];
  }

  static Dispatched(Map data) async {
    //dynamic donationdetail;
    var url = Uri.parse("${baseurl}dispatched");
    print(url);
    print(data);
    final headers = {'Content-Type': 'application/json'};
    try {
      final res = await http.post(url,
          headers: headers,
          body: jsonEncode(data)
      );
      print(res.body);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        print(data['data']);
        //print(data['data'].runtimeType);
        //donationdetail = data['data'][0];
      }
      else {
        print("failed ");
      }
    }
    catch (e) {
      print(e.toString());
    }
    //return data['data'];
  }

  static Donated(Map data) async {
    //dynamic donationdetail;
    var url = Uri.parse("${baseurl}donated");
    print(url);
    print(data);
    final headers = {'Content-Type': 'application/json'};
    try {
      final res = await http.post(url,
          headers: headers,
          body: jsonEncode(data)
      );
      print(res.body);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        print(data['data']);
        //print(data['data'].runtimeType);
        //donationdetail = data['data'][0];
      }
      else {
        print("failed ");
      }
    }
    catch (e) {
      print(e.toString());
    }
    //return data['data'];
  }

  static getAcceptedList(Map data) async {
    print(data);
    List<dynamic> donationList = [];
    var url = Uri.parse("${baseurl}getacceptedrequestlist");
    //print(url);
    final headers = {'Content-Type': 'application/json'};
    try {
      final res = await http.post(url,
          headers: headers,
          body: jsonEncode(data)
      );
      print(res.body);
      if (res.statusCode == 202) {
        var data = jsonDecode(res.body);
        //print(data['data']);
        //print(data['data'].runtimeType);
        donationList = data['data'];
      }
      else {
        print("failed ");
      }
    }
    catch (e) {
      print(e.toString());
    }
    return donationList;
  }

  static GetPost() async {
    List<dynamic> post = [];
    var url = Uri.parse("${baseurl}getpost");
    //print(url);
    try {
      final res = await http.get(url);
      print(res.body);
      if (res.statusCode == 202) {
        var data = jsonDecode(res.body);
        //print(data['data']);
        //print(data['data'].runtimeType);
        post = data['data'];
      }
      else {
        print("failed ");
      }
    }
    catch (e) {
      print(e.toString());
    }
    return post;
  }




}



