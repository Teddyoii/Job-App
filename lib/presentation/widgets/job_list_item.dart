import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/job.dart';
import '../providers/job_provider.dart';
import '../pages/job_details_page.dart';

class JobListItem extends StatelessWidget {
  final Job job;

  const JobListItem({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Hero(
      tag: 'job_${job.id}',
      child: Material(
        color: Colors.transparent,
        child: Card(
          elevation: 3,
          shadowColor: colorScheme.shadow.withOpacity(0.3),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      JobDetailsPage(job: job),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end).chain(
                      CurveTween(curve: curve),
                    );
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                ),
              );
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Company Logo Placeholder
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.business,
                          color: colorScheme.primary,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Job Title and Company
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              job.title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              job.company,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      // Favorite Button
                      Consumer<JobProvider>(
                        builder: (context, jobProvider, child) {
                          return IconButton(
                            icon: Icon(
                              job.isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: job.isFavorite ? Colors.red : colorScheme.onSurfaceVariant,
                            ),
                            onPressed: () {
                              jobProvider.toggleFavorite(job);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Location and Job Type
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _JobTag(
                        icon: Icons.location_on_outlined,
                        label: job.location,
                        color: colorScheme.secondary,
                      ),
                      _JobTag(
                        icon: Icons.work_outline,
                        label: job.jobType,
                        color: colorScheme.tertiary,
                      ),
                      if (job.salary != null)
                        _JobTag(
                          icon: Icons.attach_money,
                          label: job.salary!,
                          color: colorScheme.primary,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _JobTag extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _JobTag({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}