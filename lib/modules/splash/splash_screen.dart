import 'package:cvscreen/layouts/home_screen.dart';
import 'package:cvscreen/modules/auth/login_screen.dart';
import 'package:cvscreen/modules/splash/sliding_text.dart';
import 'package:cvscreen/shared/components/components.dart';
import 'package:cvscreen/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;
  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    navigateToScreen();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.network('https://fakestoreapi.com/icons/intro.svg'),
          Positioned(
            bottom: 150.0,
            left: 0.0,
            right: 0.0,
            child: SlidingText(slidingAnimation: slidingAnimation),
          ),
        ],
      ),
    );
  }

  void navigateToScreen() {
    var userName = CacheHelper.sharedPreferences?.getString("userName");
    Future.delayed(const Duration(seconds: 2), () {
      if (userName == null || userName == 'null') {
        navigateAndFinish(context, const LoginScreen());
      } else {
        navigateAndFinish(context, const HomeScreen());
      }
    });
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    slidingAnimation =
        Tween<Offset>(begin: const Offset(2, 0), end: Offset.zero)
            .animate(animationController);
    animationController.forward();
  }
}
