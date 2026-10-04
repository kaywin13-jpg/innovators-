import 'package:flutter/material.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      'Ad-free experience',
      'Extended biographies and timelines',
      'Premium quizzes and learning packs',
      'Downloadable educational materials',
      'Exclusive African innovation collections',
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Premium')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(Icons.workspace_premium, size: 64),
          const SizedBox(height: 12),
          Text('Go deeper into history', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text('Premium is designed for learners, teachers and curious readers.', textAlign: TextAlign.center),
          const SizedBox(height: 24),
          ...features.map((f) => ListTile(leading: const Icon(Icons.check_circle_outline), title: Text(f))),
          const SizedBox(height: 18),
          FilledButton(
            onPressed: () => showDialog(context: context, builder: (_) => AlertDialog(
              title: const Text('Payments not connected yet'),
              content: const Text('Connect Google Play/App Store billing before production. This starter project intentionally does not collect money.'),
              actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
            )),
            child: const Text('Continue to Premium'),
          ),
          const SizedBox(height: 12),
          const Text('Pricing can be configured for Nigeria and other markets when billing is connected.', textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
