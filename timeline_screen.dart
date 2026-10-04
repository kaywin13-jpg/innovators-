import 'package:flutter/material.dart';
import '../data/sample_data.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sorted = [...innovators]..sort((a, b) => (a.birthYear ?? 9999).compareTo(b.birthYear ?? 9999));
    return Scaffold(
      appBar: AppBar(title: const Text('Historical Timeline')),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: sorted.length,
        itemBuilder: (_, index) {
          final i = sorted[index];
          return IntrinsicHeight(
            child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              SizedBox(
                width: 76,
                child: Text(i.birthYear?.toString() ?? '?', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              ),
              Column(children: [
                const Icon(Icons.circle, size: 13),
                if (index != sorted.length - 1) Expanded(child: Container(width: 2)),
              ]),
              const SizedBox(width: 14),
              Expanded(child: Padding(
                padding: const EdgeInsets.only(bottom: 22),
                child: Card(
                  child: ListTile(
                    title: Text(i.name),
                    subtitle: Text('${i.field}\n${i.summary}'),
                    isThreeLine: true,
                  ),
                ),
              )),
            ]),
          );
        },
      ),
    );
  }
}
