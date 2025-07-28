import 'package:flutter/material.dart';
import 'home_page.dart'; // 👈 Import your quiz page here

class ResultPage extends StatelessWidget {
  final int score;
  final int total;

  const ResultPage({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Result'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Score:', style: TextStyle(fontSize: 28)),
            Text(
              '$score / $total',
              style: const TextStyle(fontSize: 32, color: Colors.green),
            ),
            const SizedBox(height: 40),

            // Back to current quiz (just go back)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back to Quiz'),
            ),

            // Restart the quiz
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false, // Remove all previous routes
                );
              },
              child: const Text('New Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
