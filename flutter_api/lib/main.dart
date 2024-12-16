import 'package:flutter/material.dart';
import 'package:flutter_api/view/view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Datos API',
      theme: ThemeData(primarySwatch: Colors.blue),
      home:
          UserListScreen(),
    );
  }
}
