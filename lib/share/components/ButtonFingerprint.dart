// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:task/controller/states/login_states.dart';
import 'package:task/share/components/DefaultButton.dart';
import 'package:task/share/network/local/cache_helper/cache.dart';
import 'package:task/share/style/colors.dart';

Widget fingerprintButton({
  required loginCubit,
  required context,
  required state,
}) =>
    IconButton(
      onPressed: () {
        loginCubit.getFingerPrint();
        if (state is GetAvailableBiometricsSuccess) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              backgroundColor: defaultColorNavyBlue,
              title: Text(
                loginCubit.fingerPrintList.isNotEmpty
                    ? 'Enable Fingerprint'
                    : 'Alert',
              ),
              titlePadding: const EdgeInsets.all(10),
              titleTextStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: defaultColorWhite,
              ),
              contentPadding: const EdgeInsets.all(0),
              content: Container(
                color: defaultColorWhite,
                height: 170,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(
                        loginCubit.fingerPrintList.isNotEmpty
                            ? 'Do you want to enable logging in to iCode Critical Results using your fingerprint?'
                            : 'No fingerprint saved, you need to login with your credentials first scan your fingerprint.',
                        style: TextStyle(
                          color: defaultColorNavyBlue,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: defaultColorGrey,
                        width: double.infinity,
                        height: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      loginCubit.fingerPrintList.isNotEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                defaultButton(
                                  backgroundColor: defaultColorNavyBlue,
                                  function: () {
                                    CacheHelper.saveData(
                                            key: 'fingerprint', value: true)
                                        .then((value) {
                                      if (Navigator.canPop(context)) {
                                        Navigator.pop(context);
                                      }
                                    });
                                  },
                                  text: 'Yes',
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
                            )
                          : defaultButton(
                              backgroundColor: defaultColorNavyBlue,
                              function: () {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }
                              },
                              text: 'OK',
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
      icon: Icon(
        Icons.fingerprint,
        color: defaultColorNavyBlue,
        size: 40,
      ),
    );
