import 'package:flutter/material.dart';
import 'package:mvvm_example/res/components/round_butten.dart'; // Make sure this points to PrimaryButton file
import 'package:mvvm_example/utils/routes/routes_names.dart';
import 'package:mvvm_example/utils/utils.dart';
import 'package:mvvm_example/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Screen")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("Menu",
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Consumer<UserViewModel>(
                    builder: (context, provide, widget) {
                  return PrimaryButton(
                      title: "Logout",
                      loading: provide.logOutLoader,
                      onPressed: () async {
                        provide.removeUsr(navigateTo: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouteNames.loginScreen,
                            (route) => false,
                          );
                          Utils.showSnackBar(
                              "Loged 0ut successfully..", context);
                        });
                      });
                })),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          "Welcome to the Home Screen!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
