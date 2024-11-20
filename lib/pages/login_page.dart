import 'package:dicoding_submission/routes/routes.dart';
import 'package:dicoding_submission/utils/themes.dart';
import 'package:dicoding_submission/widgets/common_button.dart';
import 'package:dicoding_submission/widgets/common_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = AuthController();
  bool isButtonEnabled = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      isButtonEnabled = emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    });
  }

  Future<void> handleLogin() async {
    _showLoadingDialog();

    try {
      bool isSuccess = await authController.login(
        emailController.text,
        passwordController.text,
      );

      Navigator.pop(context);

      if (isSuccess) {
        Navigator.pushReplacementNamed(context, Routes.bottomNav);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login gagal. Silakan cek kembali email dan password Anda.')),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      debugPrint('Error while logging in: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            color: bgButton,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Image.asset(
                  'assets/images/raiden_login.png',
                  width: 300,
                  height: 300,
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Halo Semua!',
                              style: tsTitleRegularWhite,
                            ),
                            Text(
                              'Login dulu yuk',
                              style: tsSubtitleRegularWhite,
                            ),
                            SizedBox(height: 35),
                            if (errorMessage != null)
                              Text(
                                errorMessage!,
                                style: TextStyle(color: Colors.red),
                              ),
                            SizedBox(height: 10),
                            CommonForm(
                              hintText: 'Email',
                              obscureText: false,
                              controller: emailController,
                              showVisibilityIcon: false,
                            ),
                            SizedBox(height: 20),
                            CommonForm(
                              hintText: 'Password',
                              obscureText: true,
                              controller: passwordController,
                            ),
                            SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CommonButton(
                                    text: 'Login',
                                    onPressed: isButtonEnabled
                                        ? () async {
                                      await handleLogin();
                                    }
                                        : null, // Disable button when not enabled
                                  ),
                                  SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Belum punya akun?',
                                        style: tsTextRegularWhite,
                                      ),
                                      SizedBox(width: 5),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushReplacementNamed(
                                              context, Routes.register);
                                        },
                                        child: Text(
                                          'Register',
                                          style: tsTextRegularPurple,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
}
