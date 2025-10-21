import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/job.dart';

class LocalStorage {
  static const String _favoritesKey = 'favorite_jobs';
  static const String _favoriteIdsKey = 'favorite_job_ids';
  
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveFavoriteJob(Job job) async {
    final favorites = await getFavoriteJobs();
    
    // Check if job already exists
    if (!favorites.any((j) => j.id == job.id)) {
      favorites.add(job);
      final jsonList = favorites.map((j) => j.toJson()).toList();
      await _prefs?.setString(_favoritesKey, json.encode(jsonList));
      
      // Also save IDs separately for quick lookup
      final ids = favorites.map((j) => j.id).toList();
      await _prefs?.setStringList(_favoriteIdsKey, ids);
    }
  }

  Future<void> removeFavoriteJob(String jobId) async {
    final favorites = await getFavoriteJobs();
    favorites.removeWhere((job) => job.id == jobId);
    
    final jsonList = favorites.map((j) => j.toJson()).toList();
    await _prefs?.setString(_favoritesKey, json.encode(jsonList));
    
    // Update IDs list
    final ids = favorites.map((j) => j.id).toList();
    await _prefs?.setStringList(_favoriteIdsKey, ids);
  }

  Future<List<Job>> getFavoriteJobs() async {
    final jsonString = _prefs?.getString(_favoritesKey);
    if (jsonString == null) return [];
    
    try {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => Job.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<String>> getFavoriteJobIds() async {
    return _prefs?.getStringList(_favoriteIdsKey) ?? [];
  }

  Future<bool> isFavorite(String jobId) async {
    final ids = await getFavoriteJobIds();
    return ids.contains(jobId);
  }
}