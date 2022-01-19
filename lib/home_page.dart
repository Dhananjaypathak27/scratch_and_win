import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AssetImage circle = const AssetImage("images/circle.png");
  AssetImage lucky = const AssetImage("images/rupee.png");
  AssetImage unLucky = const AssetImage("images/sadFace.png");

  late List<String> itemArray;
  int? luckyNumber;
  int counter = 0;
  bool isGameOver = false;

  @override
  void initState() {
    super.initState();
    itemArray = List<String>.generate(25, (index) => "empty");
    generateRandomNumber();
  }

  generateRandomNumber() {
    int random = Random().nextInt(25);
    setState(() {
      luckyNumber = random;
    });
  }

  resetGame() {
    itemArray = List<String>.filled(25, "empty");
    generateRandomNumber();
    isGameOver = false;
    counter = 0;
  }

  AssetImage getImage(int index) {
    String currentState = itemArray[index];
    switch (currentState) {
      case "lucky":
        return lucky;
      case "unlucky":
        return unLucky;
    }
    return circle;
  }

  playGame(int index) {
    if (counter > 5) {
      setState(() {
        isGameOver = true;
      });
    } else {
      if (luckyNumber == index) {
        setState(() {
          itemArray[index] = "lucky";
        });
      } else {
        setState(() {
          itemArray[index] = "unlucky";
        });
      }
    }
  }

  showAll() {
    setState(() {
      itemArray = List<String>.filled(25, "unlucky");
      itemArray[luckyNumber!] = "lucky";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scratch and Win'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: itemArray.length,
                  itemBuilder: (context, i) => SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () {
                            counter++;
                            playGame(i);
                          },
                          child: Image(
                            image: getImage(i),
                          ),
                        ),
                      ))),
          Visibility(
            visible: isGameOver,
            child: Center(
                child: const Text(
              "Game Over!!!",
              style: TextStyle(
                  color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
            )),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: ElevatedButton(
              child: const Padding(
                  padding: EdgeInsets.all(18), child: Text("Show All")),
              onPressed: showAll,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text("Rest"),
              ),
              onPressed: resetGame,
            ),
          ),
        ],
      ),
    );
  }
}
