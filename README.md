# YouTube Social App

A Flutter-based social media application that uses the YouTube API to allow users to browse, watch, and share YouTube videos. It includes features like a home feed, user profiles, and a video player.

## Features

- **Home Feed:** Displays a feed of trending YouTube videos with infinite scrolling.
- **Profile View:** View details about a specific YouTube channel, including their uploads.
- **Video Player:** A dedicated screen to watch videos.
- **Explore:** Discover new content.
- **Authentication:** User sign-in and profile management.

## Tech Stack

- **Framework:** [Flutter](https://flutter.dev/)
- **State Management:** [Riverpod](https://riverpod.dev/)
- **Routing:** [GoRouter](https://pub.dev/packages/go_router)
- **HTTP Client:** [Dio](https://pub.dev/packages/dio)
- **Code Generation:** [Freezed](https://pub.dev/packages/freezed) & [json_serializable](https://pub.dev/packages/json_serializable)
- **Environment Variables:** [flutter_dotenv](https://pub.dev/packages/flutter_dotenv)
- **UI:** [Google Fonts](https://pub.dev/packages/google_fonts), [Cached Network Image](https://pub.dev/packages/cached_network_image)
- **Authentication:** [Firebase Auth](https://pub.dev/packages/firebase_auth), [Google Sign-In](https://pub.dev/packages/google_sign_in)

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.7.0 or higher)
- A code editor like [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)

### Installation

1.  **Clone the repository:**
    ```sh
    git clone <YOUR_REPOSITORY_URL>
    cd gemini_project
    ```

2.  **Set up environment variables:**
    - Create a file named `.env` in the root of the project.
    - Add your YouTube Data API v3 key to the file:
      ```
      YOUTUBE_API_KEY='YOUR_API_KEY_HERE'
      ```

3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

4.  **Run the build_runner:**
    This is required to generate the necessary files for Freezed and Riverpod.
    ```sh
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

### Running the Application

1.  Make sure you have a device connected or an emulator running.

2.  Run the app:
    ```sh
    flutter run
    ```