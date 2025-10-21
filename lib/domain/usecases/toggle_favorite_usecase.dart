import '../repositories/job_repository.dart';

class ToggleFavoriteUseCase {
  final JobRepository repository;

  ToggleFavoriteUseCase(this.repository);

  Future<void> call(String jobId) async {
    await repository.toggleFavorite(jobId);
  }
}