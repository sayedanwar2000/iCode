// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:task/share/components/DefaultButton.dart';
import 'package:task/share/components/NavigateAndFinish.dart';
import 'package:task/share/network/local/cache_helper/cache.dart';
import 'package:task/share/style/colors.dart';
import 'package:task/views/layout/layout_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  String name = CacheHelper.getData(key: 'name') ?? '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hi $name',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: defaultColorNavyBlue,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            defaultButton(
              backgroundColor: defaultColorNavyBlue,
              function: () {
                navigateAndFinish(context, LayoutScreen());
              },
              text: 'Logout',
            ),
          ],
        ),
      ),
    );
  }
}
