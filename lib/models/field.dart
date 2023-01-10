import 'package:flutter/foundation.dart';
import 'explosion_exception.dart';

class Field {
  final int line;
  final int column;
  final List<Field> neighbors = [];

  bool _open = false;
  bool _marked = false;
  bool _undermined = false;
  bool _exploded = false;

  Field({
    required this.line,
    required this.column,
  });

  void addNeighbor(Field neighbor) {
    final deltaLine = (line - neighbor.line).abs();
    final deltaColumn = (line - neighbor.column).abs();

    if (deltaLine == 0 && deltaColumn == 0) {
      return;
    }

    if (deltaLine <= 1 && deltaColumn <= 1) {
      neighbors.add(neighbor);
    }
  }

  void opening() {
    if (_open) {
      return;
    }
    _open = true;
    if (_undermined) {
      _exploded = true;
      throw ExplosionException();
    }
    if (safeNeighborhood) {
      neighbors.forEach((neighbor) => neighbor._open);
    }
  }

  void revealBombs() {
    if (_undermined) {
      _open = true;
    }
  }

  void undermine() {
    _undermined = true;
  }

  void changeMarking() {
    _undermined = !_undermined;
  }

  void restart() {
    _open = false;
    _marked = false;
    _undermined = false;
    _exploded = false;
  }

  bool get undermined {
    return _undermined;
  }

  bool get exploded {
    return _exploded;
  }

  bool get open {
    return _open;
  }

  bool get marked {
    return _marked;
  }

  bool get resolved {
    bool underminedAndMarked = marked && undermined;
    bool safeAndOpen = !undermined && open;
    return underminedAndMarked || safeAndOpen;
  }

  bool get safeNeighborhood {
    return neighbors.every((neighbor) => !neighbor._undermined);
  }

  int get numberOfMinesInTheNeighborhood {
    return neighbors.where((neighbor) => neighbor.undermined).length;
  }
}
