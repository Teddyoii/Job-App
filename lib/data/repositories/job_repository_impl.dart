import '../../domain/entities/job.dart';
import '../../domain/repositories/job_repository.dart';
import '../datasources/api_service.dart';
import '../datasources/local_storage.dart';

class JobRepositoryImpl implements JobRepository {
  final ApiService _apiService = ApiService();
  final LocalStorage _localStorage;

  JobRepositoryImpl(this._localStorage);

  @override
  Future<List<Job>> getJobs() async {
    final jobs = await _apiService.fetchJobs();
    final favoriteIds = await _localStorage.getFavoriteJobIds();
    
    // Mark jobs as favorite if they're in the favorites list
    return jobs.map((job) {
      return job.copyWith(isFavorite: favoriteIds.contains(job.id));
    }).toList();
  }

  @override
  Future<void> toggleFavorite(String jobId) async {
    final isFavorite = await _localStorage.isFavorite(jobId);
    
    if (isFavorite) {
      await _localStorage.removeFavoriteJob(jobId);
    } else {
      final jobs = await getJobs();
      final job = jobs.firstWhere((j) => j.id == jobId);
      await _localStorage.saveFavoriteJob(job);
    }
  }

  @override
  Future<List<Job>> getFavoriteJobs() async {
    return await _localStorage.getFavoriteJobs();
  }

  @override
  Future<List<String>> getFavoriteJobIds() async {
    return await _localStorage.getFavoriteJobIds();
  }
}