# YouTube Social App (Flutter) - Development Plan

---

This plan outlines all necessary steps, organized by feature, to build a fully functional, production-ready application.

**Tech Stack:**

- **State Management:** Flutter Riverpod
- **Networking:** Dio
- **Fonts:** google_fonts (Poppins)
- **Architecture:** Core/Features structure

---

### **Phase 1: Project Setup & Core Foundation**

*This phase establishes the project's skeleton, dependencies, and core services that all features will rely on.*

- [x]  **1. Project Initialization & Dependencies**
    - Create a new Flutter project.
    - In `pubspec.yaml`, add the following dependencies:
        - `flutter_riverpod`: For state management.
        - `dio`: For powerful and predictable network requests.
        - `google_fonts`: To use the Poppins font.
        - `flutter_dotenv`: To securely manage your YouTube API key.
        - `youtube_player_flutter`: For native video playback.
        - `go_router`: For declarative, URL-based navigation.
        - `cached_network_image`: For efficient image loading and caching.
        - `freezed_annotation` & `json_annotation`: For robust data models.
    - Add build dependencies (`build_runner`, `freezed`, `json_serializable`).
- [x]  **2. Directory Structure & Architecture**
    - Create the specified folder structure: `lib/core`, `lib/features`, `lib/main.dart`.
    - Set up all sub-directories inside `core` (theme, constants, routes, services, utils).
    - Create feature folders: `auth`, `feed`, `profile`, `player`, and `explore`.
- [x]  **3. Core Implementation**
    - **Theme (`core/theme/theme.dart`):**
        - Define `AppColors` (e.g., `background = const Color(0xFF070301)`).
        - Define `AppTheme` with `ThemeData` using `GoogleFonts.poppinsTextTheme()` and apply your custom colors.
    - **Constants (`core/constants/`):**
        - Create `api_constants.dart` for the YouTube API base URL.
        - Create a `.env` file for your `YOUTUBE_API_KEY` and add it to `.gitignore`.
    - **Networking (`core/services/dio_service.dart`):**
        - Create a Riverpod Provider that exposes a configured Dio instance.
        - Add a Dio Interceptor to automatically inject the API key into every request.
        - Implement a centralized `DioException` handler to normalize network errors.
    - **Routing (`core/routes/router.dart`):**
        - Configure GoRouter with routes for all screens:
            - `/`: Login or Feed screen.
            - `/feed`: The main feed.
            - `/profile/:channelId`: The creator profile screen.
            - `/player/:videoId`: The video player screen.
            - `/explore`: The explore/search screen.
    - **Main (`main.dart`):**
        - Initialize `flutter_dotenv`.
        - Wrap the app in a `ProviderScope`.
        - Configure `MaterialApp.router` to use the defined GoRouter instance and the custom `AppTheme`.

---

### **Phase 2: Authentication Feature (`features/auth`)**

*Handles user sign-in to enable personalized features like viewing subscriptions.*

- [x]  **1. Service (`features/auth/service/auth_service.dart`):**
    - Add the `google_sign_in` package.
    - Implement methods for `signInWithGoogle()` and `signOut()`.
- [x]  **2. Controller (`features/auth/controller/auth_controller.dart`):**
    - Create a `NotifierProvider` to manage the user's authentication state.
- [x]  **3. View (`features/auth/view/auth_view.dart`):**
    - Create a simple login screen with a "Sign in with Google" button.
    - Listen to the controller's state to navigate to the feed upon successful login.

---

### **Phase 3: Home Feed Feature (`features/feed`)**

*The main screen of the app: a vertically scrolling, TikTok-style feed of videos.*

- [x]  **1. Model (`features/feed/model/video_post_model.dart`):**
    - Create a `VideoPost` model using Freezed with all necessary fields (videoId, title, thumbnailUrl, channel info, stats).
- [x]  **2. Service (`features/feed/service/feed_repository.dart`):**
    - Create a repository that uses the Dio provider.
    - Implement `fetchTrendingVideos()` and (for logged-in users) `fetchSubscriptionFeed()`.
- [x]  **3. Controller (`features/feed/controller/feed_controller.dart`):**
    - Create an `AsyncNotifierProvider` to fetch and manage the list of video posts.
    - Implement pagination logic to load more videos as the user scrolls.
- [x]  **4. View (`features/feed/view/feed_view.dart`):**
    - Use a `ConsumerWidget` to watch the provider.
    - Implement `provider.when()` to build the UI for loading, error, and data states.
    - Handle the empty state within the data state.
    - Use a `PageView.builder` to display a list of `VideoPostWidgets`.

---

### **Phase 4: Profile Feature (`features/profile`)**

*The screen that displays a YouTube creator's channel information and videos.*

- [x]  **1. Model (`features/profile/model/channel_model.dart`):**
    - Create a `Channel` model using Freezed.
- [x]  **2. Service (`features/profile/service/profile_repository.dart`):**
    - Implement `fetchChannelDetails(channelId)` and `fetchChannelVideos(channelId)`.
- [x]  **3. Controller (`features/profile/controller/profile_controller.dart`):**
    - Use an `AsyncNotifierProvider.family` to fetch data for a specific `channelId`.
- [x]  **4. View (`features/profile/view/profile_view.dart`):**
    - The screen will receive the `channelId` from the router.
    - Use `provider.when()` for loading, error, and data states.
    - Build the profile UI and a `GridView.builder` for the videos.

---

### **Phase 5: Community/Explore Feature (`features/explore`)**

*A replacement for the "Community" tab, focusing on search and discovery.*

- [x]  **1. Service (`features/explore/service/explore_repository.dart`):**
    - Implement `searchVideos(query)` and `fetchTrendingCategories()`.
- [x]  **2. Controller (`features/explore/controller/explore_controller.dart`):**
    - Create a provider to manage search state (query, results, status).
- [x]  **3. View (`features/explore/view/explore_view.dart`):**
    - Build a UI with a prominent search bar and display results in a list.
    - Handle loading, error, data, and empty states.

---

### **Phase 6: App Navigation & Video Player**

*Tying all the features together with navigation and implementing video playback.*

- [x]  **1. Main App Shell (`features/shell/view/shell_view.dart`):**
    - Create a stateful shell widget that contains the `BottomNavigationBar`.
    - The GoRouter configuration will use this shell to wrap the main feature screens.
- [x]  **2. Video Player Feature (`features/player`):**
    - **View (`features/player/view/player_view.dart`):**
        - Create a screen that accepts a `videoId` from the router.
        - Integrate and configure the `youtube_player_flutter` widget.
    - **Action:** Ensure that tapping on any video thumbnail navigates to this screen.

---

### **Phase 7: Production Readiness**

*Final steps to ensure the app is stable, performant, and ready for release.*

- [x]  **1. Caching:** Implement a caching strategy for Dio.
- [x]  **2. Finalize Error Handling:** Review all error states and integrate a crash reporting service.
    - [x] Created a basic error handling mechanism.
    - [x] Integrate a crash reporting service.
- [ ]  **3. Testing:** Write unit tests for repositories/controllers and widget tests for key components,withauth.
    - [x] Wrote unit tests for FeedRepository,.
- [ ]  **4. Optimization & Polish:** Profile the app and add subtle animations.
- [ ]  **5. Deployment:** Create app icons/splash screens and release to the app stores.