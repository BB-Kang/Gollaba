
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:roulette/roulette.dart';
import 'arrow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RouletteApp extends StatelessWidget {
  const RouletteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '룰렛 게임',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RoulettePage(),
    );
  }
}

class MyRoulette extends StatelessWidget {
  const MyRoulette({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final RouletteController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          width: 260,
          height: 260,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Roulette(
              controller: controller,
              style: const RouletteStyle(
                dividerThickness: 4,
                textLayoutBias: .8,
                centerStickerColor: Color(0xFFD5E6F5),
              ),
            ),
          ),
        ),
        const Arrow(),
      ],
    );
  }
}

class RoulettePage extends StatefulWidget {
  const RoulettePage({Key? key}) : super(key: key);

  @override
  State<RoulettePage> createState() => _RoulettePage();
}

class _RoulettePage extends State<RoulettePage>
    with SingleTickerProviderStateMixin {
  static final _random = Random();

  late RouletteController _controller;
  bool _clockwise = true;

  final List<String> items = [];

  final colors = <Color>[
    Color(0xff1170C3),
  ];

  final icons = <IconData>[
    Icons.ac_unit,
    Icons.access_alarm,
    Icons.access_time,
    Icons.accessibility,
    Icons.account_balance,
    Icons.account_balance_wallet,
  ];

  @override
  void initState() {
    final group = RouletteGroup.uniform(
      items.length,
      textBuilder: ((index) => items[index]),
      textStyleBuilder: (index) => const TextStyle(color: Colors.black),
    );
    _controller = RouletteController(vsync: this, group: group);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('룰렛 게임'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "시계방향 : ",
                    style: TextStyle(fontSize: 18),
                  ),
                  Switch(
                    value: _clockwise,
                    onChanged: (onChanged) {
                      setState(() {
                        _controller.resetAnimation();
                        _clockwise = !_clockwise;
                      });
                    },
                  ),
                ],
              ),
              MyRoulette(controller: _controller),
              ElevatedButton(
                onPressed: () => _showItemInputDialog(context),
                child: const Text('항목 추가'),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.pink.withOpacity(0.1),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _controller.rollTo(
          3,
          clockwise: _clockwise,
          offset: _random.nextDouble(),
        ),
        child: const Icon(Icons.refresh_rounded),
      ),
    );
  }

  void _showItemInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        String newItem = '';
        return AlertDialog(
          title: const Text('항목 추가'),
          content: TextField(
            onChanged: (value) {
              newItem = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('취소'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('추가'),
              onPressed: () {
                setState(() {
                  items.add(newItem);
                  _controller.group = RouletteGroup.uniform(
                    items.length,
                    textBuilder: ((index) => items[index]),
                    textStyleBuilder: (index) => const TextStyle(color: Colors.black),
                    
                  );
                  FirebaseFirestore.instance.collection('items').doc('userItems').set({
                  'items': items,
                });
                });
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
