import 'package:flutter/material.dart';
import 'package:hadisverse/models/jwt_model.dart';
import 'package:hadisverse/utils/session.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool isPasswordShow = false;

  Future<void> login(BuildContext context) async {
    final response = await http.post(
      Uri.parse(
          'https://hadisverse.rushd.id/?rest_route=/simple-jwt-login/v1/auth'),
      body: {
        'email': _email.value.text,
        'password': _password.value.text,
      },
    );
    if (response.statusCode == 200) {
      // Session().save(jwtFromJson(response.body.toString()));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Akun anda salah'),
        ),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.only(left: 16, right: 0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 235, 235, 235), // Background putih
              borderRadius: BorderRadius.circular(8.0), // Sudut 8
            ),
            child: TextFormField(
              cursorColor: Colors.grey,
              controller: _email,
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.green),
                hintText: 'user@example.com',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            padding: EdgeInsets.only(left: 16, right: 0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 235, 235, 235), // Background putih
              borderRadius: BorderRadius.circular(8.0), // Sudut 8
            ),
            child: TextFormField(
              cursorColor: Colors.grey,
              controller: _password,
              obscureText: !isPasswordShow,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.green),
                hintText: 'user123',
                suffixIcon: isPasswordShow
                    ? IconButton(
                        icon: Icon(
                          Icons.visibility,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordShow = !isPasswordShow;
                          });
                        },
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordShow = !isPasswordShow;
                          });
                        },
                        icon: Icon(
                          Icons.visibility_off,
                          color: Colors.green,
                        ),
                      ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              fixedSize: Size(
                MediaQuery.of(context).size.width,
                50,
              ),
            ),
            onPressed: () {
              login(context);
            },
            child: const Text("Login"),
          )
        ],
      ),
    );
  }
}
