import 'package:flutter/material.dart';
import 'package:recycleright/screens/home_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50.0),
              // Adjust the radius based on the image size
              CircleAvatar(
                radius: 80.0,
                backgroundImage: AssetImage('assets/images/user_image.png'),
              ),
              SizedBox(height: 20.0),
              Text(
                'R Krishnan Naidu',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.0),
              Text(
                'krishnannaidu@gmail.com',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Divider(),
              ProfileItem(title: 'E-Mail', icon: Icons.email),
              ProfileItem(title: 'Password', icon: Icons.lock),
              ProfileItem(title: 'UPI ID', icon: Icons.payment),
              Divider(),
              ElevatedButton(
                onPressed: () {
                  // Implement logout functionality
                },
                child: Text('Log out'),
              ),
            ],
          ),
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

class ProfileItem extends StatelessWidget {
  final String title;
  final IconData icon;

  ProfileItem({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        // Implement item tap functionality
      },
    );
  }
}