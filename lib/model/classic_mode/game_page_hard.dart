import 'package:flutter/material.dart';

class GamePageHard extends StatefulWidget {
  final String player1Name;
  final String player2Name;
  final Color player1Color;
  final Color player2Color;

  const GamePageHard(
      {super.key,
      required this.player1Name,
      required this.player2Name,
      required this.player1Color,
      required this.player2Color});

  @override
  State<GamePageHard> createState() => _GamePageHardState();
}

class _GamePageHardState extends State<GamePageHard> {
  List<List<String>> gameBoard =
      List.generate(5, (_) => List.filled(5, '')); // For a 5x5 board
  bool isPlayer1Turn = true;
  String currentPlayer = '';
  int player1Wins = 0;
  int player2Wins = 0;

  @override
  void initState() {
    super.initState();
    currentPlayer = widget.player1Name;
  }

  void resetGame() {
    setState(() {
      gameBoard =
          List.generate(5, (_) => List.filled(5, '')); // Reset for a new game
      isPlayer1Turn = true;
      currentPlayer = widget.player1Name;
    });
  }

  void makeMove(int row, int col) {
    setState(() {
      if (gameBoard[row][col] == '' && !checkForWinner()) {
        gameBoard[row][col] = isPlayer1Turn ? 'X' : 'O';
        if (checkForWinner()) {
          if (isPlayer1Turn) {
            player1Wins++;
          } else {
            player2Wins++;
          }
        } else {
          isPlayer1Turn = !isPlayer1Turn;
          currentPlayer =
              isPlayer1Turn ? widget.player1Name : widget.player2Name;
        }
      }
    });
  }

  bool checkForWinner() {
    List<List<int>> winningCombos = [
      // Rows
      [0, 1, 2, 3, 4],
      [5, 6, 7, 8, 9],
      [10, 11, 12, 13, 14],
      [15, 16, 17, 18, 19],
      [20, 21, 22, 23, 24],
      // Columns
      [0, 5, 10, 15, 20],
      [1, 6, 11, 16, 21],
      [2, 7, 12, 17, 22],
      [3, 8, 13, 18, 23],
      [4, 9, 14, 19, 24],
      // Diagonals
      [0, 6, 12, 18, 24],
      [4, 8, 12, 16, 20]
    ];

    for (var combo in winningCombos) {
      // Convert flat index to 2D index
      int row1 = combo[0] ~/ 5;
      int col1 = combo[0] % 5;
      int row2 = combo[1] ~/ 5;
      int col2 = combo[1] % 5;
      int row3 = combo[2] ~/ 5;
      int col3 = combo[2] % 5;
      int row4 = combo[3] ~/ 5;
      int col4 = combo[3] % 5;
      int row5 = combo[4] ~/ 5;
      int col5 = combo[4] % 5;

      if (gameBoard[row1][col1] != '' &&
          gameBoard[row1][col1] == gameBoard[row2][col2] &&
          gameBoard[row2][col2] == gameBoard[row3][col3] &&
          gameBoard[row3][col3] == gameBoard[row4][col4] &&
          gameBoard[row4][col4] == gameBoard[row5][col5]) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Game Over'),
              content: Text('$currentPlayer wins!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    resetGame();
                  },
                  child: const Text('Play Again'),
                ),
              ],
            );
          },
        );
        return true;
      }
    }

    if (!gameBoard.any((row) => row.any((cell) => cell == ''))) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Game Over'),
            content: const Text('It\'s a draw!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  resetGame();
                },
                child: const Text('Play Again'),
              ),
            ],
          );
        },
      );
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  color: widget.player1Color,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.player1Name.toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  color: widget.player2Color,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.player2Name.toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${widget.player1Name.toUpperCase()} Wins: $player1Wins',
                ),
                Text(
                  '${widget.player2Name.toUpperCase()} Wins: $player2Wins',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              isPlayer1Turn
                  ? '${widget.player1Name.toUpperCase()}\'s Turn (X)'
                  : '${widget.player2Name.toUpperCase()}\'s Turn (O)',
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 25,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              itemBuilder: (context, index) {
                int row = index ~/ 5;
                int col = index % 5;
                Color cellColor;
                String cellText = gameBoard[row][col];
                if (cellText == 'X') {
                  cellColor = widget.player1Color;
                } else if (cellText == 'O') {
                  cellColor = widget.player2Color;
                } else {
                  cellColor = Colors.transparent;
                }
                return InkWell(
                  onTap: () {
                    makeMove(row, col);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: cellColor,
                    ),
                    child: Center(
                      child: Text(
                        cellText,
                        style: TextStyle(
                          fontSize: 40.0,
                          color: cellText == 'X' ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: resetGame,
                child: const Text('Reset Game'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    player1Wins = 0;
                    player2Wins = 0;
                  });
                },
                child: const Text('Reset Scores'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
