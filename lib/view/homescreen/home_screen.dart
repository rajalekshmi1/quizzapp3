import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart'; 
import 'package:quizzapp3/view/dummydb.dart';
import 'package:quizzapp3/view/resultscreen/resultscreen.dart';

class HomeScreen extends StatefulWidget {
  final String selectedCategory; 

  const HomeScreen({super.key, required this.selectedCategory}); 

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentindex = 0;
  int? selectedoption;
  int correctAnswers = 0;
  bool isAnswered = false;

  // Countdown timer controller
  final CountDownController controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    // Get the questions for the selected category
    List<Map<String, dynamic>> questions = Dummydb.questions[widget.selectedCategory]!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Question ${currentindex + 1}/${questions.length}",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircularCountDownTimer(
              duration: 30,
              initialDuration: 0,
              controller: controller,
              width: 100,
              height: 100,
              ringColor: Colors.grey[300]!,
              fillColor: Colors.blueAccent,
              backgroundColor: Colors.white,
              strokeWidth: 10.0,
              strokeCap: StrokeCap.round,
              textStyle: TextStyle(
                fontSize: 22.0,
                color: Colors.black,
              ),
              isReverse: true,
              isTimerTextShown: true,
              autoStart: true,
              onStart: () {},
              onComplete: () {
                moveToNextQuestion();
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 155, 186, 211),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Center(
                    child: Text(
                      questions[currentindex]["question"],
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: List.generate(
                4,
                (optionindex) => Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: InkWell(
                    onTap: !isAnswered
                        ? () {
                            setState(() {
                              selectedoption = optionindex;
                              isAnswered = true;
                              if (questions[currentindex]["answerIndex"] == optionindex) {
                                correctAnswers++;
                              }
                            });
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: getColor(optionindex),
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            questions[currentindex]["options"][optionindex],
                            style: TextStyle(color: Colors.black),
                          ),
                          Icon(
                            Icons.circle_outlined,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Next Button
            if (isAnswered)
              InkWell(
                onTap: () {
                  setState(() {
                    isAnswered = false;
                    if (currentindex < questions.length - 1) {
                      currentindex++;
                      selectedoption = null;
                      controller.restart();
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Resultscreen(correctAnswers: correctAnswers, selectedCategory: widget.selectedCategory),
                        ),
                      );
                    }
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color getColor(int clickedindex) {
    if (selectedoption != null) {
      if (Dummydb.questions[widget.selectedCategory]![currentindex]["answerIndex"] == clickedindex) {
        return const Color.fromARGB(255, 144, 187, 222);
      } else if (selectedoption == clickedindex) {
        return Colors.red;
      }
    }
    return Colors.white;
  }

  void moveToNextQuestion() {
    if (currentindex < Dummydb.questions[widget.selectedCategory]!.length - 1) {
      setState(() {
        currentindex++;
        selectedoption = null;
        isAnswered = false;
        controller.restart();
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Resultscreen(correctAnswers: correctAnswers, selectedCategory: widget.selectedCategory),
        ),
      );
    }
  }
}