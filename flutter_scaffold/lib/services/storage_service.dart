// lib/services/storage_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/follower.dart';

class StorageService {
  static const String _followersKey = 'followers';

  static Future<List<Follower>> loadFollowers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final followersJson = prefs.getStringList(_followersKey) ?? [];

      return followersJson
          .map((json) => Follower.fromJson(jsonDecode(json)))
          .toList();
    } catch (e) {
      print('Error loading followers: $e');
      return [];
    }
  }

  static Future<void> saveFollowers(List<Follower> followers) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final followersJson = followers
          .map((follower) => jsonEncode(follower.toJson()))
          .toList();
      await prefs.setStringList(_followersKey, followersJson);
    } catch (e) {
      print('Error saving followers: $e');
    }
  }
}
