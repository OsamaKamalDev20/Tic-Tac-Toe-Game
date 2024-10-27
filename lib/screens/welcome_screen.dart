import 'package:flutter/material.dart';
import 'package:game/constants/colors.dart';
import 'package:game/screens/games.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/background_image.jpg",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: GameColors.buttonColor,
                padding: EdgeInsets.all(10),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameScreen(),
                  ),
                );
              },
              child: Text(
                "Let's Start",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
