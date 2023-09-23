// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:task/share/style/colors.dart';

Widget defaultButton({
  required Color backgroundColor,
  required function,
  required String text,
}) =>
    Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(
            color: defaultColorWhite,
          ),
        ),
      ),
    );