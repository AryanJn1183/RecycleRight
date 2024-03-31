import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recycleright/screens/home_screen.dart';
import 'package:recycleright/screens/signin.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _userTypeController = TextEditingController();

  Future<void> _register() async {
    const url = "https://awadheshg.pythonanywhere.com/accounts/api/signup/";
    final response = await http.post(
      Uri.parse(url),
      body: {
        'username': _usernameController.text,
        'email': _emailController.text,
        'password1': _passwordController.text,
        'password2': _passwordController.text,
        'user_type': 'seller',
      },
    );
    if (response.statusCode == 201) {
      // Successful signup
      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to register. Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30,),
                Image.asset('assets/images/signup_image.png'),
                SizedBox(height: 15.0),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    fillColor: Colors.green.shade200,
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    fillColor: Colors.green.shade200,
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    fillColor: Colors.green.shade200,
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                SizedBox(height: 20.0),
               SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _register,
                  child: Text('LogIn', style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    backgroundColor: Color(0xFF80BCA7),
                  ),
                ),
              ),
                SizedBox(height: 15.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}