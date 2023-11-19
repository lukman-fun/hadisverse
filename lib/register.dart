import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
              decoration: InputDecoration(
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
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.green),
                hintText: 'user123',
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
            onPressed: () {},
            child: const Text("Register"),
          )
        ],
      ),
    );
  }
}
