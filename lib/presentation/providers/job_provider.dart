import 'package:flutter/foundation.dart';
import '../../domain/entities/job.dart';
import '../../domain/usecases/get_jobs_usecase.dart';
import '../../domain/usecases/toggle_favorite_usecase.dart';
import '../../domain/usecases/get_favorites_usecase.dart';

enum JobState { initial, loading, loaded, error }

class JobProvider with ChangeNotifier {
  final GetJobsUseCase _getJobsUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;
  final GetFavoritesUseCase _getFavoritesUseCase;

  JobProvider(
    this._getJobsUseCase,
    this._toggleFavoriteUseCase,
    this._getFavoritesUseCase,
  );

  JobState _state = JobState.initial;
  List<Job> _jobs = [];
  List<Job> _filteredJobs = [];
  List<Job> _favoriteJobs = [];
  String _errorMessage = '';
  String _searchQuery = '';

  JobState get state => _state;
  List<Job> get jobs => _filteredJobs.isEmpty && _searchQuery.isEmpty ? _jobs : _filteredJobs;
  List<Job> get favoriteJobs => _favoriteJobs;
  String get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;

  Future<void> loadJobs() async {
    _state = JobState.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      _jobs = await _getJobsUseCase();
      _filteredJobs = [];
      _searchQuery = '';
      _state = JobState.loaded;
      await loadFavorites();
    } catch (e) {
      _state = JobState.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }
    notifyListeners();
  }

  Future<void> loadFavorites() async {
    try {
      _favoriteJobs = await _getFavoritesUseCase();
      notifyListeners();
    } catch (e) {
      // Silent fail for favorites
      debugPrint('Error loading favorites: $e');
    }
  }

  Future<void> toggleFavorite(Job job) async {
    try {
      await _toggleFavoriteUseCase(job.id);
      
      // Update the job in the main list
      final index = _jobs.indexWhere((j) => j.id == job.id);
      if (index != -1) {
        _jobs[index] = _jobs[index].copyWith(isFavorite: !_jobs[index].isFavorite);
      }

      // Update filtered list if active
      if (_filteredJobs.isNotEmpty) {
        final filteredIndex = _filteredJobs.indexWhere((j) => j.id == job.id);
        if (filteredIndex != -1) {
          _filteredJobs[filteredIndex] = _filteredJobs[filteredIndex].copyWith(
            isFavorite: !_filteredJobs[filteredIndex].isFavorite,
          );
        }
      }

      await loadFavorites();
    } catch (e) {
      _errorMessage = 'Failed to update favorite: ${e.toString()}';
      notifyListeners();
    }
  }

  void searchJobs(String query) {
    _searchQuery = query.toLowerCase();
    
    if (_searchQuery.isEmpty) {
      _filteredJobs = [];
    } else {
      _filteredJobs = _jobs.where((job) {
        return job.title.toLowerCase().contains(_searchQuery) ||
               job.location.toLowerCase().contains(_searchQuery) ||
               job.company.toLowerCase().contains(_searchQuery);
      }).toList();
    }
    
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _filteredJobs = [];
    notifyListeners();
  }
}