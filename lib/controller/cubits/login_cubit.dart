import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:task/controller/cubits/layout_cubit.dart';
import 'package:task/controller/states/login_states.dart';
import 'package:task/models/user/user_model.dart';
import 'package:task/share/network/endpointer.dart';
import 'package:task/share/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialLoginStates());

  static LoginCubit get(context) => BlocProvider.of(context);
  late UserModel loginModel;
  String messageError = '';
  String messageSuccess = '';
  List<BiometricType> fingerPrintList = [];
  late final LocalAuthentication auth;

  void userLogin({
    required String user,
    required String pass,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LayoutCubit.baseUrl + Login,
      data: {
        "username": user,
        "password": pass,
        "deviceToken": '',
      },
    ).then((value) {
      if (value.data['status'] == -1) {
        messageError = value.data['message'];
        emit(LoginErrorState());
      } else {
        loginModel = UserModel.fromJson(value.data);
        messageSuccess = value.data['message'];
        emit(LoginSuccessState());
      }
    }).catchError((error) {
      emit(LoginErrorState());
    });
  }

  void initializeAuto(){
    auth = LocalAuthentication();
  }

  Future<void> getFingerPrint() async{
    emit(GetAvailableBiometricsLoading());
    fingerPrintList = [];

    auth.getAvailableBiometrics().then((value){
      fingerPrintList = value;
      emit(GetAvailableBiometricsSuccess());
    }).catchError((error){
      emit(GetAvailableBiometricsError());
    });
  }
}
