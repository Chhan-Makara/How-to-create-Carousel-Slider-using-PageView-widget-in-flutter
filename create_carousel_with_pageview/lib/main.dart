import 'package:create_carousel_with_pageview/home_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeView(), debugShowCheckedModeBanner: false);
  }
}
