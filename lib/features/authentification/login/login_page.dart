import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../common/background.dart';
import '../../../common/button.dart';
import '../../../common/colors/app_color.dart';
import '../../../common/constants/constant.dart';
import '../../../common/singleton/user_singleton.dart';
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

  final _idStudent = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      controller: _idStudent,
      autofocus: false,
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: StringManager.idStudent,
        hintStyle: const TextStyle(color: AppColors.blueLight),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
      ),
    );

    final passwordField = TextFormField(
      obscureText: _obscureText,
      controller: _password,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return StringManager.requiredTyping;
        }
        if (value.trim().length < 8) {
          return StringManager.atLeastPassword;
        }
        // Return null if the entered password is valid
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: StringManager.password,
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
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );

    final loginEmailPasswordButon = CustomButton(
      buttonLabel: StringManager.login,
      color: AppColors.blueLight,
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          final QuerySnapshot snap = await FirebaseFirestore.instance
              .collection('User')
              .where('idStudent', isEqualTo: _idStudent.text)
              .get();
          if (snap.docs[0]['email'] != null) {
            final dynamic result = await _auth.signInEmailPassword(
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
            UserInfoManager.ins.idStudent = _idStudent.text;
            await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MainTabBar(),
              ),
            );
          } else {
            await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text('Tài khoản sai!!!'),
                );
              },
            );
            return;
          }
        }
      },
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
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
                                size: 30,
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
                        StringManager.login,
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
                      // txtbutton,
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
      ),
    );
  }

  Widget _buildHeight(double height) => SizedBox(
        height: height,
      );
}
