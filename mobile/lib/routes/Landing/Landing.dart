import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:TraXpense/routes/Auth/Auth.dart';
import 'package:TraXpense/routes/Home/Home.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          FirebaseUser user = snapshot.data;
          if (user == null) {
            return Auth();
          }
          return Home();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
