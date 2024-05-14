import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/computer_page.dart';
import 'package:tic_tac_toe/screens/design.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xff008287)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ComputerPlaying();
                  }),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                child: Text(
                  "PLay with computer",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return DesignPage();
                  }),
                );
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xff008287)),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                child: Text(
                  "       Multiplayer        ",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
