import 'package:flutter/material.dart';
import '../data/sample_data.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int current = 0;
  int score = 0;
  int? selected;

  void answer(int index) {
    if (selected != null) return;
    setState(() {
      selected = index;
      if (index == quizQuestions[current].correctIndex) score++;
    });
  }

  void next() {
    if (current == quizQuestions.length - 1) {
      showDialog(context: context, builder: (_) => AlertDialog(
        title: const Text('Quiz complete'),
        content: Text('You scored $score/${quizQuestions.length}.'),
        actions: [TextButton(onPressed: () { Navigator.pop(context); Navigator.pop(context); }, child: const Text('Done'))],
      ));
      return;
    }
    setState(() { current++; selected = null; });
  }

  @override
  Widget build(BuildContext context) {
    final q = quizQuestions[current];
    return Scaffold(
      appBar: AppBar(title: const Text('History Quiz')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Question ${current + 1} of ${quizQuestions.length}', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 18),
          Text(q.question, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 22),
          ...List.generate(q.options.length, (index) {
            final correct = selected != null && index == q.correctIndex;
            final chosenWrong = selected == index && !correct;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.centerLeft,
                ),
                onPressed: () => answer(index),
                child: Row(children: [
                  Expanded(child: Text(q.options[index])),
                  if (correct) const Icon(Icons.check_circle),
                  if (chosenWrong) const Icon(Icons.cancel),
                ]),
              ),
            );
          }),
          if (selected != null) ...[
            const SizedBox(height: 10),
            Card(child: Padding(padding: const EdgeInsets.all(14), child: Text(q.explanation))),
            const SizedBox(height: 12),
            FilledButton(onPressed: next, child: Text(current == quizQuestions.length - 1 ? 'Finish' : 'Next')),
          ],
        ],
      ),
    );
  }
}
