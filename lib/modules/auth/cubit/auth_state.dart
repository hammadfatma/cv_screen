part of 'auth_cubit.dart';

@immutable
abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthChangePasswordVisibilityState extends AuthStates {}

class AuthLoadingLoginState extends AuthStates {}

class AuthSuccessLoginState extends AuthStates {}

class AuthFailureLoginState extends AuthStates {}

class AuthLoadingRegisterState extends AuthStates {}

class AuthSuccessRegisterState extends AuthStates {}

class AuthFailureRegisterState extends AuthStates {}
