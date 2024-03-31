import 'package:flutter/material.dart';
import 'package:recycleright/screens/home_screen.dart';
import 'package:recycleright/screens/profile_screen.dart';

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication',style: TextStyle(fontWeight: FontWeight.w700),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.recycling,
                    color: Colors.white,
                    size: 40.0,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Each device we discard represents an opportunity to create a sustainable future. By raising our awareness and taking responsible actions, we can turn the tide against e-waste.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Scan the QR Code at the Centre',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            Image.asset(
              'assets/images/qr.png', // Replace with your QR code image path
              width: 200.0,
              height: 200.0,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Implement the Share QR Code functionality here
              },
              child: Text('Share QR Code'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Share the QR code for a seamless and efficient experience.',
              textAlign: TextAlign.center,
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