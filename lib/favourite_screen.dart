import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePastryScreen extends StatefulWidget {
  const FavoritePastryScreen({Key? key, required List favoritePastries}) : super(key: key);

  @override
  _FavoritePastryScreenState createState() => _FavoritePastryScreenState();
}

class _FavoritePastryScreenState extends State<FavoritePastryScreen> {
  Set<String> favoritePastries = {};

  @override
  void initState() {
    super.initState();
    _loadFavorites();
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

  // Toggle favorite status for a pastry
  void _toggleFavorite(String pastry) {
    setState(() {
      if (favoritePastries.contains(pastry)) {
        favoritePastries.remove(pastry);
      } else {
        favoritePastries.add(pastry);
      }
    });
    _saveFavorites(); // Update SharedPreferences after change
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Pastries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadFavorites, // Reload favorites if needed
          ),
        ],
      ),
      body: favoritePastries.isEmpty
          ? const Center(child: Text('No favorite pastries yet.'))
          : ListView.builder(
              itemCount: favoritePastries.length,
              itemBuilder: (context, index) {
                String pastry = favoritePastries.elementAt(index);
                return ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  leading: Icon(
                    favoritePastries.contains(pastry)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: favoritePastries.contains(pastry)
                        ? Colors.red
                        : Colors.grey,
                  ),
                  title: Text(
                    pastry,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      favoritePastries.contains(pastry)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: favoritePastries.contains(pastry)
                          ? Colors.red
                          : Colors.grey,
                    ),
                    onPressed: () => _toggleFavorite(pastry),
                  ),
                  onTap: () {
                    // Handle on tap event, if needed
                  },
                );
              },
            ),
    );
  }
}
