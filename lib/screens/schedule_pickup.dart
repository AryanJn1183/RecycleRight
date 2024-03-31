import 'package:flutter/material.dart';
import 'package:recycleright/screens/ebin_screen.dart';
import 'package:recycleright/screens/home_screen.dart';
import 'package:recycleright/screens/profile_screen.dart';

class SchedulePickupScreen extends StatefulWidget {
  @override
  _SchedulePickupScreenState createState() => _SchedulePickupScreenState();
}

class _SchedulePickupScreenState extends State<SchedulePickupScreen> {
  String _selectedDate = '';
  String _selectedAddress =
      '85, Girraj Vihar, opposite EPIP India Gate, Sitapura, Jaipur, Rajasthan 302022';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Schedule your Pick Up at your own time !!',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: Card(
          elevation: 5,
          margin: EdgeInsets.all(16.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                    Text(
                      'Selected Date: $_selectedDate',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Address: $_selectedAddress',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EBinScreen()),
                    );
                  },
                  child: Text('Confirm Pickup'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Image.asset(
                'assets/icons/home_logo.png',
              ),
              onPressed: () {
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
