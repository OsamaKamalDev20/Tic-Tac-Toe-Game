import 'dart:async';
import 'package:flutter/material.dart';
import 'package:game/constants/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int attempts = 0;
  int OScore = 0;
  int XScore = 0;
  int filledBoxes = 0;
  bool OTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  List<int> matchIndexes = [];
  String resultDeclaration = '';
  bool winnerFound = false;
  static const maxSeconds = 20;
  int seconds = maxSeconds;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() => seconds = maxSeconds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Player 0",
                            style: TextStyle(
                              fontSize: 34,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            OScore.toString(),
                            style: TextStyle(
                              fontSize: 34,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Player X",
                            style: TextStyle(
                              fontSize: 34,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            XScore.toString(),
                            style: TextStyle(
                              fontSize: 34,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                flex: 3,
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 2,
                              color: GameColors.player,
                            ),
                            color: matchIndexes.contains(index)
                                ? GameColors.matchedColor
                                : GameColors.backgroundColor,
                          ),
                          child: Center(
                            child: Text(
                              displayXO[index],
                              style: TextStyle(
                                fontSize: 74,
                                color: matchIndexes.contains(index)
                                    ? Colors.white
                                    : GameColors.player,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 5),
              Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        resultDeclaration,
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildTimer()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;
    if (isRunning) {
      setState(
        () {
          if (OTurn && displayXO[index] == "") {
            displayXO[index] = 'O';
            filledBoxes++;
          } else if (!OTurn && displayXO[index] == "") {
            displayXO[index] = 'X';
            filledBoxes++;
          }
          OTurn = !OTurn;
          _checkWinner();
        },
      );
    }
  }

  void _checkWinner() {
    // check 1st row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != "") {
      setState(
        () {
          resultDeclaration = "Player " + displayXO[0] + " Wins!";
          matchIndexes.addAll([0, 1, 2]);
          stopTimer();
          _updateScore(displayXO[0]);
        },
      );
    }
    // check 2nd row
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != "") {
      setState(
        () {
          resultDeclaration = "Player " + displayXO[3] + " Wins!";
          matchIndexes.addAll([3, 4, 5]);
          stopTimer();
          _updateScore(displayXO[3]);
        },
      );
    }
    // check 3rd row
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != "") {
      setState(
        () {
          resultDeclaration = "Player " + displayXO[6] + " Wins!";
          matchIndexes.addAll([6, 7, 8]);
          stopTimer();
          _updateScore(displayXO[6]);
        },
      );
    }
    // check 1st column
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != "") {
      setState(
        () {
          resultDeclaration = "Player " + displayXO[0] + " Wins!";
          matchIndexes.addAll([0, 3, 6]);
          stopTimer();
          _updateScore(displayXO[0]);
        },
      );
    }
    // check 2nd column
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != "") {
      setState(
        () {
          resultDeclaration = "Player " + displayXO[1] + " Wins!";
          matchIndexes.addAll([1, 4, 7]);
          stopTimer();
          _updateScore(displayXO[1]);
        },
      );
    }
    // check 3rd column
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != "") {
      setState(
        () {
          resultDeclaration = "Player " + displayXO[2] + " Wins!";
          matchIndexes.addAll([2, 5, 8]);
          stopTimer();
          _updateScore(displayXO[2]);
        },
      );
    }

    // check diagonal
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != "") {
      setState(
        () {
          resultDeclaration = "Player " + displayXO[0] + " Wins!";
          matchIndexes.addAll([0, 4, 8]);
          stopTimer();
          _updateScore(displayXO[0]);
        },
      );
    }
    // check diagonal
    if (displayXO[6] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[6] != "") {
      setState(
        () {
          resultDeclaration = "Player " + displayXO[6] + " Wins!";
          matchIndexes.addAll([6, 4, 2]);
          stopTimer();
          _updateScore(displayXO[6]);
        },
      );
    }
    if (!winnerFound && filledBoxes == 9) {
      setState(() {
        resultDeclaration = "It's a Draw!";
      });
    }
  }

  void _updateScore(String winner) {
    if (winner == 'O') {
      OScore++;
    } else if (winner == 'X') {
      XScore++;
    }
    winnerFound = true;
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
      resultDeclaration = '';
    });
    filledBoxes = 0;
  }

  Widget _buildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;

    return isRunning
        ? SizedBox(
            height: 100,
            width: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / maxSeconds,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: GameColors.buttonColor,
                ),
                Center(
                  child: Text(
                    "$seconds",
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: GameColors.buttonColor,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            onPressed: () {
              startTimer();
              _clearBoard();
              attempts++;
            },
            child: Text(
              attempts == 0 ? "Start Game" : "Play Again!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          );
  }
}
