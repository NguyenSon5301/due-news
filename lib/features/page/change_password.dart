import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common/common.dart';
import '../../common/constants/constant.dart';
import '../../models/firebaseuser.dart';
import '../../services/auth_services.dart';
import '../utils/utils.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _obscureTextOldPass = true;
  bool _obscureTextNewPass = true;
  bool _obscureTextAgainPass = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _oldPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _againNewPassword = TextEditingController();
  FocusNode myfocus = FocusNode();
  final AuthService _auth = AuthService();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () {
      myfocus.requestFocus(); //auto focus on second text field.
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blueLight,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.white,
              size: 30,
            ),
          ),
          title: _header(),
        ),
        backgroundColor: AppColors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      focusNode: myfocus,
                      obscureText: _obscureTextOldPass,
                      controller: _oldPassword,
                      autofocus: false,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return StringManager.requiredTyping;
                        }
                        if (value.trim().length < 8) {
                          return StringManager.atLeastPassword;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: StringManager.oldPassword,
                        hintStyle: const TextStyle(color: AppColors.blueLight),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureTextOldPass
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureTextOldPass = !_obscureTextOldPass;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                    ),
                    _sizedBox(30),
                    TextFormField(
                      obscureText: _obscureTextNewPass,
                      controller: _newPassword,
                      autofocus: false,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return StringManager.requiredTyping;
                        }
                        if (value.trim().length < 8) {
                          return StringManager.atLeastPassword;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: StringManager.newPassword,
                        hintStyle: const TextStyle(color: AppColors.blueLight),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureTextNewPass
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureTextNewPass = !_obscureTextNewPass;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                    ),
                    _sizedBox(30),
                    TextFormField(
                      obscureText: _obscureTextAgainPass,
                      controller: _againNewPassword,
                      autofocus: false,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return StringManager.requiredTyping;
                        }
                        if (value.trim().length < 8) {
                          return StringManager.atLeastPassword;
                        }
                        if (value.trim() != _newPassword.text.trim()) {
                          return StringManager.typingPasswordAgainWrong;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: StringManager.againNewPassword,
                        hintStyle: const TextStyle(color: AppColors.blueLight),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureTextAgainPass
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureTextAgainPass = !_obscureTextAgainPass;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                    ),
                    _sizedBox(30),
                    CustomButton(
                      buttonLabel: StringManager.changePassword,
                      color: AppColors.blueLight,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await {
                            _auth
                                .checkPassword(_oldPassword.text)
                                .then((value) {
                              if (value) {
                                _auth.changePassword(_newPassword.text);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: AppColors.transparent,
                                    elevation: 0,
                                    content: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: AppColors.green,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                        child: const Text(
                                          'Đổi mật khẩu thành công',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                                _oldPassword.text = '';
                                _newPassword.text = '';
                                _againNewPassword.text = '';
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: AppColors.transparent,
                                    elevation: 0,
                                    content: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: AppColors.red,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                        child: const Text(
                                          'Mật khẩu củ không đúng',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            })
                          };
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sizedBox(double height) => SizedBox(
        height: height,
      );
  Widget _header() {
    return Column(
      children: [
        Text(
          StringManager.changePassword,
          textAlign: TextAlign.center,
          style: SafeGoogleFont(
            StringManager.mulish,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            height: 1.2,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
