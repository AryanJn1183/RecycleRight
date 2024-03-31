import 'package:flutter/material.dart';
import 'package:recycleright/screens/home_screen.dart';

class UserInfoForm extends StatefulWidget {
  @override
  _UserInfoFormState createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _upiIdController = TextEditingController();

  void _submitForm() {
    // Here, you can send the data to your backend database
    String name = _nameController.text;
    String mobile = _mobileController.text;
    String address = _addressController.text;
    String upiId = _upiIdController.text;

    // Add your backend API call or database storage logic here
    print('Name: $name, Mobile: $mobile, Address: $address, UPI Id: $upiId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 280, // Adjust the height as needed
            decoration: BoxDecoration(
              color: Colors.green.shade300, // Change the color as needed
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 300, 20, 10), // Adjusted padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 40), // Adjust the height to match the container
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  SizedBox(height: 2.0),
                  TextField(
                    controller: _mobileController,
                    decoration: InputDecoration(labelText: 'Mobile'),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 2.0),
                  TextField(
                    controller: _addressController,
                    decoration: InputDecoration(labelText: 'Address'),
                  ),
                  SizedBox(height: 2.0),
                  TextField(
                    controller: _upiIdController,
                    decoration: InputDecoration(labelText: 'UPI Id'),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}