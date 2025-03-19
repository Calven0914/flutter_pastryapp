import 'dart:math';
import 'package:flutter/material.dart';
import 'flashcard_screen.dart'; // Ensure this is imported

class SpinWheelScreen extends StatefulWidget {
  const SpinWheelScreen({Key? key}) : super(key: key);

  @override
  _SpinWheelScreenState createState() => _SpinWheelScreenState();
}

class _SpinWheelScreenState extends State<SpinWheelScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final List<String> _pastries = [
    'Croissant',
    'Baguette',
    'Macaron',
    'Mocha Roll',
    'Donut',
    'Apple Pie',
    'Brownie',
    'Castagnole',
    'Cannoli',
    'Sfogliatelle',
    'Anpan',
    'Taiyaki',
  ];
  String _selectedPastry = '';
  bool _isSpinning = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _animation = Tween<double>(begin: 0, end: 360).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    )..addListener(() {
        setState(() {});
      });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _determineResult();
        setState(() {
          _isSpinning = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _spinWheel() {
    if (!_isSpinning) {
      setState(() {
        _isSpinning = true;
      });
      _controller.reset();
      _controller.forward();
    }
  }

  void _determineResult() {
    final randomIndex =
        Random().nextInt(_pastries.length); // Get random pastry index
    setState(() {
      _selectedPastry = _pastries[randomIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spin for Pastry'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: _animation.value * pi / 5,
              child: Container(
                height: 500,
                width: 500,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/wheel.png'), // Custom wheel image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_selectedPastry.isNotEmpty && !_isSpinning)
              Column(
                children: [
                  Text(
                    'You got: $_selectedPastry!',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.refresh),
                        label: const Text('Spin Again'),
                        onPressed: _spinWheel,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.receipt),
                        label: const Text('See Recipe'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FlashcardScreen(pastry: _selectedPastry),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            if (_isSpinning)
              const CircularProgressIndicator(), // Show a spinner while spinning
            if (!_isSpinning)
              ElevatedButton(
                onPressed: _spinWheel,
                child: const Text('Spin the Wheel'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  textStyle: const TextStyle(fontSize: 20),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
