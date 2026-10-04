import 'package:flutter/material.dart';

class AdPlaceholder extends StatelessWidget {
  final bool premium;

  const AdPlaceholder({super.key, this.premium = false});

  @override
  Widget build(BuildContext context) {
    if (premium) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: const Row(
        children: [
          Icon(Icons.campaign_outlined),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Advertisement',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text('AD', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
