import 'package:cvscreen/modules/auth/cubit/auth_cubit.dart';
import 'package:cvscreen/modules/splash/splash_screen.dart';
import 'package:cvscreen/shared/cubit/shop_cubit.dart';
import 'package:cvscreen/shared/network/local/cache_helper.dart';
import 'package:cvscreen/shared/network/remote/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit(DioHelper(Dio()))..fetchProducts(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(DioHelper(Dio())),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
