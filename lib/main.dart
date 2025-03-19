import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'spinwheel_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCZ0UFcc6vyCaPye0ltsx3cJ91DhT2xKAM",
      authDomain: "flutterassignment-55dd0.firebaseapp.com",
      projectId: "flutterassignment-55dd0",
      storageBucket: "flutterassignment-55dd0.appspot.com",
      messagingSenderId: "404425209229",
      appId: "1:404425209229:web:190b302e37474d10c239c4",
      measurementId: "G-Q8V4255J8V",
    ),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Future<bool> _checkAuthState() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      return currentUser != null;
    } catch (e) {
      print('FirebaseAuth error: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/spinwheel': (context) => const SpinWheelScreen(),
      },
      initialRoute: '/login', // Default route if user is not logged in
      home: FutureBuilder<bool>(
        future: _checkAuthState(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && snapshot.data == true) {
            // User is logged in, navigate to HomeScreen
            return const HomeScreen();
          } else {
            // User is not logged in, navigate to LoginScreen
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
