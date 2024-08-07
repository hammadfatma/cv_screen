import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cvscreen/layouts/home_screen.dart';
import 'package:cvscreen/modules/auth/cubit/auth_cubit.dart';
import 'package:cvscreen/modules/auth/register_screen.dart';
import 'package:cvscreen/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthSuccessLoginState) {
          showToast(text: 'Successfuly, logined', state: ToastStates.success);
          navigateTo(context, const HomeScreen());
        }
        if (state is AuthFailureLoginState ||
            state is AuthUnauthorizedLoginState) {
          showToast(
              text: 'Failed, unauthorized user', state: ToastStates.error);
        }
      },
      builder: (context, state) {
        final authCubit = AuthCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: Colors.black),
                      ),
                      Text(
                        'Login now to our shop',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your user name';
                          }
                          return null;
                        },
                        label: 'User Name',
                        prefix: Icons.person,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'password is too short';
                          }
                          return null;
                        },
                        isPassword: AuthCubit.get(context).isPassword,
                        suffixPressed: () {
                          AuthCubit.get(context).changePasswordVisibility();
                        },
                        label: 'Password',
                        prefix: Icons.lock_outlined,
                        suffix: AuthCubit.get(context).suffix,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! AuthLoadingLoginState,
                        builder: (context) {
                          return defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                authCubit.loginForUser(
                                  nameController.text,
                                  passwordController.text,
                                );
                              }
                            },
                            text: 'login',
                            isUpperCase: true,
                          );
                        },
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                          TextButton(
                            onPressed: () {
                              navigateTo(context, const RegisterScreen());
                            },
                            child: const Text('register'),
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
    );
  }
}
