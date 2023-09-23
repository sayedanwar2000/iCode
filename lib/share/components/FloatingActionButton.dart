// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:task/controller/states/layout_states.dart';
import 'package:task/share/components/DefaultButton.dart';
import 'package:task/share/components/TextFormField.dart';
import 'package:task/share/style/colors.dart';

Widget floatingActionButton({
  required state,
  required serverName,
  required ip,
  required formKey,
  required context,
  required expIP,
  required expDomain,
  required layoutCubit,
}) =>
    FloatingActionButton(
      backgroundColor: defaultColorNavyBlue,
      child: Icon(
        Icons.add,
        color: defaultColorWhite,
      ),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: defaultColorNavyBlue,
          title: const Text('Add New server'),
          titlePadding: const EdgeInsets.all(10),
          titleTextStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: defaultColorWhite,
          ),
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            color: defaultColorWhite,
            height: 325,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultTextFormField(
                      controll: serverName,
                      type: TextInputType.text,
                      validat: (String? value) {
                        if (value!.isEmpty) {
                          return '';
                        } else {
                          return null;
                        }
                      },
                      label: 'Server Name',
                      borderLine: true,
                      prefix: Icons.dns_sharp,
                      colorFocuseBorder: defaultColorGrey,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    defaultTextFormField(
                      controll: ip,
                      type: TextInputType.text,
                      validat: (String? value) {
                        if (value!.isEmpty) {
                          return '';
                        } else if (!expIP.hasMatch(ip.text)) {
                          if (!expDomain.hasMatch(ip.text)) {
                            return 'Please enter IP Or Domain Correct';
                          } else {
                            return null;
                          }
                        } else {
                          return null;
                        }
                      },
                      label: 'Server IP / Domain',
                      borderLine: true,
                      prefix: Icons.link,
                      colorFocuseBorder: defaultColorGrey,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 13,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: defaultColorNavyBlue,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Default Server',
                                style: TextStyle(
                                  color: defaultColorNavyBlue,
                                ),
                              ),
                              const Spacer(),
                              Checkbox(
                                value: layoutCubit.isDefaultServer,
                                onChanged: (value) {
                                  layoutCubit.changeIsDefaultServer(value);
                                },
                              ),
                            ],
                          ),
                          Divider(
                            color: defaultColorGrey,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        defaultButton(
                          backgroundColor: defaultColorNavyBlue,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              layoutCubit.insertToDataBase(
                                name: serverName.text,
                                ip: ip.text,
                              );
                              if (state is InsertDatabaseSuccessState) {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }
                              }
                            }
                          },
                          text: 'Save',
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        defaultButton(
                          backgroundColor: defaultColorNavyBlue,
                          function: () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          },
                          text: 'Cancel',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
