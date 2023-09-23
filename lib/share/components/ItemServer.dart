// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/controller/states/layout_states.dart';
import 'package:task/share/components/DefaultButton.dart';
import 'package:task/share/components/TextFormField.dart';
import 'package:task/share/style/colors.dart';

Widget itemServer({
  required context,
  required state,
  required server,
  required layoutCubit,
  required formKey,
  required RegExp expIP,
  required RegExp expDomain,

}) {
  TextEditingController serverName = TextEditingController();
  TextEditingController ip = TextEditingController();
  serverName.text = server['name'];
  ip.text = server['ip'];
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: defaultColorGrey,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Server Name:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            server['name'],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Server IP / Domian:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            server['ip'],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Default Server:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            server['defaultServer'],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: defaultColorNavyBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: ()
                {
                  layoutCubit.changeIsDefaultServer(server['defaultServer'] == 'true');
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      backgroundColor: defaultColorNavyBlue,
                      title: const Text('Edit server'),
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
                                    }
                                    else if (!expIP.hasMatch(ip.text)){
                                      if(!expDomain.hasMatch(ip.text)) {
                                        return 'Please enter IP Or Domain Correct';
                                      }
                                      else {
                                        return null;
                                      }
                                    }
                                    else {
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
                                              layoutCubit
                                                  .changeIsDefaultServer(value);
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
                                          layoutCubit.updateDataInDataBase(
                                            name: serverName.text,
                                            ip: ip.text,
                                            id: server['id'],
                                          );
                                          if (state is UpdateDatabaseSuccessState) {
                                            Navigator.pop(context);
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
                                        Navigator.pop(context);
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
                  );
                },
                icon: SvgPicture.asset(
                  'assets/SVGS/edit.svg',
                  width: 15,
                  height: 23,
                  color: defaultColorWhite,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: defaultColorRed,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    backgroundColor: defaultColorNavyBlue,
                    title: const Text('Delete server'),
                    titlePadding: const EdgeInsets.all(10),
                    titleTextStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: defaultColorWhite,
                    ),
                    contentPadding: const EdgeInsets.all(0),
                    content: Container(
                      color: defaultColorWhite,
                      height: 130,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              'Are you sure you want to delete this selected server?',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                defaultButton(
                                  backgroundColor: defaultColorNavyBlue,
                                  function: () {
                                    layoutCubit.deleteDataInDataBase(
                                      id: server['id'],
                                    );
                                  },
                                  text: 'Delete',
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                defaultButton(
                                  backgroundColor: defaultColorNavyBlue,
                                  function: () {
                                    Navigator.pop(context);
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
                icon: SvgPicture.asset(
                  'assets/SVGS/delete.svg',
                  width: 15,
                  height: 23,
                  color: defaultColorWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


Widget noServer() => Center(
      child: Text(
        'No Server added',
        style: TextStyle(color: defaultColorNavyBlue),
      ),
    );
