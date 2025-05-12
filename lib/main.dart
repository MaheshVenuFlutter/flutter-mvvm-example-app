import 'package:flutter/material.dart';
import 'package:mvvm_example/utils/routes/routes.dart';
import 'package:mvvm_example/utils/routes/routes_names.dart';
import 'package:mvvm_example/view_model/aouth_view_model.dart';
import 'package:mvvm_example/view_model/sign_up_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AouthViewModel(),
        ),
        ChangeNotifierProvider(create: (context) => SignUpViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // Sets the first screen of the app
        initialRoute: RouteNames.loginScreen,

        // Handles route navigation based on route name
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
