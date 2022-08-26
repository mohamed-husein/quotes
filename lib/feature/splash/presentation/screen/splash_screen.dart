import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quotes/config/routes/app_routes.dart';
import 'package:quotes/core/utils/assets_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final Timer timer;

  _setSplash() {
    timer = Timer(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacementNamed(context, Routes.quoteScreen);
    });
  }

  @override
  void initState() {
    _setSplash();
    super.initState();
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(),
      body: Center(child: Image.asset(ImgAssets.quote)),
    );
  }
}
