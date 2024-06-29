import 'package:cvscreen/models/user/user.dart';
import 'package:cvscreen/shared/components/components.dart';
import 'package:cvscreen/shared/network/local/cache_helper.dart';
import 'package:cvscreen/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this.dioHelper) : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);
  final DioHelper dioHelper;
  Future<void> loginForUser(
      String? email, String? password, String userId, context) async {
    emit(AuthLoadingLoginState());
    await dioHelper.getUser(userId).then((value) {
      print(value['email']);
      print(value['password']);
      if (email == value['email'] && password == value['password']) {
        emit(AuthSuccessLoginState());
      } else if (email != value['email']) {
        showToast(text: 'Email not found', state: ToastStates.warning);
      } else if (password != value['password']) {
        showToast(text: 'Wrong password', state: ToastStates.warning);
      }
    }).catchError((error) {
      emit(AuthFailureLoginState());
    });
  }

  Future<void> registerForUser(User model) async {
    emit(AuthLoadingRegisterState());
    await dioHelper.addUser(model).then((value) {
      model.id = value['id'];
      CacheHelper.sharedPreferences?.setString("token", value['id'].toString());
      print("idUser: ${model.id = value['id']}");
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
