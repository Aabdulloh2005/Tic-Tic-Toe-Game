import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: ComputerPlaying(),
    ),
  );
}

class ComputerPlaying extends StatefulWidget {
  const ComputerPlaying({Key? key}) : super(key: key);

  @override
  _DesignPageState createState() => _DesignPageState();
}

class _DesignPageState extends State<ComputerPlaying> {
  late List<String> board;
  late String currentPlayer;
  late int moveCount;
  int xWins = 0;
  int oWins = 0;

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      moveCount = 0;
    });

    if (currentPlayer == 'O') {
      computerMove();
    }
  }

  void makeMove(int index) {
    setState(() {
      if (board[index].isEmpty) {
        board[index] = currentPlayer;
        moveCount++;

        String? winner = checkWinner();
        if (winner != null) {
          showResultDialog(winner);
          updateWinCount(winner);
        } else if (moveCount == 9) {
          showResultDialog('draw');
        }

        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';

        if (currentPlayer == 'O' && winner == null && moveCount < 9) {
          computerMove();
        }
      }
    });
  }

  void computerMove() {
    const Duration delayDuration = Duration(milliseconds: 1500);

    Future.delayed(delayDuration, () {
      List<int> emptyIndices = [];
      for (int i = 0; i < board.length; i++) {
        if (board[i].isEmpty) {
          emptyIndices.add(i);
        }
      }

      if (emptyIndices.isNotEmpty) {
        int randomIndex = Random().nextInt(emptyIndices.length);
        makeMove(emptyIndices[randomIndex]);
      }
    });
  }

  String? checkWinner() {
    List<List<int>> winConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var condition in winConditions) {
      if (board[condition[0]] != '' &&
          board[condition[0]] == board[condition[1]] &&
          board[condition[1]] == board[condition[2]]) {
        return board[condition[0]];
      }
    }

    return null;
  }

  void updateWinCount(String winner) {
    if (winner == 'X') {
      setState(() {
        xWins++;
      });
    } else if (winner == 'O') {
      setState(() {
        oWins++;
      });
    }
  }

  void showResultDialog(String result) {
    String message;
    if (result == 'draw') {
      message = 'It\'s a draw!';
    } else {
      message = 'Player $result wins!';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Game Over'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetGame();
            },
            child: Text('Play Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5A9B9B),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Column(
              children: [
                Text(
                  "Player: X vs AI: O",
                  style: TextStyle(
                    color: Color(0xffD9B991),
                    fontSize: 28,
                    height: 1,
                  ),
                ),
                Divider(
                  thickness: 2,
                  color: Color(0xffD9B991),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'X Wins: $xWins',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  'O Wins: $oWins',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Container(
              width: 312,
              height: 312,
              color: const Color(0xffD4B98E),
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: List.generate(9, (index) {
                  return GetContainer(
                    player: board[index],
                    onTap: () {
                      if (currentPlayer == 'X' && checkWinner() == null) {
                        makeMove(index);
                      }
                    },
                  );
                }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GetButton(
                  name: "Reset Game",
                  onPressed: resetGame,
                ),
                GetButton(
                  name: "New Game",
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ComputerPlaying()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GetContainer extends StatelessWidget {
  final String player;
  final VoidCallback onTap;

  const GetContainer({required this.player, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.amber,
      highlightColor: Colors.amber,
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          color: Color(0xff5A9B9B),
        ),
        child: Center(
          child: Text(
            player,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class GetButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;

  const GetButton({required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff008287),
        padding: const EdgeInsets.all(16.0),
      ),
      child: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
