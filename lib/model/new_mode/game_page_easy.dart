import 'package:flutter/material.dart';

class GamePageEasy extends StatefulWidget {
  final String player1Name;
  final String player2Name;
  final Color player1Color;
  final Color player2Color;

  const GamePageEasy(
      {super.key,
      required this.player1Name,
      required this.player2Name,
      required this.player1Color,
      required this.player2Color});

  @override
  State<GamePageEasy> createState() => _GamePageEasyState();
}

class _GamePageEasyState extends State<GamePageEasy>
    with SingleTickerProviderStateMixin {
  List<String> gameBoard = List.filled(9, ''); // Represents the game board
  List<int> moveQueue = []; // Queue to track the moves
  bool isPlayer1Turn = true; // Tracks whose turn it is
  String currentPlayer = ''; // Tracks current player's symbol
  int player1Wins = 0; // Tracks the number of wins for player 1
  int player2Wins = 0; // Tracks the number of wins for player 2
  late AnimationController _animationController;
  int _removeIndex = -1;

  @override
  void initState() {
    super.initState();
    currentPlayer = widget.player1Name; // Player 1 starts the game
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 700), // Duration of the animation
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController
        .dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  void resetGame() {
    setState(() {
      gameBoard = List.filled(9, '');
      moveQueue.clear(); //clear the move queue
      isPlayer1Turn = true;
      currentPlayer = widget.player1Name;
    });
  }

  void makeMove(int index) {
    setState(() {
      if (gameBoard[index] == '' && !checkForWinner()) {
        gameBoard[index] = isPlayer1Turn ? 'X' : 'O';
        moveQueue.add(index); // Add move to the queue
        if (moveQueue.length > 6) {
          _removeIndex = moveQueue.removeAt(0); // Remove the first move
          // Start the animation
          _animationController.forward().then((_) {
            setState(() {
              gameBoard[_removeIndex] =
                  ''; // Clear the cell of the first move after animation
              _animationController.reset();
            });
          });
        }
        if (checkForWinner()) {
          // Update wins if there's a winner
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
    // Winning combinations
    List<List<int>> winningCombos = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6] // Diagonals
    ];

    for (var combo in winningCombos) {
      if (gameBoard[combo[0]] != '' &&
          gameBoard[combo[0]] == gameBoard[combo[1]] &&
          gameBoard[combo[1]] == gameBoard[combo[2]]) {
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

    // Check for draw
    if (!gameBoard.contains('') && !checkForWinner()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Draw'),
            content: const Text('The game is a draw!'),
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
      return false; // No winner if it's a draw
    }
    return false; // No winner by default
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Column(
        children: [
          // Player names
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Player 1 name with color container
                Container(
                  color: widget.player1Color,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.player1Name.toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                // Player 2 name with color container
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
          // Wins count
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('${widget.player1Name.toUpperCase()} Wins: $player1Wins'),
                Text('${widget.player2Name.toUpperCase()} Wins: $player2Wins'),
              ],
            ),
          ),
          // Turn indicator
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              isPlayer1Turn
                  ? '${widget.player1Name.toUpperCase()}\'s Turn (X)'
                  : '${widget.player2Name.toUpperCase()}\'s Turn (O)',
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
          // Game board
          Expanded(
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                Color cellColor;
                String cellText = gameBoard[index];
                if (cellText == 'X') {
                  cellColor = widget.player1Color;
                } else if (cellText == 'O') {
                  cellColor = widget.player2Color;
                } else {
                  cellColor = Colors.transparent;
                }
                return AnimatedOpacity(
                  opacity:
                      index == _removeIndex && _animationController.isAnimating
                          ? 0.0
                          : 1.0,
                  duration: _animationController.duration!,
                  child: InkWell(
                    onTap: () {
                      makeMove(index);
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
          // Reset button
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
          // Reset button for wins count
        ],
      ),
    );
  }
}
