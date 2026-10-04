import 'package:flutter/material.dart';
import '../data/sample_data.dart';

class ExploreScreen extends StatefulWidget {
  final String? initialFilter;
  final ValueChanged<String> onOpenProfile;

  const ExploreScreen({super.key, this.initialFilter, required this.onOpenProfile});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final controller = TextEditingController();
  String filter = 'All';

  @override
  void initState() {
    super.initState();
    filter = widget.initialFilter ?? 'All';
  }

  @override
  Widget build(BuildContext context) {
    final q = controller.text.trim().toLowerCase();
    final items = innovators.where((i) {
      final matchesQuery = q.isEmpty || '${i.name} ${i.country} ${i.field} ${i.tags.join(' ')}'.toLowerCase().contains(q);
      final matchesFilter = filter == 'All' || i.region == filter || i.field == filter || i.tags.contains(filter.toLowerCase());
      return matchesQuery && matchesFilter;
    }).toList();

    final filters = ['All', 'Africa', 'Science', 'Technology', 'Engineering', 'Computing', 'Space', 'Women'];

    return Scaffold(
      appBar: AppBar(title: const Text('Explore Innovators')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: controller,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search name, country or field...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: controller.text.isEmpty ? null : IconButton(
                  onPressed: () { controller.clear(); setState(() {}); },
                  icon: const Icon(Icons.clear),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              children: filters.map((f) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(f),
                  selected: filter == f,
                  onSelected: (_) => setState(() => filter = f),
                ),
              )).toList(),
            ),
          ),
          Expanded(
            child: items.isEmpty
              ? const Center(child: Text('No innovators found.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    final i = items[index];
                    return Card(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: CircleAvatar(radius: 25, child: Text(i.name.substring(0, 1))),
                        title: Text(i.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${i.field}\n${i.country} • ${i.years}'),
                        isThreeLine: true,
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => widget.onOpenProfile(i.id),
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}
