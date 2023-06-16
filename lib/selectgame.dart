import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class SelectGameApp extends StatefulWidget {
  @override
  _SelectGameAppState createState() => _SelectGameAppState();
}

class _SelectGameAppState extends State<SelectGameApp> {
  List<String> choices = []; // 선택지를 저장할 리스트

  TextEditingController choiceController = TextEditingController();
  String selectedChoice = ''; // 선택된 결과를 저장할 변수

  void addChoice() {
    setState(() {
      String newChoice = choiceController.text;
      if (newChoice.isNotEmpty) {
        choices.add(newChoice);
        choiceController.clear();
        saveChoices(); 
      }
    });
  }

  void removeChoice(String choice) {
    setState(() {
      choices.remove(choice);
      if (selectedChoice == choice) {
        selectedChoice = '';
      }
    });
  }
  void saveChoices() {
  // Firestore collection 참조
  CollectionReference choicesCollection =
      FirebaseFirestore.instance.collection('선택');

  // 선택지를 Firestore에 저장
  for (String choice in choices) {
    choicesCollection.add({'선택': choice});
  }
}

  void makeRandomChoice() {
    setState(() {
      if (choices.isNotEmpty) {
        int randomIndex = Random().nextInt(choices.length);
        selectedChoice = choices[randomIndex];
      } else {
        selectedChoice = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('선택 게임'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: choiceController,
              style: TextStyle(color: Colors.blue),
              decoration: InputDecoration(
                labelText: '선택지를 입력하세요',
                labelStyle: TextStyle(color: Color(0xff1170C3)),
              ),
            ),
            ElevatedButton(
              onPressed: addChoice,
              child: Text('선택지 추가'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: choices.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Chip(
                          label: Text(choices[index]),
                          onDeleted: () => removeChoice(choices[index]),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: makeRandomChoice,
              child: Text('결정하기'),
            ),
            SizedBox(height: 16.0),
            Text(
              '선택된 결과: $selectedChoice',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
