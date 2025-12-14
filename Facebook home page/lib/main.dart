import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Facebook Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Using Future.delayed as requested
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const FacebookHomePage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          Center(
            child: Image.asset(
              'assets/images/facebook_logo.png',
              width: 150,
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: [
                Text("from", style: TextStyle(color: Colors.grey)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.all_inclusive, color: Color(0xFF1877F2)),
                    SizedBox(width: 5),
                    Text(
                      "Meta",
                      style: TextStyle(
                        color: Color(0xFF1877F2),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FacebookHomePage extends StatelessWidget {
  const FacebookHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'facebook',
            style: TextStyle(
              color: Color(0xFF1877F2),
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Color(0xFF1877F2),
            labelColor: Color(0xFF1877F2),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.ondemand_video)),
              Tab(icon: Icon(Icons.people)),
              Tab(icon: Icon(Icons.store)),
              Tab(icon: Icon(Icons.notifications)),
              Tab(icon: Icon(Icons.menu)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              children: const [
                FeedPost(),
                FeedPost(),
                FeedPost(),
              ],
            ),
            const Center(child: Text("Reels")),
            const Center(child: Text("Friends")),
            const Center(child: Text("Marketplace")),
            const Center(child: Text("Notifications")),
            const Center(child: Text("Menu")),
          ],
        ),
      ),
    );
  }
}

class FeedPost extends StatelessWidget {
  const FeedPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '2 hrs • 🌎',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.more_horiz),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              'This is a simple Facebook post content example.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 10),
          Image.asset(
            'assets/images/feed_image.jpg',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(Icons.thumb_up, size: 16, color: Colors.blue),
                SizedBox(width: 5),
                Text("120"),
                Spacer(),
                Text("10 comments • 5 shares"),
              ],
            ),
          ),
          const Divider(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.thumb_up_outlined, color: Colors.grey),
                label: const Text('Like', style: TextStyle(color: Colors.grey)),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.chat_bubble_outline, color: Colors.grey),
                label:
                    const Text('Comment', style: TextStyle(color: Colors.grey)),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share_outlined, color: Colors.grey),
                label:
                    const Text('Share', style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
