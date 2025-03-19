import 'package:flutter/material.dart';
import 'findpastry_screen.dart';
import 'spinwheel_screen.dart';
import 'favourite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Pages to display based on the selected index
  static const List<Widget> _pages = <Widget>[
    FindPastryScreen(),
    SpinWheelScreen(),
    FavoritePastryScreen(favoritePastries: []), // You can add a screen for favorites
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Logout confirmation dialog
  Future<void> _showLogoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap one of the buttons
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without logging out
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Perform your logout logic here
                // For example, navigate to login screen or clear session
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logging out...')),
                );

                // Navigate to the LoginScreen after logout
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pastry Wizard'),
        backgroundColor: Colors.pink.shade400, // Consistent color with bottom navigation
      ),
      body: _pages[_selectedIndex], // Display selected page
      drawer: Drawer(
        child: Container(
          color: Colors.grey.shade900, // Dark background for better contrast
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.pinkAccent, // Soft pastry color for the header
                ),
                child: Text(
                  'Pastry Wizard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.search, color: Colors.white),
                title: const Text('Find Pastry', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: const Icon(Icons.casino, color: Colors.white),
                title: const Text('Spin Wheel', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite, color: Colors.white),
                title: const Text('Favorites', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                  Navigator.pop(context); // Close the drawer
                },
              ),
              const Divider(color: Colors.white), // Divider between items for better separation
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text('Logout', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  _showLogoutDialog(); // Show the logout confirmation dialog
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Find Pastry',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.casino),
            label: 'Spin Wheel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites', // A new screen for favorites
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink.shade400, // Pastry pink color for selected item
        unselectedItemColor: Colors.brown.shade400, // Soft brown for unselected items
        backgroundColor: Colors.yellow.shade100, // Light pastel yellow background
        onTap: _onItemTapped,
      ),
    );
  }
}


