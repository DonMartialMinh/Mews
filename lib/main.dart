import 'package:flutter/material.dart';
import 'package:mews/main_page.dart';
import 'package:mews/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'NunitoSans'),
      onGenerateRoute: Routes.generateRoute,
      home: const MainPage(),
    );
  }
}
