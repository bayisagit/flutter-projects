import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/// Initializes Firebase. Requires platform-specific config files
/// (google-services.json for Android, GoogleService-Info.plist for iOS/macOS)
/// or running FlutterFire CLI to generate firebase_options.dart.
Future<void> initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
