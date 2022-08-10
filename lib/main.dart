import 'package:flutter/material.dart';
import 'package:greengrocer/src/router/route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: "home",
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
    );
  }
}
