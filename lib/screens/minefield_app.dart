import 'package:flutter/material.dart';
import 'package:minefield/components/field_widget.dart';
import 'package:minefield/models/explosion_exception.dart';
import 'package:minefield/models/field.dart';
import '../components/result_widget.dart';

class MineFieldApp extends StatelessWidget {
  const MineFieldApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Field neighbor1 = Field(line: 0, column: 0);
    neighbor1.undermine();
    Field neighbor2 = Field(line: 0, column: 0);
    neighbor2.undermine();
    Field field = Field(line: 0, column: 0);
    field.addNeighbor(neighbor1);
    field.addNeighbor(neighbor2);

    try {
     // field.undermine();
      field.changeMarking();
    } on ExplosionException {}

    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(win: true, onRestart: _restart),
        body: Container(
          child: FieldWidget(field: field, onOpen: _open, onChangeMarking: _changeMarking),
        ),
      ),
    );
  }

  void _restart() {
    print("reiniciar");
  }

  void _open(Field field) {
    print("abrir");
  }

  void _changeMarking(Field field) {
    print("Alternar marcação");
  }
}
