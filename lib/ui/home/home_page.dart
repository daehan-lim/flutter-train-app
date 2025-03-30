import 'package:flutter/material.dart';
import 'package:flutter_train_app/app/app_theme.dart';
import 'package:flutter_train_app/app/constants/app_strings.dart';

import '../../app/constants/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppTheme.isDark(context)
              ? AppColors.darkBackground
              : AppColors.greyBackground,
      appBar: AppBar(title: Text(AppStrings.homeTitle)),
      body: Column(),
    );
  }
}
