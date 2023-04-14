import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../common/colors/app_color.dart';
import '../../../common/common.dart';
import '../../../models/loginuser.dart';
import '../../../services/auth_services.dart';
import '../../main_tab_bar/main_tab_bar.dart';
import '../login/login_page.dart';

class Register extends StatefulWidget {
  final Function? toggleView;
  const Register({Key? key, this.toggleView}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Register();
  }
}

class _Register extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final _email = TextEditingController();
  final _idStudent = TextEditingController();

  final _password = TextEditingController();
  final _passwordagain = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      controller: _email,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Yêu cầu nhập';
        }
        if (value != null) {
          if (value.contains('@') && value.endsWith('.com')) {
            return null;
          }
          return 'Nhập 1 email đúng kiểu';
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
    final idStudentField = TextFormField(
      controller: _idStudent,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Yêu cầu nhập';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Mã số sinh viên',
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
          return 'Yêu cầu nhập';
        }
        if (value.trim().length < 8) {
          return 'Password yêu cầu phải có 8 ký tự';
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final passwordgainField = TextFormField(
      obscureText: _obscureText,
      controller: _passwordagain,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Yêu cầu nhập';
        }
        if (value.trim().length < 8) {
          return 'Password yêu cầu phải có 8 ký tự';
        }
        if (value != _password.text) {
          return 'Passwords không giống nhau!!!';
        }
        // Return null if the entered password is valid
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Nhập lại Password",
        hintStyle: const TextStyle(color: AppColors.blueLight),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final registerButton = CustomButton(
      buttonLabel: 'Đăng ký',
      color: AppColors.blueLight,
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          dynamic result = await _auth.registerEmailPassword(
            LoginUser(email: _email.text, password: _password.text),
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
            // final user = FirebaseAuth.instance.currentUser;
            // await user?.sendEmailVerification();
            return;
          }
          final documentReference =
              FirebaseFirestore.instance.collection('User').doc(
                    _email.text,
                  );
          final add = <String, dynamic>{
            'name': '',
            'birthDate': Timestamp.fromDate(DateTime.now()),
            'class': '',
            'level': '',
            'field': '',
            'major': '',
            'email': _email.text,
            'idStudent': _idStudent.text,
            'role': 'user',
            'newsCollection': ['1111']
          };
          await documentReference.set(add).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tạo tài khoản thành công'),
              ),
            );
          });
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainTabBar(),
            ),
          );
        }
        ;
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
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Trang đăng ký',
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 30,
                                color: AppColors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      LottieBuilder.asset(
                        'assets/lottie/sign_up.json',
                        width: 400,
                      ),
                      _buildHeight(10),
                      emailField,
                      _buildHeight(30),
                      idStudentField,
                      _buildHeight(30),
                      passwordField,
                      _buildHeight(30),
                      passwordgainField,
                      _buildHeight(30),
                      registerButton,
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
