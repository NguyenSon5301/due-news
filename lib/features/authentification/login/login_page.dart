import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../common/background.dart';
import '../../../common/button.dart';
import '../../../common/colors/app_color.dart';
import '../../../models/loginuser.dart';
import '../../../services/auth_services.dart';
import '../../main_tab_bar/main_tab_bar.dart';
import '../sign_up/sign_up_page.dart';

class Login extends StatefulWidget {
  final Function? toggleView;
  const Login({Key? key, this.toggleView}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  bool _obscureText = true;

  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      controller: _email,
      autofocus: false,
      validator: (value) {
        if (value != null) {
          if (value.contains('@') && value.endsWith('.com')) {
            return null;
          }
          return 'Enter a Valid Email Address';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        hintStyle: const TextStyle(color: AppColors.blueLight),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final passwordField = TextFormField(
      obscureText: _obscureText,
      controller: _password,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        if (value.trim().length < 8) {
          return 'Password must be at least 8 characters in length';
        }
        // Return null if the entered password is valid
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        hintStyle: const TextStyle(color: AppColors.blueLight),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final txtbutton = TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Register()),
        );
      },
      child: const Text('New? Register here'),
    );

    final loginEmailPasswordButon = CustomButton(
        buttonLabel: 'Log in',
        color: AppColors.blueLight,
        onPressed: () async {
          QuerySnapshot snap = await FirebaseFirestore.instance
              .collection('User')
              .where('idStudent', isEqualTo: _email.text)
              .get();
          dynamic result = await _auth.signInEmailPassword(
            LoginUser(email: snap.docs[0]['email'], password: _password.text),
          );
          if (result.uid == null) {
            await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(result.code),
                );
              },
            );
            return;
          }
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainTabBar(),
            ),
          );
        });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 50,
                        bottom: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.blue,
                              size: 30.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    LottieBuilder.asset(
                      'assets/lottie/welcome_text.json',
                      width: 400,
                    ),
                    const Text(
                      'Log In Page',
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 40,
                        color: AppColors.blue,
                      ),
                    ),
                    _buildHeight(20),
                    emailField,
                    _buildHeight(30),
                    passwordField,
                    txtbutton,
                    _buildHeight(30),
                    loginEmailPasswordButon,
                    _buildHeight(300),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeight(double height) => SizedBox(
        height: height,
      );
}
