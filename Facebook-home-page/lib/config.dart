class AppConfig {
  // Provide these via --dart-define when running the app
  // flutter run --dart-define=CLOUDINARY_CLOUD_NAME=your_name --dart-define=CLOUDINARY_UPLOAD_PRESET=your_preset
  static const String cloudinaryCloudName = String.fromEnvironment(
    'CLOUDINARY_CLOUD_NAME',
    defaultValue: 'doz1fanub',
  );
  static const String cloudinaryUploadPreset = String.fromEnvironment(
    'CLOUDINARY_UPLOAD_PRESET',
    defaultValue: 'fb-flutter-app',
  );
}
