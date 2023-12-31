import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

import 'home.dart';

class AuthGate extends StatelessWidget {
 const AuthGate({super.key});

 @override
 Widget build(BuildContext context) {
   return StreamBuilder<User?>(
     stream: FirebaseAuth.instance.authStateChanges(),
     builder: (context, snapshot) {
       if (!snapshot.hasData) {
         return SignInScreen(
           providerConfigs: const [
             EmailProviderConfiguration(),
           ],
           headerBuilder: (context, constraints, shrinkOffset
) {
             return Padding(
               padding: const EdgeInsets.all(20),
               child: AspectRatio(
                 aspectRatio: 1,
                 child: Image.asset('assets/logos/logo_black.png'),
               ),
             );
           },
         );
       }

       return HomePage();
     },
   );
 }
}

typedef HeaderBuilder = Widget Function(
 BuildContext context,
 BoxConstraints constraints,
 double shrinkOffset,
);