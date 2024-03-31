import 'package:flutter/material.dart';
import 'package:recycleright/screens/maps_screen.dart';
import 'package:recycleright/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearching = false;
  bool isTypingUsername = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Logo
          Positioned(
            top: 40.0,
            left: 20.0,
            child: Image.asset(
              'assets/images/splash_logo.png',
              width: 100.0,
              height: 80.0,
            ),
          ),
          // Text Fields
          Positioned(
            top: 110.0,
            left: 20.0,
            right: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon and Text Field 1
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isSearching = true;
                            isTypingUsername = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 1.0),
                          decoration: BoxDecoration(
                            
                            color: Colors.green.shade200,
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: isSearching
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(0, 2),
                                    ),
                                  ]
                                : [],
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Source',
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.search, color: Colors.green.shade400),
                            ),
                            onTap: () {
                              setState(() {
                                isSearching = true;
                                isTypingUsername = false;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => GoogleMapSearchPlacesApi()),
                              );
                            },
                            onSubmitted: (value) {
                              setState(() {
                                isSearching = false;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Big Text
                SizedBox(height: 16.0),
                Text(
                  'E-Waste upDates',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                // Rectangular Boxes
                SizedBox(height: 16.0),
                Container(
                  height: 250.0,
                  width: double.infinity, // Take up available width
                  child: PageView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Add your logic here
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.0,vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green.shade200,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/images/home_1.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
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
