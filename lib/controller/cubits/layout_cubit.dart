// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task/controller/states/layout_states.dart';
import 'package:task/share/network/local/cache_helper/cache.dart';
import 'package:task/share/network/local/database/database.dart';
import 'package:task/views/login/login_screen.dart';
import 'package:task/views/servers/servers_screen.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(InitialLayoutStates());

  static LayoutCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screen = [
    LoginScreen(),
    ServersScreen(),
  ];
  late Database database;
  DataBase data = DataBase();
  static String baseUrl = '';
  bool isDefaultServer = false;
  List<dynamic> servers = [];

  void changeCurrentIndex(index) {
    currentIndex = index;
    emit(ChangeCurrentIndexLayoutStates());
  }

  void changeIsDefaultServer(bool? value) {
    isDefaultServer = value ?? false;
    emit(ChangeIsDefaultServerLayoutStates());
  }

  void createDataBase() async {
    emit(CreateDatabaseLoadingState());
    await data.createDataBase().then((value) {
      database = value;
      emit(CreateDatabaseSuccessState());
    }).catchError((error) {
      emit(CreateDatabaseErrorState());
    });
  }

  void insertToDataBase({
    required String name,
    required String ip,
  }) async {
    emit(InsertDatabaseLoadingState());
    if (isDefaultServer && baseUrl.isNotEmpty) {
      updateDefaultServerInDataBase(
        defaultServer: false,
        id: CacheHelper.getData(key: 'idDefaultServer'),
      );
      CacheHelper.removeData(key: 'idDefaultServer');
      baseUrl = '';
    }
    await data
        .insertToDataBase(
      name: name,
      ip: ip,
      defaultServer: isDefaultServer,
      database: database,
    )
        .then((value) {
      getDataFromDataBase();
      isDefaultServer = false;
      emit(InsertDatabaseSuccessState());
    }).catchError((error) {
      emit(InsertDatabaseErrorState());
    });
  }

  void updateDataInDataBase({
    required name,
    required ip,
    required id,
  }) async {
    emit(UpdateDatabaseLoadingState());
    if (isDefaultServer && baseUrl.isNotEmpty) {
      updateDefaultServerInDataBase(
        defaultServer: false,
        id: CacheHelper.getData(key: 'idDefaultServer'),
      );
      CacheHelper.removeData(key: 'idDefaultServer');
      baseUrl = '';
    }
    await data.updateData(
      name: name,
      ip: ip,
      defaultServer: isDefaultServer,
      database: database,
      id: id,
    ).then((value) {
      getDataFromDataBase();
      isDefaultServer = false;
      emit(UpdateDatabaseSuccessState());
    }).catchError((error) {
      emit(UpdateDatabaseErrorState());
    });
  }

  void updateDefaultServerInDataBase({
    required defaultServer,
    required id,
  }) async {
    emit(UpdateDatabaseLoadingState());
    await data.updateDefaultServer(
      defaultServer: defaultServer,
      database: database,
      id: id,
    ).then((value) {
      data.getDataFromDataBase(database);
      emit(UpdateDatabaseSuccessState());
    }).catchError((error) {
      emit(UpdateDatabaseErrorState());
    });
  }

  void deleteDataInDataBase({
    required id,
  }) async {
    emit(DeleteDatabaseLoadingState());
    await data
        .deleteData(
      id: id,
      database: database,
    )
        .then((value) {
      getDataFromDataBase();
      emit(DeleteDatabaseSuccessState());
    }).catchError((error) {
      emit(DeleteDatabaseErrorState());
    });
  }

  void getDataFromDataBase() async {
    servers = [];
    emit(GetDatabaseLoadingState());
    await data.getDataFromDataBase(database).then((value){
      if(value.isNotEmpty){
        value.forEach((element) async {
          if (element['defaultServer'] == 'true') {
            baseUrl = element['ip'];
            await CacheHelper.saveData(
                key: 'idDefaultServer', value: element['id']);
          }
        });
        servers = value;
      }
      emit(GetDatabaseSuccessState());
    }).catchError((error) {
      emit(GetDatabaseErrorState());
    });
  }
}
