import 'package:flutter/material.dart';
import 'routers/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: const ColorScheme(
              primary: Colors.white, //上方标题栏颜色
              // primaryVariant: Colors.white,
              secondary: Colors.green,
              background: Colors.white,
              error: Colors.red,
              brightness: Brightness.light,
              onBackground: Colors.white,
              // secondaryVariant: Colors.white,
              onError: Colors.yellow,
              onPrimary: Colors.black, //字体颜色
              onSecondary: Colors.redAccent,
              onSurface: Colors.redAccent,
              surface: Colors.redAccent
              // all fields should have a value
              )),
      initialRoute: '/productList',
      onGenerateRoute: onGenerateRoute,
    );
  }
}
