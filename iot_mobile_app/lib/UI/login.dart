import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iot_mobile_app/UI/content.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

late String email;
late String password;
TextEditingController emailTextEditingContoller = TextEditingController();
TextEditingController passwordTextEditingContoller = TextEditingController();

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 3.0, horizontal: 15.0),
                child: TextField(
                  decoration: InputDecoration(hintText: "Email"),
                  controller: emailTextEditingContoller,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 3.0, horizontal: 15.0),
                child: TextField(
                  decoration: InputDecoration(hintText: "Password"),
                  controller: passwordTextEditingContoller,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 30),
              MaterialButton(
                onPressed: () {
                  validateInput();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue,
                  ),
                  height: 50,
                  child: const Center(
                    child: Text(
                      "LOGIN",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  validateInput() {
    if (emailTextEditingContoller.text.isEmpty ||
        passwordTextEditingContoller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Input'),
        ),
      );
    } else {
      getData();
    }
  }

  getData() async {
    var url = Uri.parse(
        'https://iotattendancesystem.000webhostapp.com/api.php?APIkey=ndndjdvnvss84d5vdsaf5&email=$email&password=$password');
    var response = await http.post(url, body: {});

    print(response.statusCode);

    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body);
      print(data);
      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      if (response.body != '[]') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Content(data),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No Data'),
          ),
        );
      }
    } else if (response.statusCode == 403) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Email or Password'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No Data'),
        ),
      );
    }
  }

  changePage(data) {}
}
