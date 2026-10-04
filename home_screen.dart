import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../widgets/ad_placeholder.dart';
import 'explore_screen.dart';
import 'quiz_screen.dart';
import 'timeline_screen.dart';
import 'premium_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  final bool premium;
  final ValueChanged<String> onOpenProfile;

  const HomeScreen({
    super.key,
    required this.premium,
    required this.onOpenProfile,
  });

  @override
  Widget build(BuildContext context) {
    final featured = innovators.take(4).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Innovators Through History'),
        actions: [
          IconButton(
            tooltip: 'Premium',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PremiumScreen())),
            icon: const Icon(Icons.workspace_premium_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _HeroCard(
            onExplore: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ExploreScreen(onOpenProfile: onOpenProfile))),
            onQuiz: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizScreen())),
          ),
          AdPlaceholder(premium: premium),
          const SizedBox(height: 8),
          const Text('Explore by topic', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ['Science', 'Technology', 'Engineering', 'Medicine', 'Space', 'Africa'].map((x) {
              return ActionChip(label: Text(x), onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ExploreScreen(
                  initialFilter: x == 'Africa' ? 'Africa' : x,
                  onOpenProfile: onOpenProfile,
                )));
              });
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text('Featured innovators', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...featured.map((i) => Card(
            child: ListTile(
              leading: CircleAvatar(child: Text(i.name.substring(0, 1))),
              title: Text(i.name),
              subtitle: Text('${i.field} • ${i.country}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => onOpenProfile(i.id),
            ),
          )),
          const SizedBox(height: 18),
          Card(
            child: ListTile(
              leading: const Icon(Icons.public),
              title: const Text('African Innovators'),
              subtitle: const Text('Discover innovators, scientists and inventors from Africa and the African diaspora.'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ExploreScreen(
                initialFilter: 'Africa',
                onOpenProfile: onOpenProfile,
              ))),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.timeline),
              title: const Text('Historical Timeline'),
              subtitle: const Text('Explore important people and milestones through time.'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TimelineScreen())),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  final VoidCallback onExplore;
  final VoidCallback onQuiz;

  const _HeroCard({required this.onExplore, required this.onQuiz});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.auto_awesome, size: 36),
            const SizedBox(height: 14),
            Text('Discover the people who changed our world.',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text('Explore inventions, discoveries, ideas and the stories behind them — from every continent.'),
            const SizedBox(height: 18),
            Wrap(
              spacing: 10,
              children: [
                FilledButton(onPressed: onExplore, child: const Text('Explore innovators')),
                OutlinedButton(onPressed: onQuiz, child: const Text('Take a quiz')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
