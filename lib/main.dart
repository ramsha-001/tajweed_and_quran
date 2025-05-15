import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Ensure this file exists
import 'screens/surah_screen.dart';
import 'screens/tajweed_rules_screen.dart';
import 'screens/quiz_screen.dart' as quiz_screen;
import 'screens/profile_screen.dart'; // Import ProfileScreen
import 'screens/auth_screen.dart'; // Import AuthScreen for authentication

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tajweed App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Amiri', // Use Amiri font globally for consistency
      ),
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const HomeScreen(),
        '/surah': (context) => const SurahScreen(),
        '/tajweedRules': (context) =>  TajweedRulesScreen(),
        '/quiz': (context) => const quiz_screen.QuizScreen(),
        '/profile': (context) => const ProfileScreen(), // Route for ProfileScreen
        '/auth': (context) => const AuthScreen(), // Route for AuthScreen
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal.shade100,
              Colors.teal.shade400,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/Images/getstarted.png',
                width: 320,
                height: 270,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 50),
              const Text(
                'Quran with Tajweed',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Learn Quran and Recite everyday',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 14),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.teal.shade900,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.teal.shade900),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tajweed App',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.2,
            fontFamily: 'Roboto',
          ),
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(27.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/Images/Learn-Quran-with-Tajweed.png',
              width: double.infinity,
              height: 370,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 21.0,
                mainAxisSpacing: 21.0,
                children: [
                  _buildNavigationTile(
                    context,
                    title: 'Surahs',
                    icon: Icons.auto_stories,
                    onTap: () => Navigator.of(context).pushNamed('/surah'),
                  ),
                  _buildNavigationTile(
                    context,
                    title: 'Tajweed Rules',
                    icon: Icons.headset,
                    onTap: () => Navigator.of(context).pushNamed('/tajweedRules'),
                  ),
                  _buildNavigationTile(
                    context,
                    title: 'Take Quiz',
                    icon: Icons.emoji_objects,
                    onTap: () => Navigator.of(context).pushNamed('/quiz'),
                  ),
                  _buildNavigationTile(
                    context,
                    title: 'Profile',
                    icon: Icons.person,
                    onTap: () {
                      // Check if user is authenticated
                      final user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        Navigator.of(context).pushNamed('/profile');
                      } else {
                        Navigator.of(context).pushNamed('/auth');
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationTile(BuildContext context,
      {required String title, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal.withOpacity(0.1),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.teal),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}