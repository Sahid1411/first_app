import 'package:flutter/material.dart';
import 'result_page.dart'; // 👈 Make sure this file exists

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<String>> questionAns = [
    ['What is the capital of India?', 'New Delhi'],
    ['What is the national animal of India?', 'Tiger'],
    ['Who is the first Prime Minister of India?', 'Pandit Jawaharlal Nehru'],
    ['Which planet is known as the Red Planet?', 'Mars'],
    ['Who wrote the national anthem of India?', 'Rabindranath Tagore'],
    ['What is the largest ocean in the world?', 'Pacific Ocean'],
    ['Which element has the chemical symbol O?', 'Oxygen'],
    ['How many continents are there on Earth?', '7'],
    ['Which festival is known as the festival of lights?', 'Diwali'],
    ['What is the square root of 64?', '8'],
  ];

  List<List<String>> options = [
    ['New Delhi', 'Mumbai', 'Bangalore', 'Gujarat'],
    ['Giraffe', 'Elephant', 'Lion', 'Tiger'],
    ['Narendra Modi', 'Prativa Patel', 'Pandit Jawaharlal Nehru', 'Lala Lajpat Rai'],
    ['Mars', 'Jupiter', 'Saturn', 'Earth'],
    ['Bankim Chandra Chatterjee', 'Rabindranath Tagore', 'Mahatma Gandhi', 'Subhash Chandra Bose'],
    ['Atlantic Ocean', 'Indian Ocean', 'Pacific Ocean', 'Arctic Ocean'],
    ['Gold', 'Oxygen', 'Hydrogen', 'Iron'],
    ['5', '6', '7', '8'],
    ['Holi', 'Diwali', 'Eid', 'Christmas'],
    ['6', '7', '8', '9'],
  ];

  int currentQuestion = 0;
  List<int> selectedIndexes = List.filled(10, -1);
  List<bool> answered = List.filled(10, false);

  void handleAnswerTap(int optionIndex) {
    if (answered[currentQuestion]) return;

    setState(() {
      selectedIndexes[currentQuestion] = optionIndex;
      answered[currentQuestion] = true;
    });
  }

  Color getOptionColor(int index) {
    if (!answered[currentQuestion]) return Colors.white;

    String correctAnswer = questionAns[currentQuestion][1];
    String optionText = options[currentQuestion][index];
    int selected = selectedIndexes[currentQuestion];

    if (optionText == correctAnswer) {
      return Colors.green;
    } else if (selected == index) {
      return Colors.red;
    } else {
      return Colors.white;
    }
  }

  void goToNext() {
    if (currentQuestion < questionAns.length - 1) {
      setState(() {
        currentQuestion++;
      });
    }
  }

  void goToBack() {
    if (currentQuestion > 0) {
      setState(() {
        currentQuestion--;
      });
    }
  }

  void submitQuiz() {
    int score = 0;

    for (int i = 0; i < questionAns.length; i++) {
      String correct = questionAns[i][1];
      int selectedIndex = selectedIndexes[i];
      if (selectedIndex != -1 && options[i][selectedIndex] == correct) {
        score++;
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ResultPage(score: score, total: questionAns.length),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLastQuestion = currentQuestion == questionAns.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Question card
            SizedBox(
              height: 160,
              child: Card(
                elevation: 2,
                surfaceTintColor: Colors.blue,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      questionAns[currentQuestion][0],
                      style: const TextStyle(fontSize: 18.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),

            // Options
            ...List.generate(options[currentQuestion].length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  onPressed: () => handleAnswerTap(index),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: getOptionColor(index),
                    foregroundColor: Colors.black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(options[currentQuestion][index])],
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),

            // Navigation or Submit
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: currentQuestion > 0 ? goToBack : null,
                  child: const Text('Back'),
                ),
                isLastQuestion
                    ? ElevatedButton(
                        onPressed: submitQuiz,
                        child: const Text('Submit'),
                      )
                    : ElevatedButton(
                        onPressed: goToNext,
                        child: const Text('Next'),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
