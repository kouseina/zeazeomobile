import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zeazeoshop/theme.dart';
import 'package:zeazeoshop/utils/shared_pref.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    navigateTo();
  }

  void navigateTo() async {
    await Future.delayed(Duration(seconds: 2));

    if (SharedPrefs().user != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/sign-in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Center(
        child: Container(
          width: 130,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/Union.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
