import 'package:flutter/material.dart';
import 'package:hadisverse/auth.dart';
import 'package:hadisverse/models/user_model.dart';
import 'package:hadisverse/utils/session.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;

  Future<void> isAuth() async {
    final jwt = await Session().get();
    if (jwt != null) {
      final response = await http.post(
        Uri.parse(
            'https://hadisverse.rushd.id/?rest_route=/simple-jwt-login/v1/auth/validate'),
        headers: {
          'Authorization': 'Bearer ${jwt.data.jwt}',
        },
      );
      print(response.body);
      // user =
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
    );
  }
}
