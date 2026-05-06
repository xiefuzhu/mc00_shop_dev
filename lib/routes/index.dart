//管理路由
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:mc00_shop/pages/Login/index.dart';
import 'package:mc00_shop/pages/Main/index.dart';
import 'package:system_theme/system_theme.dart';

//返回app根级组件
class AppTheme {
  static late ColorScheme lightScheme;
  static late ColorScheme darkScheme;
}

Widget getRootWidge() {
  return DynamicColorBuilder(
    builder: (lightDynamic, darkDynamic) {
      final lightScheme =
          lightDynamic ??
          ColorScheme.fromSeed(
            seedColor: SystemTheme.accentColor.accent,
          ); //跟随系统强调色

      final darkScheme =
          darkDynamic ??
          ColorScheme.fromSeed(
            seedColor: SystemTheme.accentColor.accent,
            brightness: Brightness.dark,
          ); //深色模式与浅色模式定义

      return MaterialApp(
        theme: ThemeData(useMaterial3: true, colorScheme: lightScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkScheme),
        themeMode: ThemeMode.system, //深色浅色跟随系统
        initialRoute: "/",
        routes: getRootRoutes(),
      );
    },
  );
}

//返回该app的路由配置
Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {"/": (context) => MainPage(), "/login": (context) => LoginPage()};
}
