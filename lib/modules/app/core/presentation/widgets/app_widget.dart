import 'package:flutter/material.dart';
import 'package:pokemon_app/modules/app/core/presentation/config/theme/theme.dart';
import 'package:pokemon_app/modules/app/core/presentation/pages/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.buildTheme(),
      title: 'Pokemon App',
      home: AppSplashPage(),
    );
  }
}
