import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'package:http/http.dart' as http;
import 'package:onclickproperty/const/const.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

class LocationListPage extends StatefulWidget {
  @override
  _LocationListPageState createState() => _LocationListPageState();
}

class _LocationListPageState extends State<LocationListPage> {
  var _controller = TextEditingController();
  var uuid = new Uuid();
  String _sessionToken;
  List<dynamic> _placeList = [];
  String lat;
  String long;

  @override
  void initState() {
    super.initState();
    // _controller.addListener(() {
    //   _onChanged();
    // });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyBrcmvr351rN55aSbY71UZUrHqSlOnNwQM";
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var uri = Uri.parse(request);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarycolor,
        elevation: 0,
        title: Text('City Location List'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Seek your location here",
                  focusColor: Colors.white,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  prefixIcon: Icon(Icons.map),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () => _controller.clear(),
                  ),
                ),
                onChanged: (value) {
                  _onChanged();
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _placeList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_placeList[index]["description"]),
                    onTap: () {
                      _controller.text = _placeList[index]["description"];

                      var placeId = _placeList[index]["place_id"];
                      var address = _placeList[index]["description"];
                      print('${_placeList[index]}');
                      getLatLong(address);
                      // lat = detail.result.geometry.location.lat;
                      // long = detail.result.geometry.location.lng;
                      setState(() {
                        _placeList.clear();
                      });
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  getLatLong(String address) async {
    // From a query
    final query = '$address';
    // var addresses = await Geocoder.local.findAddressesFromQuery(query);
    // print(addresses);
    // var first = addresses.first;
    // print(first.locality);
    // print("${first.featureName} : ${first.coordinates}");

    // List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
    print('getLatLong');

    locationFromAddress(query).then((locations) {
      final output = locations[0].toString();
      print(output);
      print(locations[0].latitude);
      print(locations[0].longitude);
    });


    // List<Placemark> placemark =
    //     await Geolocator().placemarkFromAddress(query);
    // print(placemark[0].position.latitude);
    // print(placemark[0].position.longitude);
    // print(placemark[0].position);
    // print(placemark[0].locality);
    // print(placemark[0].administrativeArea);
    // print(placemark[0].postalCode);
    // print(placemark[0].name);
    // print(placemark[0].subAdministrativeArea);
    // print(placemark[0].isoCountryCode);
    // print(placemark[0].subLocality);
    // print(placemark[0].subThoroughfare);
    // print(placemark[0].thoroughfare);

    // List<Placemark> adddplacemark = await Geolocator().placemarkFromCoordinates(21.1458004, 79.0881546);
    // print(adddplacemark[0].locality);
  }
}
