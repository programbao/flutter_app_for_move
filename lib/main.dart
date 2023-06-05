import 'package:flutter/material.dart';
import 'routers/router.dart';
// 引入provider
import 'package:provider/provider.dart';
import 'provider/Counter.dart';

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
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => Counter())],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: const ColorScheme(
                  primary: Colors.white, //上方标题栏颜色
                  // primaryVariant: Colors.white,
                  secondary: Color.fromRGBO(31, 117, 236, 0.5),
                  background: Colors.white,
                  error: Colors.red,
                  brightness: Brightness.light,
                  onBackground: Colors.white,
                  // secondaryVariant: Colors.white,
                  onError: Colors.yellow,
                  onPrimary: Colors.black, //字体颜色
                  onSecondary: Color.fromRGBO(31, 117, 236, 0.8),
                  onSurface: Color.fromRGBO(31, 117, 236, 0.5),
                  surface: Color.fromRGBO(31, 117, 236, 0.5)
                  // all fields should have a value
                  )),
          initialRoute: '/',
          onGenerateRoute: onGenerateRoute,
        ));
  }
}
