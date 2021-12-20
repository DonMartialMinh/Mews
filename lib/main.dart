import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mews/Pages/HomePage/home_page.dart';
import 'package:mews/main_page.dart';
import 'package:mews/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  await Firebase.initializeApp();
  runApp(MyApp(email: email));
}

class MyApp extends StatelessWidget {
  String? email;
  MyApp({Key? key, this.email}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'NunitoSans'),
      onGenerateRoute: Routes.generateRoute,
      home: email == null ? const MainPage() : HomePage(),
    );
  }
}
