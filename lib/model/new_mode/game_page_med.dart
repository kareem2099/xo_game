import 'package:flutter/material.dart';

class GamePageMed extends StatefulWidget {
  final String player1Name;
  final String player2Name;
  final Color player1Color;
  final Color player2Color;

  const GamePageMed(
      {super.key,
      required this.player1Name,
      required this.player2Name,
      required this.player1Color,
      required this.player2Color});

  @override
  State<GamePageMed> createState() => _GamePageMedState();
}

class _GamePageMedState extends State<GamePageMed>
    with SingleTickerProviderStateMixin {
  List<List<String>> gameBoard =
      List.generate(4, (_) => List.filled(4, '')); // For a 4x4 board
  List<int> moveQueue = []; // Queue to track the moves
  bool isPlayer1Turn = true;
  String currentPlayer = '';
  int player1Wins = 0;
  int player2Wins = 0;
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  int _removeIndex = -1;

  @override
  void initState() {
    super.initState();
    currentPlayer = widget.player1Name; // Player 1 starts the game
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 700), // Duration of the animation
      vsync: this,
    );
    // Define the opacity animation
    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void resetGame() {
    setState(() {
      gameBoard =
          List.generate(4, (_) => List.filled(4, '')); // Reset for a new game
      moveQueue.clear(); //clear the move queue
      isPlayer1Turn = true;
      currentPlayer = widget.player1Name;
    });
  }

  void makeMove(int row, int col) {
    int flatIndex =
        row * 4 + col; // Convert 2D index to flat index for the queue
    setState(() {
      if (gameBoard[row][col] == '' && !checkForWinner()) {
        gameBoard[row][col] = isPlayer1Turn ? 'X' : 'O';
        moveQueue.add(flatIndex); // Add move to the queue
        if (moveQueue.length > 8) {
          _removeIndex = moveQueue.removeAt(0); // Remove the first move
          // Start the fade out animation
          _animationController.forward().then((_) {
            setState(() {
              gameBoard[_removeIndex ~/ 4][_removeIndex % 4] =
                  ''; // Clear the cell of the first move after animation
              _animationController.reset();
            });
          });
        }
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
      [0, 1, 2, 3],
      [4, 5, 6, 7],
      [8, 9, 10, 11],
      [12, 13, 14, 15],
      // Columns
      [0, 4, 8, 12],
      [1, 5, 9, 13],
      [2, 6, 10, 14],
      [3, 7, 11, 15],
      // Diagonals
      [0, 5, 10, 15],
      [3, 6, 9, 12]
    ];

    for (var combo in winningCombos) {
      // Convert flat index to 2D index
      int row1 = combo[0] ~/ 4;
      int col1 = combo[0] % 4;
      int row2 = combo[1] ~/ 4;
      int col2 = combo[1] % 4;
      int row3 = combo[2] ~/ 4;
      int col3 = combo[2] % 4;
      int row4 = combo[3] ~/ 4;
      int col4 = combo[3] % 4;

      if (gameBoard[row1][col1] != '' &&
          gameBoard[row1][col1] == gameBoard[row2][col2] &&
          gameBoard[row2][col2] == gameBoard[row3][col3] &&
          gameBoard[row3][col3] == gameBoard[row4][col4]) {
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
              itemCount: 16,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                int row = index ~/ 4;
                int col = index % 4;
                Color cellColor;
                String cellText = gameBoard[row][col];
                if (cellText == 'X') {
                  cellColor = widget.player1Color;
                } else if (cellText == 'O') {
                  cellColor = widget.player2Color;
                } else {
                  cellColor = Colors.transparent;
                }
                return AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) => AnimatedOpacity(
                    opacity: _removeIndex == index &&
                            _animationController.isAnimating
                        ? _opacityAnimation.value
                        : 1,
                    duration: _animationController.duration!,
                    child: child,
                  ),
                  child: InkWell(
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
                            color:
                                cellText == 'X' ? Colors.white : Colors.black,
                          ),
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
