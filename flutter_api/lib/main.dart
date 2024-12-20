import 'package:flutter/material.dart';
import 'package:flutter_api/view/welcomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Datos API',
      theme: ThemeData(primarySwatch: Colors.blue),
      home:
          const PantallaLogin(),
    );
  }
}
