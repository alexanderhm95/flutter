import 'package:flutter/material.dart';
import 'package:hola_mundo/Pages/loginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: loginPage.id,
      routes: {
        loginPage.id: (context) => loginPage(),
      },
    );
  }
}
