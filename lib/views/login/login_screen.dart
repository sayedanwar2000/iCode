// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task/controller/cubits/login_cubit.dart';
import 'package:task/controller/states/login_states.dart';
import 'package:task/share/components/ButtonFingerprint.dart';
import 'package:task/share/components/ButtonLogin.dart';
import 'package:task/share/components/NavigateAndFinish.dart';
import 'package:task/share/components/TextFormField.dart';
import 'package:task/share/network/local/cache_helper/cache.dart';
import 'package:task/share/style/colors.dart';
import 'package:task/views/home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var loginCubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          Fluttertoast.showToast(
            msg: loginCubit.messageError,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: defaultColorRed,
              textColor: defaultColorWhite,
              fontSize: 16.0
          );
        }
        if (state is LoginSuccessState) {
          CacheHelper.saveData(
              key: 'token', value: loginCubit.loginModel.resource!.token).then((value){
            CacheHelper.saveData(
                key: 'name', value: loginCubit.loginModel.resource!.name).then((value){
              navigateAndFinish(context, HomeScreen());
            });
          });
        }
      },
      builder: (BuildContext context, LoginStates state) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 50,
            left: 10,
            right: 10,
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/icode.png',
                      width: 250,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    defaultTextFormField(
                      controll: userName,
                      type: TextInputType.text,
                      validat: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your username.';
                        } else {
                          return null;
                        }
                      },
                      label: 'Username',
                      prefix: Icons.person,
                      colorFocuseBorder: defaultColorNavyBlue,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultTextFormField(
                      controll: password,
                      type: TextInputType.text,
                      validat: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password.';
                        } else {
                          return null;
                        }
                      },
                      label: 'Password',
                      prefix: Icons.lock,
                      isPassword: true,
                      colorFocuseBorder: defaultColorNavyBlue,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    loginButton(
                      context: context,
                      formKey: formKey,
                      loginCubit: loginCubit,
                      state: state,
                      userName: userName,
                      password: password,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    fingerprintButton(
                      loginCubit: loginCubit,
                      context: context,
                      state: state,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
