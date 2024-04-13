import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

  void handleLogin() {
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
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              
            ),
            SvgPicture.network("https://www.ollyolly.com/wp-content/themes/olly-olly/resources/images/logo.svg",
             width: 80,
             height: 80),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 400,
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
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
                          border: OutlineInputBorder()),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 400,
                    child: ElevatedButton(
                      onPressed: handleLogin,
                      child: const Text('Login',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
