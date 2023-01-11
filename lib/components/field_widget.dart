import 'package:flutter/material.dart';
import '../components/field_widget.dart';
import '../components/result_widget.dart';
import '../models/field.dart';

class FieldWidget extends StatelessWidget {
  final Field field;
  final void Function(Field) onOpen;
  final void Function(Field) onChangeMarking;

  const FieldWidget({
    Key? key,
    required this.field,
    required this.onOpen,
    required this.onChangeMarking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(field),
      onLongPress: () => onChangeMarking(field),
      child: _getImage(),
    );
  }

  Widget _getImage() {
    int qtdeMinas = field.numberOfMinesInTheNeighborhood;
    if (field.open && field.undermined && field.exploded) {
      return Image.asset("assets/images/bomba_0.jpeg");
    } else if (field.open && field.undermined) {
      return Image.asset("assets/images/bomba_1.jpeg");
    } else if (field.open) {
      return Image.asset("assets/images/aberto_$qtdeMinas.jpeg");
    } else if (field.marked) {
      return Image.asset("assets/images/bandeira.jpeg");
    } else {
      return Image.asset("assets/images/fechado.jpeg");
    }
  }
}
