import 'package:flutter/material.dart';
import 'package:hadisverse/login.dart';
import 'package:hadisverse/models/user_model.dart';
import 'package:hadisverse/register.dart';
import 'package:hadisverse/utils/session.dart';
import 'package:http/http.dart' as http;

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: const [
              const TabBar(
                labelColor: Colors.green,
                indicatorColor: Colors.green,
                unselectedLabelColor: Colors.black,
                tabs: [Tab(text: 'Login'), Tab(text: 'Register')],
              ),
              Expanded(
                child: TabBarView(
                  children: [LoginPage(), RegisterPage()],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
