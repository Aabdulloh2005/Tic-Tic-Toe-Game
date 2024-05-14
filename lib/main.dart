import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/design.dart';

void main(List<String> args) {
  runApp(const TicTacToe());
}

class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DesignPage(),
    );
  }
}
