import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/job_provider.dart';
import '../widgets/job_list_item.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Jobs'),
      ),
      body: Consumer<JobProvider>(
        builder: (context, jobProvider, child) {
          final favoriteJobs = jobProvider.favoriteJobs;

          if (favoriteJobs.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 80,
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'No Favorite Jobs Yet',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Start adding jobs to your favorites by tapping the heart icon',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final isTablet = constraints.maxWidth > 600;
              
              if (isTablet) {
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: favoriteJobs.length,
                  itemBuilder: (context, index) {
                    return JobListItem(
                      job: favoriteJobs[index].copyWith(isFavorite: true),
                    );
                  },
                );
              }
              
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: favoriteJobs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: JobListItem(
                      job: favoriteJobs[index].copyWith(isFavorite: true),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}