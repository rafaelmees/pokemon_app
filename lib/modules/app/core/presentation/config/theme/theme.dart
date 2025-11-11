import 'package:flutter/material.dart';
import 'package:pokemon_app/modules/app/core/presentation/config/constants.dart';

part 'color.dart';
part 'text.dart';

class AppTheme {
  static ThemeData buildTheme() {
    ColorScheme colorScheme = _AppColor.colorScheme;
    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      dialogTheme: const DialogThemeData(
        shape: AppConstants.dialogShape,
        elevation: 3,
      ),
      cardTheme: const CardThemeData(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            AppConstants.cardBorderRadius,
          ),
        ),
      ),
      dataTableTheme: const DataTableThemeData(
        columnSpacing: AppConstants.spacing3,
      ),
      dividerTheme: const DividerThemeData(
        space: 0.0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
      ),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.macOS: _FadePageTransitionsBuilder(),
          TargetPlatform.windows: _FadePageTransitionsBuilder(),
          TargetPlatform.linux: _FadePageTransitionsBuilder(),
          TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
        },
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      textTheme: _AppText.textTheme,
    );
  }

  static ColorScheme colors = _AppColor.colorScheme;

  static Color colorForType(String type) {
    return _AppColor.colorsByTypes[type.toLowerCase()] ?? Colors.grey;
  }

  static TextTheme text = _AppText.textTheme;
}

class _FadePageTransitionsBuilder extends PageTransitionsBuilder {
  _FadePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T>? route,
    BuildContext? context,
    Animation<double> animation,
    Animation<double>? secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
