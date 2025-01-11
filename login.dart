import 'package:flutter/material.dart';
import 'package:projectmap/screens/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  void summitLogin() {
    print(email.text);
    print(password.text);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Danny")),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: Column(
            children: [
              TextFormField(
                controller: email,
                decoration: const InputDecoration(labelText: 'E-mail'),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                    return "กรอก E-mail ให้ถูกต้อง";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                  controller: password,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return "กรอกตัวเลข 10 หลัก";
                    } else {
                      return null;
                    }
                  }),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () => {summitLogin()}, child: Text("LOGIN"))
            ],
          )),
    );
  }
}
