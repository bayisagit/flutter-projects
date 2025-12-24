# Facebook Clone (Auth + Stories + Feed)

A Flutter app that mimics core Facebook flows:

- Splash screen with Facebook branding
- Firebase email/password login and signup
- Home with stories (24h) using Cloudinary for image uploads
- **News Feed with Posts (Create, View, Like, Comment)**
- Users list (Firestore) and logout

## Prerequisites

- Flutter SDK installed
- A Firebase project (already created)
- Cloudinary account (already created)

## Setup

1. Install dependencies:

   ```bash
   flutter pub get
   ```

2. Configure Firebase (choose ONE of the options):

   - Option A: Add platform config files

     - Android: place `google-services.json` under `android/app/`
     - iOS/macOS: place `GoogleService-Info.plist` under respective platform folder
     - Ensure Gradle integrates the files (standard Flutter Firebase setup)

   - Option B: Use FlutterFire CLI
     ```bash
     dart pub global activate flutterfire_cli
     flutterfire configure --project <your-firebase-project-id>
     ```
     This generates `lib/firebase_options.dart` and wires platform configs.
     **Note:** A placeholder `lib/firebase_options.dart` has been added. You must replace the placeholder values with your actual Firebase configuration keys if you don't use the CLI.

3. Configure Cloudinary:

   - Create an unsigned upload preset in Cloudinary (or use a secure backend for signed uploads).
   - Run with dart-define values:
     ```bash
     flutter run \
     	 --dart-define=CLOUDINARY_CLOUD_NAME=<your_cloud_name> \
     	 --dart-define=CLOUDINARY_UPLOAD_PRESET=<your_preset>
     ```

## Features

- **Authentication**: Sign up and Login with Email/Password.
- **Stories**: Upload and view stories that expire after 24 hours.
- **Feed**: View posts from all users ordered by date.
- **Create Post**: Share text and images (images require Cloudinary setup).
- **Interactions**: Like, Comment, and Share buttons (UI only for now).

## Run

```bash
flutter run
```

If you used dart-define, include them in the run command as shown above.

## Structure

- `lib/main.dart`: App entry, Firebase init, providers
- `lib/screens/`: `splash_screen.dart`, `login_screen.dart`, `signup_screen.dart`, `home_screen.dart`
- `lib/widgets/`: `stories_list.dart`, `users_list.dart`
- `lib/services/`: `auth_service.dart`, `user_service.dart`, `story_service.dart`
- `lib/models/`: `user_model.dart`, `story.dart`
- `lib/config.dart`: Cloudinary config (dart-define)

## Notes

- Stories are active for 24 hours and stored in Firestore under `stories`.
- User profiles are stored under `users` (uid as document id).
- Image uploads use Cloudinary via `cloudinary_public`. For production, prefer signed uploads via a backend.
