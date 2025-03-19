// lib/services/favorite_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  // Save a favorite pastry to shared preferences
  Future<void> addFavorite(String pastry) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    favorites.add(pastry);
    await prefs.setStringList('favorites', favorites);
  }

  // Get all favorite pastries from shared preferences
  Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorites') ?? [];
  }

  // Remove a favorite pastry
  Future<void> removeFavorite(String pastry) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    favorites.remove(pastry);
    await prefs.setStringList('favorites', favorites);
  }
}
