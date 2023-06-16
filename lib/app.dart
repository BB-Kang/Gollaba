// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:shrine/details.dart';

import 'auth_gate.dart';
import 'home.dart';

class GollabaApp extends StatelessWidget {
  const GollabaApp( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gollaba',
      // initialRoute: '/login',
      routes: {
        // '/login': (BuildContext context) => const AuthGate(),
        // '/detail': (BuildContext context) => const DetailPage(),
        // '/': (BuildContext context) => const HomePage(),
      },
      theme: ThemeData(
        primaryColor: Color(0xff1170C3),
        hintColor : Colors.black,
        backgroundColor: Color(0xff1170C3),
      ),
      home: const AuthGate(),
    );
  }
}

