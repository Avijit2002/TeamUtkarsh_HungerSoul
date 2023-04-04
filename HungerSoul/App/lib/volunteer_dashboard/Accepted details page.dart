import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class AcceptedDetailsPage extends StatelessWidget {
  final Map<String,dynamic> donationList;

  late bool accept =false;

  AcceptedDetailsPage({required this.donationList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accepted call Details'),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 5,right: 5,top: 2),
        child:ListView(
          children: [
            Container(
              height: 400,
              child: FlutterMap(
                options: MapOptions(
                  minZoom: 5,
                  maxZoom: 18,
                  zoom: 16,
                  center: AppConstants.myLocation,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                    "https://api.mapbox.com/styles/v1/avijit2002/clf50l6l0003k01mxbvxy4u21/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYXZpaml0MjAwMiIsImEiOiJjbGY0Y2NkNTIwb3U1M3lwZml0ZDVrcTV1In0.bmQP2skjXonxrzAv5Tkuog",
                    additionalOptions: {
                      'mapStyleId': AppConstants.mapBoxStyleId,
                      'accessToken': AppConstants.mapBoxAccessToken,
                    },
                  ),
                  MarkerLayer(
                    markers: [
                      for (int i = 0; i < mapMarkers.length; i++)
                        Marker(
                          height: 50,
                          width: 50,
                          point: LatLng(22.5658636, 88.3607303),
                          builder: (_) {
                            return GestureDetector(
                                onTap: () {},
                                child: Image.asset('assets/map-marker.png')
                            );
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 30, 8, 15),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class AppConstants {
  static const String mapBoxAccessToken = 'sk.eyJ1IjoiYXZpaml0MjAwMiIsImEiOiJjbGY0ZmlqNXAwYWZ6M3pvNHZiZW15d3p5In0.Q2twk0fvfZT3DcAYezEuFg';

  static const String mapBoxStyleId = 'https://api.mapbox.com/styles/v1/avijit2002/clf50l6l0003k01mxbvxy4u21/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYXZpaml0MjAwMiIsImEiOiJjbGY0Y2NkNTIwb3U1M3lwZml0ZDVrcTV1In0.bmQP2skjXonxrzAv5Tkuog';

  static final myLocation = LatLng(22.5658636, 88.3607303);
}
class MapMarker {
  final LatLng? location;

  MapMarker({
    required this.location,
  });
}

final mapMarkers = [
  MapMarker(
    location: LatLng(51.5382123, -0.1882464),)
];




