# Job Listing App 
A comprehensive Flutter application demonstrating clean architecture, state management with Provider, REST API integration, and modern UI/UX practices.

# ✨ Features Implemented

✅ Job List Page - Fetches and displays jobs from MockAPI

✅ Job Details Page - Detailed view with full job information

✅ Search & Filter - Real-time search by title, location, or company

✅ Favorite Jobs - Save favorites with persistent storage using shared_preferences

✅ Provider State Management - Clean state management architecture

✅ Responsive Design - Adapts to phones and tablets (grid layout on tablets)

✅ Error Handling - Comprehensive error handling with user-friendly messages

✅ Theme Switching - Complete dark/light mode with persistent preferences

✅ Animations - Smooth page transitions and micro-interactions

✅ Pull-to-refresh - Swipe down to refresh job listings

✅ Hero Animations - Smooth transitions between screens

✅ Empty States - Beautiful empty state designs for no results/favorites


## 🏗️ Architecture
The project follows Clean Architecture principles with clear separation of concerns:
```
lib/
├── data/
│   ├── datasources/
│   │   ├── api_service.dart          # REST API integration
│   │   └── local_storage.dart        # SharedPreferences wrapper
│   └── repositories/
│       └── job_repository_impl.dart  # Repository implementation
├── domain/
│   ├── entities/
│   │   └── job.dart                  # Job entity model
│   ├── repositories/
│   │   └── job_repository.dart       # Repository interface
│   └── usecases/
│       ├── get_jobs_usecase.dart
│       ├── toggle_favorite_usecase.dart
│       └── get_favorites_usecase.dart
├── presentation/
│   ├── pages/
│   │   ├── home_page.dart
│   │   ├── job_details_page.dart
│   │   └── favorites_page.dart
│   ├── providers/
│   │   ├── job_provider.dart         # Main state management
│   │   └── theme_provider.dart       # Theme state management
│   └── widgets/
│       ├── job_list_item.dart
│       └── search_bar_widget.dart
└── main.dart

```

## 🔧 Error Handling
The app handles various error scenarios:

✅Network connectivity issues

✅API timeouts (10 second limit)

✅404 Not Found errors

✅Server errors (5xx)

✅Invalid JSON responses

✅Local storage failures

✅Each error provides a clear message and recovery option.

## 📸 Screenshots

<img width="1080" height="2400" alt="Screenshot_1761065715" src="https://github.com/user-attachments/assets/d6fd6d21-3116-4b8e-b1d0-1279f4b6ca31" />
<img width="1080" height="2400" alt="Screenshot_1761065706" src="https://github.com/user-attachments/assets/29573083-d862-4526-855e-6e91ac34b140" />
<img width="1080" height="2400" alt="Screenshot_1761065669" src="https://github.com/user-attachments/assets/dc2e5d40-8eba-4e01-8ac7-d35effb1de05" />
<img width="1080" height="2400" alt="Screenshot_1761065661" src="https://github.com/user-attachments/assets/99740830-fa6c-4e97-aee6-31755cb49b0c" />
<img width="1080" height="2400" alt="Screenshot_1761065657" src="https://github.com/user-attachments/assets/c395d11d-81d4-4937-96c6-f4b290944f90" />



## Mock Data

<img width="756" height="588" alt="mock data" src="https://github.com/user-attachments/assets/4ee021e8-7715-48ed-bdf4-0ce99f6beb64" />




