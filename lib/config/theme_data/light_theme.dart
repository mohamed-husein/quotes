import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/app_strings.dart';

ThemeData lightTheme(context) => ThemeData(
      primaryColor: AppColors.mainColor,
      fontFamily: AppStrings.fontFamily,
      appBarTheme: AppBarTheme(
        color: Colors.transparent,
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 25,fontWeight: FontWeight.w700),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      scaffoldBackgroundColor: AppColors.scaffoldGroundColor,
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color:Theme.of(context).scaffoldBackgroundColor,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        bodyText2: TextStyle(
          color:Colors.grey,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
        button: TextStyle(fontSize: 20)
      ),
    );
