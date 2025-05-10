import 'package:flutter/material.dart';
import 'package:mvvm_example/utils/routes/routes.dart';
import 'package:mvvm_example/utils/routes/routes_names.dart';
import 'package:mvvm_example/view/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
       // Sets the first screen of the app
      initialRoute: RouteNames.homeScreen,

      // Handles route navigation based on route name
      onGenerateRoute: Routes.generateRoute,);
  }
}



