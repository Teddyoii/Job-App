import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/repositories/job_repository_impl.dart';
import 'data/datasources/local_storage.dart';
import 'domain/usecases/get_jobs_usecase.dart';
import 'domain/usecases/toggle_favorite_usecase.dart';
import 'domain/usecases/get_favorites_usecase.dart';
import 'presentation/providers/job_provider.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final localStorage = LocalStorage();
  await localStorage.init();
  
  final jobRepository = JobRepositoryImpl(localStorage);
  final getJobsUseCase = GetJobsUseCase(jobRepository);
  final toggleFavoriteUseCase = ToggleFavoriteUseCase(jobRepository);
  final getFavoritesUseCase = GetFavoritesUseCase(jobRepository);
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => JobProvider(
            getJobsUseCase,
            toggleFavoriteUseCase,
            getFavoritesUseCase,
          ),
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Job Listing App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.light,
            ),
            useMaterial3: true,
            cardTheme: CardThemeData(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
            cardTheme: CardThemeData(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          themeMode: themeProvider.themeMode,
          home: const HomePage(),
        );
      },
    );
  }
}