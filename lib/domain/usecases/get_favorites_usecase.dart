import '../entities/job.dart';
import '../repositories/job_repository.dart';

class GetFavoritesUseCase {
  final JobRepository repository;

  GetFavoritesUseCase(this.repository);

  Future<List<Job>> call() async {
    return await repository.getFavoriteJobs();
  }
}