import 'package:flutter/material.dart';
import 'package:xo_game/model/game_page.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class PlayerPage extends StatefulWidget {
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  TextEditingController player1NameController = TextEditingController();
  TextEditingController player2NameController = TextEditingController();
  Color player1Color = Colors.blue; // Default colors
  Color player2Color = Colors.red;

  @override
  void dispose() {
    player1NameController.dispose();
    player2NameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Selection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: player1NameController,
              decoration: const InputDecoration(
                labelText: 'Player 1 Name',
              ),
            ),
            const SizedBox(height: 20),
            CircleAvatar(
              backgroundColor: player1Color,
              child: IconButton(
                icon: const Icon(Icons.color_lens),
                onPressed: () async {
                  Color? selectedColor = await showDialog<Color>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Select Color'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: player1Color,
                            onColorChanged: (color) {
                              setState(() {
                                player1Color = color;
                              });
                            },
                            colorPickerWidth: 300.0,
                            pickerAreaHeightPercent: 0.7,
                            enableAlpha: true,
                            displayThumbColor: true,
                            showLabel: true,
                            paletteType: PaletteType.hsv,
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(player1Color);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                  if (selectedColor != null) {
                    setState(() {
                      player1Color = selectedColor;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: player2NameController,
              decoration: const InputDecoration(
                labelText: 'Player 2 Name',
              ),
            ),
            const SizedBox(height: 20),
            CircleAvatar(
              backgroundColor: player2Color,
              child: IconButton(
                icon: const Icon(Icons.color_lens),
                onPressed: () async {
                  Color? selectedColor = await showDialog<Color>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Select Color'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: player2Color,
                            onColorChanged: (color) {
                              setState(() {
                                player2Color = color;
                              });
                            },
                            colorPickerWidth: 300.0,
                            pickerAreaHeightPercent: 0.7,
                            enableAlpha: true,
                            displayThumbColor: true,
                            showLabel: true,
                            paletteType: PaletteType.hsv,
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(player2Color);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                  if (selectedColor != null) {
                    setState(() {
                      player2Color = selectedColor;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String player1Name = player1NameController.text;
                String player2Name = player2NameController.text;
                if (player1Name.isNotEmpty && player2Name.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GamePage(
                        player1Name: player1Name,
                        player2Name: player2Name,
                        player1Color: player1Color,
                        player2Color: player2Color,
                      ),
                    ),
                  );
                } else {
                  // Show a message if any field is empty
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content:
                            const Text('Please enter names for both players.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}
