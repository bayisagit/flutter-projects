import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // e.g. "Addis Ababa"
  String time; // e.g. "8:45 PM"
  String flag; // e.g. "ethiopia.png"
  String url; // e.g. "Africa/Addis_Ababa"
  bool isDaytime;

  WorldTime({
    required this.location,
    required this.flag,
    required this.url,
    this.time = '',
    this.isDaytime = true,
  });

  Future<void> getTime() async {
    const int maxRetries = 3;
    int attempt = 0;

    while (attempt < maxRetries) {
      attempt++;
      try {
        print('⏳ Attempt $attempt: Requesting time from $url');

        // Main API endpoint (HTTPS for mobile)
        String apiUrl = 'https://worldtimeapi.org/api/timezone/$url';

        // If running on web, use CORS proxy
        // Flutter Web needs this to bypass browser restrictions
        final uri = Uri.parse(
          'https://corsproxy.io/?$apiUrl',
        );

        // Wait for response with timeout
        final response = await http.get(uri).timeout(const Duration(seconds: 10));

        if (response.statusCode != 200) {
          print('❌ HTTP Error: ${response.statusCode}');
          time = 'Could not get time data: HTTP ${response.statusCode}';
          isDaytime = false;
          return;
        }

        final data = jsonDecode(response.body);
        print('✅ API Response received successfully');

        final datetime = data['datetime'];
        final utcOffset = data['utc_offset']; // e.g. "+03:00"

        // Parse offset
        final sign = utcOffset[0];
        final hours = int.parse(utcOffset.substring(1, 3));
        final minutes = int.parse(utcOffset.substring(4, 6));

        // Adjust time
        DateTime now = DateTime.parse(datetime);
        Duration offsetDuration = Duration(hours: hours, minutes: minutes);
        now = sign == '+' ? now.add(offsetDuration) : now.subtract(offsetDuration);

        // Format time and day status
        isDaytime = now.hour > 6 && now.hour < 20;
        time = DateFormat.jm().format(now);

        print('🕒 Parsed Time: $time | 🌞 Daytime: $isDaytime');
        return;
      } on TimeoutException {
        print('⚠️ Attempt $attempt timed out.');
        if (attempt == maxRetries) {
          time = 'Could not get time data: Request timed out';
          isDaytime = false;
        }
      } catch (e) {
        print('💥 Caught error: $e');
        if (attempt == maxRetries) {
          time = 'Could not get time data: $e';
          isDaytime = false;
        }
      }

      // Wait 2 seconds before retrying
      await Future.delayed(const Duration(seconds: 2));
    }
  }
}
