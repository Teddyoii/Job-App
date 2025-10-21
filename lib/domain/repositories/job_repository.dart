import '../entities/job.dart';

abstract class JobRepository {
  Future<List<Job>> getJobs();
  Future<void> toggleFavorite(String jobId);
  Future<List<Job>> getFavoriteJobs();
  Future<List<String>> getFavoriteJobIds();
}