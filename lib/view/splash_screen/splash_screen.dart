import 'package:flutter/material.dart';
import 'package:quizzapp3/view/homescreen/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> items = [
      {'color': Colors.blue, 'icon': Icons.sports, 'text': 'Sports'},
      {'color': Colors.green, 'icon': Icons.music_note, 'text': 'Music'},
      {'color': Colors.red, 'icon': Icons.movie, 'text': 'Movies'},
      {'color': Colors.orange, 'icon': Icons.art_track, 'text': 'Art'},
      {'color': Colors.purple, 'icon': Icons.book, 'text': 'Books'},
      {'color': Colors.yellow, 'icon': Icons.gamepad, 'text': 'Games'},
      {'color': Colors.blue, 'icon': Icons.directions_run, 'text': 'Running'},
      {'color': Colors.green, 'icon': Icons.headphones, 'text': 'Podcasts'},
      {'color': Colors.red, 'icon': Icons.camera_alt, 'text': 'Photography'},
      {'color': Colors.orange, 'icon': Icons.fastfood, 'text': 'Food'},
      {'color': Colors.purple, 'icon': Icons.palette, 'text': 'Painting'},
      {'color': Colors.yellow, 'icon': Icons.travel_explore, 'text': 'Travel'},
    ];

    return Scaffold(
      appBar: AppBar(title: Text("QUIZ")),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
           
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(selectedCategory: items[index]['text']),
                ),
              );
            },
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: items[index]['color'],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      items[index]['icon'],
                      color: Colors.white,
                      size: 50,
                    ),
                    SizedBox(height: 10),
                    Text(
                      items[index]['text'],
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}