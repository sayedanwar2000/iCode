import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task/share/components/NavigateAndFinish.dart';
import 'package:task/share/network/local/cache_helper/cache.dart';
import 'package:task/views/home/home_screen.dart';
import 'package:task/views/layout/layout_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String token = CacheHelper.getData(key: 'token') ?? '';

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      navigateAndFinish(
        context,
        token.isNotEmpty ? HomeScreen() : LayoutScreen(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        'assets/images/icode.png',
        width: 200,
      )),
    );
  }
}
