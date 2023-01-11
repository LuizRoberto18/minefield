import 'dart:math';

import 'field.dart';

class Board {
  final int lines;
  final int columns;
  final int amountOfBombs;

  final List<Field> _fields = [];

  Board({
    required this.lines,
    required this.columns,
    required this.amountOfBombs,
  }) {
    _createField();
    _relateNeighbors();
    _raffleMines();
  }

  void restart() {
    for (var field in _fields) {
      field.restart();
    }
    _raffleMines();
  }

  void revealBombs() {
    for (var field in _fields) {
      field.revealBombs();
    }
  }

  void _createField() {
    for (int l = 0; l < lines; l++) {
      for (int c = 0; c < columns; c++) {
        _fields.add(Field(line: l, column: c));
      }
    }
  }

  void _relateNeighbors() {
    for (var field in _fields) {
      for (var neighbor in _fields) {
        field.addNeighbor(neighbor);
      }
    }
  }

  void _raffleMines() {
    int raffles = 0;
    if (amountOfBombs > lines * columns) {
      return;
    }
    while (raffles < amountOfBombs) {
      int i = Random().nextInt(_fields.length);
      if (!_fields[i].undermined) {
        raffles++;
        _fields[i].undermine();
      }
    }
  }

  List<Field> get fields {
    return _fields;
  }

  bool get resolved {
    return _fields.every((field) => field.resolved);
  }
}
