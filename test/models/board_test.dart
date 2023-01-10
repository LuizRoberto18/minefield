import 'package:flutter_test/flutter_test.dart';
import 'package:minefield/models/board.dart';

main() {
  test('Ganhar jogo', () {
    Board tabuleiro = Board(lines: 2, columns: 2, amountOfBombs: 0);

    tabuleiro.fields[0].undermine();
    tabuleiro.fields[3].undermine();

    //Jogando..
    tabuleiro.fields[0].changeMarking();
    tabuleiro.fields[1].opening();
    tabuleiro.fields[2].opening();
    tabuleiro.fields[3].changeMarking();

    expect(tabuleiro.resolved, true);
  });
}
