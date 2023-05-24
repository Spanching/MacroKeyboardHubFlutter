import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Button Grid',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ButtonGrid(),
    );
  }
}

class ButtonGrid extends StatefulWidget {
  @override
  _ButtonGridState createState() => _ButtonGridState();
}

class _ButtonGridState extends State<ButtonGrid> {
  List<String> buttonLabels =
      List.generate(16, (index) => String.fromCharCode(65 + index));
  String pressedButtonLabel = '';

  void showButtonModal(String label) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ButtonModal(label: label);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    var matrixSize = size * 0.8;
    var headingSize = size - matrixSize - 40;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: headingSize,
              width: size,
              child: Text("Macro Keyboard Hub"),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: matrixSize,
                width: matrixSize,
                child: GridView.count(
                  crossAxisCount: 4,
                  childAspectRatio: 1 / 1,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  children: buttonLabels.map((label) {
                    return Container(
                      color: Colors.green,
                      width: size * 0.2,
                      height: size * 0.2,
                      child: TextButton(
                        child: Text(
                          label,
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          setState(() {
                            pressedButtonLabel = label;
                          });
                          showButtonModal(label);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonModal extends StatefulWidget {
  final String label;

  const ButtonModal({Key? key, required this.label}) : super(key: key);

  @override
  _ButtonModalState createState() => _ButtonModalState();
}

class _ButtonModalState extends State<ButtonModal> {
  List<String> multiKeyPressed = [];
  List<String> lastMultiPress = [];
  List<String> pressTest = [];
  bool isListening = true;
  FocusNode keyboardListenerFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Change Button ${widget.label} Function'),
      content: KeyboardListener(
        autofocus: true,
        focusNode: keyboardListenerFocusNode,
        onKeyEvent: (value) {
          print("key event");
          if (!isListening) {
            print("not listening");
            return;
          }
          if (value is KeyDownEvent) {
            multiKeyPressed.add(value.logicalKey.keyLabel);
            print(value.logicalKey.debugName);
            if (!pressTest.contains(value.logicalKey.keyLabel)) {
              pressTest.add(value.logicalKey.keyLabel);
            }
          } else if (value is KeyUpEvent) {
            pressTest.remove(value.logicalKey.keyLabel);
          }
          print(multiKeyPressed);
          print(pressTest);
          if (multiKeyPressed.isNotEmpty && pressTest.isEmpty) {
            lastMultiPress = multiKeyPressed;
            multiKeyPressed = [];
            isListening = false;
            setState(() {});
          }
        },
        child: Column(
          children: [
            Text('Multiple Key Pressed: ${lastMultiPress.join(', ')}'),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isListening = !isListening;
                        keyboardListenerFocusNode.requestFocus();
                      });
                    },
                    child: Text(isListening ? "Stop" : "Listen")),
                ElevatedButton(
                  child: Text('ABBR'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: Text('RESET'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: Text('PREV'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: Text('NEXT'),
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
