import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var locationMessage = '';
   late String latitude;
   late String longitude;

  void getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission(); 
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    var lat = position.latitude;
    var long = position.longitude;

    latitude = "$lat";
    longitude = "$long";

    setState(() {
      locationMessage = "Latitude: $lat and Longitude: $long";
    });
  }

  void googleMap() async {
    LocationPermission permission = await Geolocator.requestPermission(); 
    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=11.0195058,76.9937724";

    // ignore: deprecated_member_use
    if (await canLaunch(googleUrl)) {
      // ignore: deprecated_member_use
      await launch(googleUrl);
    } else
      throw ("Couldn't open google maps");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User location application',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                size: 45.0,
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Get User Location",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                locationMessage,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 05.0,
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // ignore: deprecated_member_use
                  primary: Colors.amber
                 ),
                onPressed: () {
                  getCurrentLocation();     
                },
                child: Text("Get User Location",),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // ignore: deprecated_member_use
                  primary: Colors.amber
                 ),
                onPressed:()async {
                  googleMap();     
                },
                child: Text("Open GMap",),
              ),
            ],
          ),
        ),
      ),
    );
  }
}