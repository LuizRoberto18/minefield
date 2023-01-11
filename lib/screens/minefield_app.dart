import 'package:flutter/material.dart';
import 'package:minefield/components/board_widget.dart';
import 'package:minefield/models/explosion_exception.dart';
import 'package:minefield/models/field.dart';
import '../components/result_widget.dart';
import '../models/board.dart';

class MineFieldApp extends StatefulWidget {
  const MineFieldApp({Key? key}) : super(key: key);

  @override
  State<MineFieldApp> createState() => _MineFieldAppState();
}

class _MineFieldAppState extends State<MineFieldApp> {
  bool? _win;
  Board? _board;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: ResultWidget(win: _win, onRestart: _restart),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              return BoardWidget(
                board: _getBoard(
                  constraints.maxWidth,
                  constraints.maxHeight,
                ),
                onOpen: _open,
                onChangeMarking: _changeMarking,
              );
            },
          ),
        ),
      ),
    );
  }

  Board _getBoard(double width, double height) {
    if (_board == null) {
      int qtdeColuns = 15;
      double widthField = width / qtdeColuns;
      int qtdeLines = (height / widthField).floor();

      _board = Board(
        lines: qtdeLines,
        columns: qtdeColuns,
        amountOfBombs: 3,
      );
    }
    return _board!;
  }

  void _restart() {
    print("reiniciar");
    setState(() {
      _win = null;
      _board!.restart();
    });
  }

  void _open(Field field) {
    if (_win != null) {
      return;
    }
    setState(() {
      try {
        field.opening();
        if (_board!.resolved) {
          _win = true;
        }
      } on ExplosionException {
        _win = false;
        _board!.revealBombs();
      }
    });
  }

  void _changeMarking(Field field) {
    if (_win != null) {
      return;
    }
    setState(() {
      field.changeMarking();
      if (_board!.resolved) {
        _win = true;
      }
    });
  }
}
