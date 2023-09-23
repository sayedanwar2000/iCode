// ignore_for_file: void_checks, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/controller/cubits/layout_cubit.dart';
import 'package:task/controller/states/layout_states.dart';
import 'package:task/share/components/FloatingActionButton.dart';
import 'package:task/share/style/colors.dart';

class LayoutScreen extends StatelessWidget {
  LayoutScreen({super.key});

  RegExp expIP = RegExp(r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}');
  RegExp expDomain = RegExp(
      r'(http|ftp|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?');

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var layoutCubit = LayoutCubit.get(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        TextEditingController serverName = TextEditingController();
        TextEditingController ip = TextEditingController();
        return Scaffold(
          body: layoutCubit.screen[layoutCubit.currentIndex],
          floatingActionButton: layoutCubit.currentIndex != 1
              ? null
              : floatingActionButton(
                  state: state,
                  serverName: serverName,
                  ip: ip,
                  formKey: formKey,
                  context: context,
                  expIP: expIP,
                  expDomain: expDomain,
                  layoutCubit: layoutCubit,
                ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                color: defaultColorGrey,
              )),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: defaultColorNavyBlue,
              selectedIconTheme: IconThemeData(
                color: defaultColorNavyBlue,
              ),
              currentIndex: layoutCubit.currentIndex,
              onTap: (index) {
                layoutCubit.changeCurrentIndex(index);
                if (index == 1) {
                  layoutCubit.getDataFromDataBase();
                }
              },
              elevation: 0,
              iconSize: 30,
              items: [
                BottomNavigationBarItem(
                  backgroundColor: defaultColorNavyBlue,
                  icon: const Icon(
                    Icons.person,
                  ),
                  label: 'Login',
                ),
                BottomNavigationBarItem(
                  backgroundColor: defaultColorNavyBlue,
                  icon: SvgPicture.asset(
                    'assets/SVGS/database2.svg',
                    width: 20,
                    height: 28,
                    color: layoutCubit.currentIndex == 1
                        ? defaultColorNavyBlue
                        : defaultColorBlack54,
                  ),
                  label: 'servers',
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
