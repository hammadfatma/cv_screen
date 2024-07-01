import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cvscreen/models/user/user.dart';
import 'package:cvscreen/modules/auth/cubit/auth_cubit.dart';
import 'package:cvscreen/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthSuccessRegisterState) {
          showToast(
              text: 'Successfuly, please go to login screen',
              state: ToastStates.success);
        }
        if (state is AuthFailureLoginState) {
          showToast(text: 'Failed, please try again', state: ToastStates.error);
        }
      },
      builder: (context, state) {
        final authCubit = AuthCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
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
                        'REGISTER',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: Colors.black),
                      ),
                      Text(
                        'Register now to our shop',
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
                            return 'please enter your name';
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
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
                          }
                          return null;
                        },
                        label: 'Email Address',
                        prefix: Icons.email_outlined,
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
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your phone number';
                          }
                          return null;
                        },
                        label: 'Phone',
                        prefix: Icons.phone,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! AuthLoadingRegisterState,
                        builder: (context) {
                          return defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                User userModel = User(
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  username: nameController.text,
                                );
                                authCubit.registerForUser(userModel);
                              }
                            },
                            text: 'register',
                            isUpperCase: true,
                          );
                        },
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
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
