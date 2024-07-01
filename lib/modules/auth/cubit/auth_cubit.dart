import 'package:cvscreen/models/user/user.dart';
import 'package:cvscreen/shared/network/local/cache_helper.dart';
import 'package:cvscreen/shared/network/remote/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this.dioHelper) : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);
  final DioHelper dioHelper;
  Future<void> loginForUser(String userName, String password) async {
    try {
      emit(AuthLoadingLoginState());
      await dioHelper.loginUser(userName, password).then((value) async {
        if (value != null) {
          await CacheHelper.sharedPreferences?.setString("userName", userName);
          emit(AuthSuccessLoginState());
        } else {
          emit(AuthFailureLoginState());
        }
      });
    } on DioException catch (e) {
      if (e.response != null && e.response?.statusCode == 401) {
        emit(AuthUnauthorizedLoginState());
      } else {
        emit(AuthErrorLoginState(e.toString()));
      }
    }
  }

  Future<void> registerForUser(User model) async {
    emit(AuthLoadingRegisterState());
    await dioHelper.addUser(model).then((value) {
      emit(AuthSuccessRegisterState());
    }).catchError((error) {
      emit(AuthFailureRegisterState());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AuthChangePasswordVisibilityState());
  }
}
