import 'package:flutter/material.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/core/utils/media_query_values.dart';

class ErrorScreen extends StatelessWidget {
   const ErrorScreen({Key? key, this.onPressed}) : super(key: key);
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Icon(
              Icons.warning_amber,
              color: AppColors.mainColor,
              size: 150,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(AppStrings.somethingWrong,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 25, fontWeight: FontWeight.w700)),
          const SizedBox(
            height: 15,
          ),
          Text(
            AppStrings.tryAgain,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: context.width * 0.55,
            height: 50,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                primary: AppColors.mainColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
              ),
              child:  const Text(AppStrings.reload),
              
            ),
          )
        ],
      )
    ;
  }
}
