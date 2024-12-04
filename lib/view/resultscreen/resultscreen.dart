import 'package:flutter/material.dart';
import 'package:quizzapp3/view/dummydb.dart';
import 'package:quizzapp3/view/splash_screen/splash_screen.dart';

class Resultscreen extends StatefulWidget {
  final int correctAnswers; 
  final String selectedCategory; 

  const Resultscreen({super.key, required this.correctAnswers, required this.selectedCategory});

  @override
  State<Resultscreen> createState() => _ResultscreenState();
}

class _ResultscreenState extends State<Resultscreen> {
  int starcount = 0;

  @override
  void initState() {
    calculatePercentage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int totalQuestions = Dummydb.questions[widget.selectedCategory]!.length;
    num percentage = (widget.correctAnswers / totalQuestions) * 100;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Star Rating Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(3, (index) => Padding(
                    padding: EdgeInsets.only(right: 15, left: 15, bottom: index == 1 ? 30 : 0),
                    child: Icon(
                      Icons.star,
                      color: starcount > index ? Colors.amberAccent : Colors.grey,
                      size: index == 1 ? 70 : 40,
                    ),
                  ),
                ),
            ),
            // Congratulatory Message
            Text(
              "Congratulations!",
              style: TextStyle(color: Colors.amberAccent, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Text(
              "Your Score",
              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Text(
              "${widget.correctAnswers}/$totalQuestions",
              style: TextStyle(color: Colors.amberAccent, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 25),
            Text(
              "You scored $percentage%.",
              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 25),
            // Retry Button
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashScreen()));
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.replay_circle_filled_outlined),
                    Center(child: Text("Retry", style: TextStyle(color: Colors.black))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calculatePercentage() {
    num percentage = (widget.correctAnswers / Dummydb.questions[widget.selectedCategory]!.length) * 100;

// Calculate star count based on percentage
    if (percentage >= 90) {
      starcount = 3;
    } else if (percentage >= 50) {
      starcount = 2;
    } else if (percentage >= 30) {
      starcount = 1;
    } else {
      starcount = 0;
    }

    setState(() {});
  }
}