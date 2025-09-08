# Gemini Prompts: YouTube Social App (Flutter)

This document contains a series of prompts to generate the initial boilerplate code for the Flutter application based on the development plan.

---

### **Phase 1: Project Setup & Core Foundation**

**1. Create `lib/core/theme/theme.dart`:**
"Generate the Dart code for a file named `theme.dart`. It should contain two classes: `AppColors` and `AppTheme`. `AppColors` should be an abstract class with no instances, containing a static const `background` color of `0xFF070301`. `AppTheme` should have a static method `darkTheme()` that returns a `ThemeData` object. This `ThemeData` should have its `scaffoldBackgroundColor` set to `AppColors.background`, and its `textTheme` should be initialized using `GoogleFonts.poppinsTextTheme()` applied to a dark `TextTheme`."

**2. Create `lib/core/constants/api_constants.dart`:**
"Generate the Dart code for a file named `api_constants.dart`. It should contain one class `ApiConstants` with a single static const string variable `baseUrl` set to `'https://www.googleapis.com/youtube/v3'`. The class should be abstract and uninstantiable."

**3. Create `.env` file:**
"Generate the content for a `.env` file. It should contain one line: `YOUTUBE_API_KEY='YOUR_API_KEY_HERE'`."

**4. Create `lib/core/services/dio_service.dart`:**
"Generate a Riverpod provider for a Dio instance in `dio_service.dart`. The provider should be named `dioProvider`. The Dio instance it provides should have its `baseUrl` set from `ApiConstants.baseUrl`. Add an `InterceptorsWrapper` that, on every request (`onRequest`), reads the `YOUTUBE_API_KEY` from `flutter_dotenv` and adds it as a query parameter named 'key'. Also, include a basic `onError` handler that prints the `DioException`."

**5. Create `lib/core/routes/router.dart`:**
"Generate the code for a GoRouter configuration in `router.dart`. Create a Riverpod provider named `routerProvider` that returns a `GoRouter` instance. The router should have the following routes: `/` pointing to a placeholder `AuthView`, `/feed` pointing to `FeedView`, `/profile/:channelId` pointing to `ProfileView`, `/player/:videoId` pointing to `PlayerView`, and `/explore` pointing to `ExploreView`. Create placeholder `Scaffold` widgets for each of these view classes for now."

**6. Create `lib/main.dart`:**
"Generate the `main.dart` file for a Flutter app. It should be asynchronous. Inside `main`, it must first call `await dotenv.load(fileName: '.env')`. The root widget should be a `ProviderScope` that wraps a `ConsumerWidget` named `MyApp`. `MyApp` should build a `MaterialApp.router`, configuring its `routerConfig` with the `routerProvider` and its `theme` with `AppTheme.darkTheme()`."

---

### **Phase 3: Home Feed Feature**

**1. Create `lib/features/feed/model/video_post_model.dart`:**
"Generate a Freezed data class in `video_post_model.dart` named `VideoPost`. It should have properties for `videoId` (String), `title` (String), `thumbnailUrl` (String), `channelName` (String), `channelAvatarUrl` (String), and `viewCount` (String). Include the necessary `part` directives and a factory constructor `fromJson` for JSON serialization."

**2. Create `lib/features/feed/service/feed_repository.dart`:**
"Generate the code for `feed_repository.dart`. Create a class `FeedRepository` that takes a `Dio` instance in its constructor. Create a Riverpod provider `feedRepositoryProvider` that provides an instance of `FeedRepository`, getting the Dio instance from `dioProvider`. The class should have one method: `Future<List<VideoPost>> fetchTrendingVideos({int page = 1})`. Leave the method body empty for now."

**3. Create `lib/features/feed/controller/feed_controller.dart`:**
"Generate a Riverpod `AsyncNotifierProvider` in `feed_controller.dart`. The notifier should be named `FeedController` and the provider `feedControllerProvider`. The `build` method should call the `fetchTrendingVideos` method from `feedRepositoryProvider`. Implement a method `fetchMoreVideos` to handle pagination logic."

---

### **Phase 4: Profile Feature**

**1. Create `lib/features/profile/model/channel_model.dart`:**
"Generate a Freezed data class in `channel_model.dart` named `Channel`. It needs properties for `id` (String), `title` (String), `avatarUrl` (String), `subscriberCount` (String), and `description` (String). Include the `part` files and a `fromJson` factory."

**2. Create `lib/features/profile/service/profile_repository.dart`:**
"Generate the code for `profile_repository.dart`. Create a `ProfileRepository` class with a `Dio` dependency. Create a `profileRepositoryProvider`. The class should have two methods: `Future<Channel> fetchChannelDetails(String channelId)` and `Future<List<VideoPost>> fetchChannelVideos(String channelId)`."

**3. Create `lib/features/profile/controller/profile_controller.dart`:**
"Generate a Riverpod `AsyncNotifierProvider.family` in `profile_controller.dart`. The family parameter should be `String channelId`. The notifier, `ProfileController`, should fetch both channel details and channel videos from the `profileRepositoryProvider` in its `build` method and combine them into a single state object."