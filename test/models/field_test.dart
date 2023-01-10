import 'package:flutter_test/flutter_test.dart';
import 'package:minefield/models/field.dart';

main() {
  group('Campo', () {
    test('Abrir campo COM explosão', () {
      Field c = Field(line: 0, column: 0);
      c.undermine();

      expect(c.opening, throwsException);
    });
    test('Abrir campo SEM explosão', () {
      Field c = Field(line: 0, column: 0);
      c.opening();

      expect(c.open, isTrue);
    });
    test('Adicionar NÂO vizinho', () {
      Field c1 = Field(line: 0, column: 0);
      Field c2 = Field(line: 1, column: 3);
      c1.addNeighbor(c2);

      expect(c1.neighbors.isEmpty, true);
    });
    test('Adicionar vizinho', () {
      Field c1 = Field(line: 3, column: 0);
      Field c2 = Field(line: 3, column: 4);
      Field c3 = Field(line: 2, column: 2);
      Field c4 = Field(line: 4, column: 4);
      c1.addNeighbor(c2);
      c1.addNeighbor(c3);
      c1.addNeighbor(c4);

      expect(c1.neighbors.length, 3);
    });
    test('Minas na vizinhança', () {
      Field c1 = Field(line: 3, column: 0);

      Field c2 = Field(line: 3, column: 4);
      c2.undermine();
      Field c3 = Field(line: 2, column: 2);
      Field c4 = Field(line: 4, column: 4);
      c4.undermine();
      c1.addNeighbor(c2);
      c1.addNeighbor(c3);
      c1.addNeighbor(c4);

      expect(c1.numberOfMinesInTheNeighborhood, 2);
    });
  });
}
