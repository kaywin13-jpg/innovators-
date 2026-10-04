import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../models/innovator.dart';
import '../widgets/ad_placeholder.dart';
import 'premium_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String innovatorId;
  final bool premium;

  const ProfileScreen({super.key, required this.innovatorId, required this.premium});

  @override
  Widget build(BuildContext context) {
    final Innovator? i = innovators.where((x) => x.id == innovatorId).cast<Innovator?>().firstOrNull;
    if (i == null) return const Scaffold(body: Center(child: Text('Innovator not found')));

    return Scaffold(
      appBar: AppBar(title: Text(i.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CircleAvatar(radius: 48, child: Text(i.name.substring(0, 1), style: const TextStyle(fontSize: 34))),
          const SizedBox(height: 14),
          Text(i.name, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          Text('${i.field} • ${i.country}', textAlign: TextAlign.center),
          const SizedBox(height: 14),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            children: i.tags.map((t) => Chip(label: Text(t))).toList(),
          ),
          AdPlaceholder(premium: premium),
          const SizedBox(height: 8),
          Text(i.summary, style: const TextStyle(fontSize: 17, height: 1.4)),
          const SizedBox(height: 22),
          _Section(title: 'Biography', child: Text(i.biography, style: const TextStyle(height: 1.5))),
          _Section(
            title: 'Major achievements',
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: i.achievements.map((a) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(children: [const Icon(Icons.check_circle_outline, size: 19), const SizedBox(width: 8), Expanded(child: Text(a))]),
            )).toList()),
          ),
          _Section(
            title: 'Premium learning',
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.workspace_premium),
                title: const Text('Unlock extended history'),
                subtitle: const Text('Detailed timelines, learning packs and an ad-free experience.'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PremiumScreen())),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;
  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 22),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
      const SizedBox(height: 9),
      child,
    ]),
  );
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
