import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/timeline_screen.dart';
import 'screens/premium_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const InnovatorsApp());
}

class InnovatorsApp extends StatefulWidget {
  const InnovatorsApp({super.key});

  @override
  State<InnovatorsApp> createState() => _InnovatorsAppState();
}

class _InnovatorsAppState extends State<InnovatorsApp> {
  int navIndex = 0;
  bool premium = false;

  void openProfile(String id) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => ProfileScreen(innovatorId: id, premium: premium),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(premium: premium, onOpenProfile: openProfile),
      ExploreScreen(onOpenProfile: openProfile),
      const TimelineScreen(),
      const QuizScreen(),
      const PremiumScreen(),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Innovators Through History',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF8F8FC),
        cardTheme: const CardThemeData(
          elevation: 0,
          margin: EdgeInsets.only(bottom: 10),
        ),
      ),
      home: Scaffold(
        body: pages[navIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: navIndex,
          onDestinationSelected: (i) => setState(() => navIndex = i),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.search), label: 'Explore'),
            NavigationDestination(icon: Icon(Icons.timeline), label: 'Timeline'),
            NavigationDestination(icon: Icon(Icons.quiz_outlined), label: 'Quiz'),
            NavigationDestination(icon: Icon(Icons.workspace_premium_outlined), label: 'Premium'),
          ],
        ),
      ),
    );
  }
}
