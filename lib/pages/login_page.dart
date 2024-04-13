import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final String companyName = "WeatherApp.io";

    void login() {
      //the user should not be able to return to the login screen after logging in
      Navigator.of(context).pushReplacementNamed('/home');
  }

  void validateLoginCredentials() {
    String email = emailController.text;
    String password = passwordController.text;

    if (email == "user@gmail.com" && password == "12345") {
      login();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Email or password is incorrect"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 231, 231),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Text(
                companyName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 400,
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: "The correct email is user@gmail.com",
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 400,
                    child: TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: "The correct password is 12345",
                          border: OutlineInputBorder()

                         ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 400,
                    child: ElevatedButton(
                      onPressed: validateLoginCredentials,
                      child: const Text('Login'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
