class Volunteer{
  String volunteerName='';
  String phoneNumber='';
  String address='';
  String email='';
  String aadharno='';
  String selectedNGO='';
  String password='';


  Map createJSON(Volunteer data){
    return{
      "volunteerName":data.volunteerName,
      "phoneNumber":data.phoneNumber,
      "address":data.address,
      "email":data.email,
      "aadharno":data.aadharno,
      "selectedNGO":data.selectedNGO,
      "password": data.password,
    };

  }
}

