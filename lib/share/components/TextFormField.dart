// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:task/share/style/colors.dart';

Widget defaultTextFormField({
  required TextEditingController controll,
  required TextInputType type,
  required validat,
  required String label,
  required prefix,
  ontap,
  bool isEnabled = true,
  bool isPassword = false,
  IconData? suffix,
  suffixPressed,
  onChange,
  colorFocuseBorder,
  bool borderLine = false,
}) =>
    TextFormField(
      controller: controll,
      keyboardType: type,
      validator: validat,
      obscureText: isPassword,
      enabled: isEnabled,
      onTap: ontap,
      onChanged: onChange,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: defaultColorNavyBlue,
        ),
        prefixIcon: Icon(
          prefix,
          color: defaultColorNavyBlue,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suffix),
              )
            : null,
        border: borderLine
            ? const UnderlineInputBorder()
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
        focusedBorder: borderLine
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: colorFocuseBorder),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: colorFocuseBorder),
              ),
      ),
    );
