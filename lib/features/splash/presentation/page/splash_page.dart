import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:salons_app/router/name_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(
      const Duration(milliseconds: 500),
          () {
        FlutterNativeSplash.remove();
      },
    );
    Future.delayed(
      const Duration(milliseconds: 1500),
          () {
            Navigator.of(context).pushReplacementNamed(Routes.home);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
