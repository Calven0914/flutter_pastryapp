import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'flashcard_screen.dart'; // Assuming you have this screen for the flashcard

class FindPastryScreen extends StatefulWidget {
  const FindPastryScreen({Key? key}) : super(key: key);

  @override
  _FindPastryScreenState createState() => _FindPastryScreenState();
}

class _FindPastryScreenState extends State<FindPastryScreen> {
  // Set to store favorite pastries
  Set<String> favoritePastries = {};

  @override
  void initState() {
    super.initState();
    _loadFavorites(); // Load favorites from SharedPreferences when the screen is initialized
  }

  // Load the favorite pastries from SharedPreferences
  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> loadedFavorites = prefs.getStringList('favorites')?.toSet() ?? {};
    setState(() {
      favoritePastries = loadedFavorites;
    });
  }

  // Save the favorite pastries to SharedPreferences
  Future<void> _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', favoritePastries.toList());
  }

  void toggleFavorite(String pastry) {
    setState(() {
      if (favoritePastries.contains(pastry)) {
        favoritePastries.remove(pastry);
      } else {
        favoritePastries.add(pastry);
      }
    });
    _saveFavorites(); // Save the updated favorites list after toggle
  }

  @override
  Widget build(BuildContext context) {
    // Map that associates countries with their pastries and images
    final Map<String, List<Map<String, String>>> countryPastries = {
      'France': [
        {'name': 'Croissant', 'image': 'assets/images/crois.jpg', 'difficulty': 'Easy', 'time': '30 minutes'},
        {'name': 'Baguette', 'image': 'assets/images/bagu.jpg', 'difficulty': 'Medium', 'time': '2 hours'},
        {'name': 'Macaron', 'image': 'assets/images/maca.jpg', 'difficulty': 'Hard', 'time': '3 hours'},
      ],
      'USA': [
        {'name': 'Donut', 'image': 'assets/images/donut.jpg', 'difficulty': 'Easy', 'time': '45 minutes'},
        {'name': 'Apple Pie', 'image': 'assets/images/applepie.jpg', 'difficulty': 'Medium', 'time': '1 hour'},
        {'name': 'Brownie', 'image': 'assets/images/brownie.jpg', 'difficulty': 'Easy', 'time': '35 minutes'},
      ],
      'Italy': [
        {'name': 'Castagnole', 'image': 'assets/images/casta.jpg', 'difficulty': 'Easy', 'time': '2 hours'},
        {'name': 'Cannoli', 'image': 'assets/images/canno.jpg', 'difficulty': 'Medium', 'time': '1 hour'},
        {'name': 'Sfogliatelle', 'image': 'assets/images/sfo.jpg', 'difficulty': 'Medium', 'time': '4 hours'},
      ],
      'Japan': [
        {'name': 'Mocha Roll', 'image': 'assets/images/macha.jpeg', 'difficulty': 'Medium', 'time': '1.5 hours'},
        {'name': 'Anpan', 'image': 'assets/images/anpan.jpg', 'difficulty': 'Medium', 'time': '1 hour'},
        {'name': 'Taiyaki', 'image': 'assets/images/taiyaki.jpg', 'difficulty': 'Medium', 'time': '1 hour'},
      ],
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Pastry You Would Love To Bake!!'),
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemCount: countryPastries.values.expand((e) => e).length,
          itemBuilder: (context, index) {
            var pastry = countryPastries.values.expand((e) => e).toList()[index];
            String name = pastry['name']!;
            String imageSrc = pastry['image']!;
            bool isFavorite = favoritePastries.contains(name);

            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  _showPastryPopup(context, name, imageSrc, pastry['difficulty']!, pastry['time']!, isFavorite);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        imageSrc,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                      onPressed: () {
                        toggleFavorite(name); // Toggle favorite status
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showPastryPopup(BuildContext context, String pastry, String imageSrc, String difficulty, String time, bool isFavorite) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(imageSrc, height: 200, width: 250, fit: BoxFit.cover),
                ),
                const SizedBox(height: 10),
                Text(
                  pastry,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text('Difficulty: $difficulty', style: const TextStyle(fontSize: 16)),
                Text('Time: $time', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the pop-up window
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Close'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FlashcardScreen(pastry: pastry),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('See Recipe'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
