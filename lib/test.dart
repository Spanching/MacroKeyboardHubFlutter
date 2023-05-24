import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setWindowTitle("MacroKeyboardHub");
  setWindowMinSize(const Size(600, 600));
  setWindowMaxSize(const Size(600, 600));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Macro Keyboard Hub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.skip_previous)),
                Expanded(
                    child: Text(
                  "Configuration",
                  textAlign: TextAlign.center,
                )),
                IconButton(onPressed: () {}, icon: Icon(Icons.skip_next)),
                IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Container(
                color: Colors.yellow,
                height: 500,
                width: 500,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1 / 1,
                        mainAxisSpacing: 20.0,
                        crossAxisSpacing: 20.0),
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.green,
                        child:
                            IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
