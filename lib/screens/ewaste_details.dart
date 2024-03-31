import 'package:flutter/material.dart';
import 'package:recycleright/screens/ebin_screen.dart';
import 'package:recycleright/screens/home_screen.dart';
import 'package:recycleright/screens/profile_screen.dart';
import 'package:recycleright/screens/schedule_pickup.dart';

class EwasteStationDetailsScreen extends StatelessWidget {
  final String name;
  final String address;

  const EwasteStationDetailsScreen({
    Key? key,
    required this.name,
    required this.address,
  }) : super(key: key);

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(''),
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16.0),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.green.shade300,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  address,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700
                  ),
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          // Add the rectangular box here
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 50),
            decoration: BoxDecoration(
              color: Color(0xFF56A689), // Adjust color as needed
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/pickup.png', // Replace with your image path
                        width: 100, // Adjust size as needed
                        height: 100,
                      ),
                      SizedBox(height: 8.0),
                      ElevatedButton(
                        onPressed: () {
                           Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SchedulePickupScreen(),
                        ),
                          );
                        },
                        child: Text('Pickup at your Door',style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black,),),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/doorstep.png', // Replace with your image path
                        width: 800, // Adjust size as needed
                        height: 100,
                      ),
                      SizedBox(height: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EBinScreen(),
                        ),
                          );
                        },
                        child: Text('Drop at Centre',style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black,)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Implement the call functionality here
                },
                child: Text('Call'),
              ),
              SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () {
                  // Implement the directions functionality here
                },
                child: Text('Directions'),
              ),
            ],
          ),
        ],
      ),
    ),
    bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Image.asset('assets/icons/home_logo.png',),
              onPressed: () {
                // Add your logic here
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
              },
            ),
            IconButton(
              icon: Image.asset('assets/icons/profile_logo.png'),
              onPressed: () {
                // Add your logic here
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
              },
            ),
            IconButton(
              icon: Image.asset('assets/icons/rewards_logo.png'),
              onPressed: () {
                // Add your logic here
              },
            ),
            IconButton(
              icon: Image.asset('assets/icons/community_logo.png'),
              onPressed: () {
                // Add your logic here
              },
            ),
          ],
        ),
      ),
  );
}
}
