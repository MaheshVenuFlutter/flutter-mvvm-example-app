import 'package:flutter/material.dart';
import 'package:mvvm_example/utils/routes/routes_names.dart';
import 'package:mvvm_example/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Home Screen"),),  body: Center(child: InkWell(
        onTap: (){
            // Navigator.pushNamed(context, RouteNames.loginScreen);
           Utils.toastMessage("taped on click here");
        },
        child: Text("click here ",style: TextStyle(color: Colors.red),)),),);
  }
}