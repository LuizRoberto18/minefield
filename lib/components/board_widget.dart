import 'package:flutter/material.dart';

import '../models/board.dart';
import '../models/field.dart';
import 'field_widget.dart';

class BoardWidget extends StatelessWidget {
  final Board board;
  final void Function(Field) onOpen;
  final void Function(Field) onChangeMarking;

  const BoardWidget({
    Key? key,
    required this.board,
    required this.onOpen,
    required this.onChangeMarking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: board.columns,
      children: board.fields.map((field) {
        return FieldWidget(field: field, onOpen: onOpen, onChangeMarking: onChangeMarking);
      }).toList(),
    );
  }
}
