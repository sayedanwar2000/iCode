// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/controller/cubits/layout_cubit.dart';
import 'package:task/controller/states/layout_states.dart';
import 'package:task/share/components/ItemServer.dart';
import 'package:task/share/style/colors.dart';

class ServersScreen extends StatelessWidget {
  ServersScreen({super.key});

  var formKey = GlobalKey<FormState>();
  RegExp expIP = RegExp(r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}');
  RegExp expDomain = RegExp(
      r'(http|ftp|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?');

  @override
  Widget build(BuildContext context) {
    var layoutCubit = LayoutCubit.get(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: defaultColorNavyBlue,
            title: const Text(
              'Servers',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: layoutCubit.servers.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (context, index) => itemServer(
                    context: context,
                    server: layoutCubit.servers[index],
                    layoutCubit: layoutCubit,
                    formKey: formKey,
                    expIP: expIP,
                    expDomain: expDomain,
                    state: state,
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 0,
                  ),
                  itemCount: layoutCubit.servers.length,
                )
              : noServer(),
        );
      },
    );
  }
}
