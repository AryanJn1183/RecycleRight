import 'package:flutter/material.dart';
import 'package:recycleright/screens/qrcode_screen.dart';

class EBinScreen extends StatefulWidget {
  @override
  _EBinScreenState createState() => _EBinScreenState();
}

class _EBinScreenState extends State<EBinScreen> {
  int totalItems = 0;

  void updateTotalItems(int itemCount) {
    setState(() {
      totalItems += itemCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Let\'s get your items added in E-Bin!!'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_ebin.png'), // Replace 'assets/background_image.jpg' with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            ItemCounter(title: 'Battery(Mobile/Laptop etc)', updateTotalItems: updateTotalItems),
            ItemCounter(title: 'Wires/Cables/Power cords', updateTotalItems: updateTotalItems),
            ItemCounter(title: 'CPU', updateTotalItems: updateTotalItems),
            ItemCounter(title: 'CRT Monitor', updateTotalItems: updateTotalItems),
            ItemCounter(title: 'DVD Player', updateTotalItems: updateTotalItems),
            ItemCounter(title: 'Key Board', updateTotalItems: updateTotalItems),
            ItemCounter(title: 'Pen Drive', updateTotalItems: updateTotalItems),
            ItemCounter(title: 'Mouse', updateTotalItems: updateTotalItems),
            ItemCounter(title: 'Power bank', updateTotalItems: updateTotalItems),
            ItemCounter(title: 'Others', updateTotalItems: updateTotalItems),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('TOTAL ITEMS: $totalItems'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthenticationScreen(),
                        ),
                    );
                  },
                  child: Text('Done'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IconButton(
              icon: Image.asset('assets/icons/home_logo.png'),iconSize: 12,
              onPressed: () {
                // Add your logic here
              },
            ),
            IconButton(
              icon: Image.asset('assets/icons/profile_logo.png'),
              onPressed: () {
                // Add your logic here
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

class ItemCounter extends StatefulWidget {
  final String title;
  final Function(int) updateTotalItems;

  const ItemCounter({required this.title, required this.updateTotalItems});

  @override
  _ItemCounterState createState() => _ItemCounterState();
}

class _ItemCounterState extends State<ItemCounter> {
  int count = 0;

  void _incrementCount() {
    setState(() {
      count++;
      widget.updateTotalItems(1); // Update the total count
    });
  }

  void _decrementCount() {
    setState(() {
      if (count > 0) {
        count--;
        widget.updateTotalItems(-1); // Update the total count
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: _decrementCount,
            ),
            Text('$count'),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _incrementCount,
            ),
          ],
        ),
      ],
    );
  }
}
