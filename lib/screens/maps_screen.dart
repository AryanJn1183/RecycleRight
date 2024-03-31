import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:recycleright/screens/ewaste_details.dart';

import 'package:uuid/uuid.dart';

class GoogleMapSearchPlacesApi extends StatefulWidget {
  const GoogleMapSearchPlacesApi({Key? key}) : super(key: key);

  @override
  _GoogleMapSearchPlacesApiState createState() =>
      _GoogleMapSearchPlacesApiState();
}

class _GoogleMapSearchPlacesApiState extends State<GoogleMapSearchPlacesApi> {
  final TextEditingController _controller = TextEditingController();
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  var uuid = const Uuid();
  String _sessionToken = '1234567890';
  List<dynamic> _placeList = [];
  List<Marker> _markers = [];
  String _selectedPlace = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
  }

  void _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    _getSuggestions(_controller.text);
  }

  void _getSuggestions(String input) async {
    const String PLACES_API_KEY = "AIzaSyB6KoETEVLc_svXY3RAinUXKDNDB5VEtqI";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$PLACES_API_KEY&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        _placeList = data['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  void _selectPlace(String placeId) async {
    const String PLACES_API_KEY = "AIzaSyB6KoETEVLc_svXY3RAinUXKDNDB5VEtqI";
    String detailsBaseURL =
        'https://maps.googleapis.com/maps/api/place/details/json';
    String request =
        '$detailsBaseURL?place_id=$placeId&fields=name,geometry&key=$PLACES_API_KEY&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      double lat = data['result']['geometry']['location']['lat'];
      double lng = data['result']['geometry']['location']['lng'];
      setState(() {
        _markers.clear(); // Clear existing markers
        _markers.add(
          Marker(
            markerId: MarkerId(placeId),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(title: data['result']['name']),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
          ),
        );
        _selectedPlace = data['result']['name'];
        _placeList.clear();
      });
      _updateCameraPosition(lat, lng);
      _showNearbyEWasteStations(lat, lng);
    } else {
      throw Exception('Failed to load place details');
    }
  }

  void _updateCameraPosition(double lat, double lng) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(lat, lng),
        zoom: 14,
      ),
    ));
  }

  void _showNearbyEWasteStations(double lat, double lng) {
    // Assuming each degree of latitude is approximately 111 kilometers
    // and each degree of longitude is approximately 111 kilometers at the equator
    // We can define a radius of 5 kilometers to find nearby stations
    final double radius = 0.045; // 5 kilometers
    List<EwasteStation> nearbyStations = ewasteStations.where((station) {
      double stationLat = double.parse(station.latitude);
      double stationLng = double.parse(station.longitude);
      double distance =
          sqrt(pow(lat - stationLat, 2) + pow(lng - stationLng, 2));
      return distance <= radius;
    }).toList();

    setState(() {
      _placeList = nearbyStations.map((station) {
        return {
          'name': station.name,
          'address': station.address,
          'phoneNumber': station.phoneNumber,
        };
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50,),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.green.shade200,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search places',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                _onChanged();
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _placeList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_placeList[index]['description'] ?? ''),
                  onTap: () {
                    _selectPlace(_placeList[index]['place_id']);
                  },
                );
              },
            ),
          ),
          Container(
          height: MediaQuery.of(context).size.height * 0.45, // Adjust the height as needed
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(26.922070, 75.778885),
              zoom: 14,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
            },
            markers: Set.from(_markers),
            myLocationEnabled: true,
            compassEnabled: true,
            myLocationButtonEnabled: true,
          ),
           ),
              Expanded(
              child: ListView.builder(
                itemCount: _placeList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _placeList[index]['name'],
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      _placeList[index]['address'],
                      style: TextStyle(fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EwasteStationDetailsScreen(
                            name: _placeList[index]['name'],
                            address: _placeList[index]['address'],
                            // Pass other necessary data here if needed
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
),
        ],
      ),
    );
  }
}

class EwasteStation {
  final String name;
  final String address;
  final String phoneNumber;
  final String latitude;
  final String longitude;

  EwasteStation({
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
  });
}

List<EwasteStation> ewasteStations = [
  EwasteStation(
    name: 'M/s. H.M.E-waste Management ',
    address:
        'G1-226, RIICO Ind.Area, Kehrani Bhiwadi (Extn.) Tijara Distt- Alwar',
    latitude: '28.1822265',
    longitude: '76.8733946',
    phoneNumber: '9810286509',
  ),
  EwasteStation(
    name: 'M/s. Dhruv Techengineers Pvt. Ltd. ',
    address: 'G-1209, Rampur mandana, Industrial Area, Bhiwadi, Alwar',
    latitude: '28.2014149',
    longitude: '76.8275503',
    phoneNumber: '7726015273',
  ),
  EwasteStation(
    name: 'M/s Greenscape Eco Management Pvt.(Unt-II) ',
    address:
        'F-588 & 591 MIA Alwar , Rampur mandana, Industrial Area, Bhiwadi, Alwar',
    latitude: '27.5529907',
    longitude: '76.6345735',
    phoneNumber: '8290333347',
  ),
  EwasteStation(
    name: 'M/s Greenscape Eco Management Pvt Ltd ',
    address:
        'F- 584-585, MIA, Alwar, Rampur mandana, Industrial Area, Bhiwadi, Alwar',
    latitude: '27.5290056',
    longitude: '76.6678255',
    phoneNumber: '8290333347',
  ),
  EwasteStation(
    name: 'M/s ETCO E-waste Recycler pvt. ltd. ',
    address:
        'SB-23, Shilp Bari Road, 1415 VKI Area, Jaipur, Rampur mandana, Industrial Area, Bhiwadi, Alwar',
    latitude: '26.997294',
    longitude: '75.7854856',
    phoneNumber: '9829018257',
  ),
  EwasteStation(
    name: 'M/s. Universal E-Waste Recycling  ',
    address: 'G1-117 (B), RIICO Industrial Area, Alwar',
    latitude: '28.11587',
    longitude: '76.7862395',
    phoneNumber: '9718607737',
  ),
  EwasteStation(
    name: 'M/s Green Leaf Recycling Industries ',
    address: 'G-166 167, West part, RIICO Ind Area Bagru Jaipur',
    latitude: '26.8205657',
    longitude: '75.5447741',
    phoneNumber: '9799122200',
  ),
  EwasteStation(
    name: 'M/s Shukla E-Waste Processors ',
    address: 'H-309 (B) RIICO Industrial Area, Bhiwadi, Tijara, Alwar',
    latitude: '28.2067217',
    longitude: '76.8578993',
    phoneNumber: '8829009424',
  ),
  EwasteStation(
    name: 'M/s Vasoo Metals ',
    address: '(Division-III) G-287, MIA, Alwar',
    latitude: '27.5290076',
    longitude: '76.6678255',
    phoneNumber: '9414788931',
  ),
  EwasteStation(
    name: 'M/s. GS International ',
    address: 'G1-101, Shri Khatu Shyam Ji Ind. Complex, Ringus, Sikar',
    latitude: '27.3644933',
    longitude: '75.4032489',
    phoneNumber: '9928274008',
  ),
  EwasteStation(
    name: 'M/s. Adatte E-Waste Management Pvt. Ltd.   ',
    address:
        'C6/23, Opposite to Post Office , Safdarganj Development Area, New Delhi',
    latitude: '28.5459277',
    longitude: '77.199844',
    phoneNumber: '9971395011',
  ),
  EwasteStation(
    name: 'M/s. Green Recycling Waste Management ',
    address: 'J 983, RIICO Ind. Area, Chopanki, Tijara, Alwar',
    latitude: '28.1361984',
    longitude: '76.8865844',
    phoneNumber: '8287829246',
  ),
  EwasteStation(
    name: 'M/s. PWL Ventures  ',
    address:
        'B137, Queen Road, Vidyut Nagar B, Jaipur (Plot no.- F142, Road no.-6, RIICO Ind. Area, Bindayka,Jaipur)',
    latitude: '26.9011399',
    longitude: '75.7558371',
    phoneNumber: '8619835393',
  ),
  EwasteStation(
    name: 'M/s. Green India Waste Management  ',
    address: 'G-1/565, RIICO Ind. Area, Khuskhera, Tapukaa, Bhiwadi, Alwar',
    latitude: '28.2069487',
    longitude: '76.8577018',
    phoneNumber: '9818636328',
  ),
  EwasteStation(
    name: 'M/s EPRAGATHI Recycling Pvt. Ltd.  ',
    address:
        'P.No. 29, SKS Industrial Area Ringus, Tehsil- Srimadhopur, Distt- Sikar- 332404 ',
    latitude: '27.3766238',
    longitude: '75.5579722',
    phoneNumber: '9928274008',
  ),
  EwasteStation(
    name: 'M/s Hydro Engineers  ',
    address:
        'H1-929, RIICO Industrial Area, Chopanki, Bhiwadi, District- Alwar',
    latitude: '28.1944557',
    longitude: '76.8637887',
    phoneNumber: '9001652444',
  ),
  EwasteStation(
    name: 'M/s. Urban Metals  ',
    address:
        'E-2118, Ramchandrapura RIICO Industrial area, Sitapura, Tehsil: Sanganer, District-Jaipur',
    latitude: '26.7722834',
    longitude: '75.856151',
    phoneNumber: '7300003820',
  ),
  EwasteStation(
    name: 'M/s. Fateh Enviro Lab  ',
    address:
        'Khasra No. 1036/14, Industrial Area, Jasol, Balotra, Barmer 344022',
    latitude: '25.839754',
    longitude: '72.230829',
    phoneNumber: '9413880789',
  ),
  EwasteStation(
    name: 'M/s Abaad Developers Private, Limited    ',
    address:
        'G1747, RIICO INDUSTRIAL AREA, CHOPANKI, BHIWADI, Alwar Rajasthan, 301019.',
    latitude: '28.1944557',
    longitude: '76.8637887',
    phoneNumber: '9899970888',
  ),
  EwasteStation(
    name: 'M/s Green Web Recycling  ',
    address: 'H1-865, Industrial Area, Manda-II, Chomu, Jaipur 303702',
    latitude: '27.1655759',
    longitude: '75.7158062',
    phoneNumber: '	9982462926',
  ),
  EwasteStation(
    name: 'M/s Eraw Waste Management  ',
    address:
        'LLP, Plot no E-44, RIICO Industrial Area, Sarekhurd, Tijara, Alwar',
    latitude: '27.9336735',
    longitude: '76.8540822',
    phoneNumber: '9818298100',
  ),
  EwasteStation(
    name: 'M/s Golden Green Recyclers ',
    address:
        'G1-11, S.K.S. Industrial Area, Ringus, Sri Madhopur Ringus, Sikar 332404',
    latitude: '27.3766238',
    longitude: '75.5579722',
    phoneNumber: '9829405710',
  ),
  EwasteStation(
    name: 'M/s. Vinay Traders  ',
    address: 'F-241-242, RIICO Ind. Area, Palra, Ajmer',
    latitude: '26.4538854',
    longitude: '74.635194',
    phoneNumber: '	9352003958',
  ),
  EwasteStation(
    name: 'M/s GPS International ',
    address: 'G1-119 Industrial Area Manda Phase-I, Chomu, Jaipur- 303712  ',
    latitude: '27.1655759',
    longitude: '75.7158062',
    phoneNumber: '9829219739',
  ),
  EwasteStation(
    name: 'M/s Greenlet Recyclers Private Limited   ',
    address:
        'Plot No G-15-G, Sotanala Industrial Area, Behror, Tehsil- Behror, District-  Alwar',
    latitude: '27.8856475',
    longitude: '76.2844296',
    phoneNumber: '8560891100',
  ),
  EwasteStation(
    name: 'M/s Marss Recycler Private Limited   ',
    address:
        'G-5 Industrial Area Manda, Tehsil- Chomu (26 E-168 Near Meena Krishi Farm Murlipura Scheme Jaipur- 302039)',
    latitude: '26.9720543',
    longitude: '75.7628783',
    phoneNumber: '9079852683',
  ),
  EwasteStation(
    name: 'M/s S.B.J. & Company ',
    address: 'F-137, Growth Centre, RIICO Industrial Area, Dholpur ',
    latitude: '26.6965521',
    longitude: '77.8907576',
    phoneNumber: '9457835072',
  ),

  // Add more stations here
];
