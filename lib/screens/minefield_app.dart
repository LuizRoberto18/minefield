import 'package:flutter/material.dart';
import '../components/result_widget.dart';

class MineFieldApp extends StatelessWidget {
  const MineFieldApp({Key? key}) : super(key: key);

  _restart() {
    print("reiniciar");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(win: true, onRestart: _restart),
        body: Container(
          child: Text("Tabuleiro"),
        ),
      ),
    );
  }
}
