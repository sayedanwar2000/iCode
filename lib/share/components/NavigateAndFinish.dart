// ignore_for_file: file_names

import 'package:flutter/material.dart';

void navigateAndFinish(context, Widget widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );
