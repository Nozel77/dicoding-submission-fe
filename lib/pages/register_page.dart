import 'package:dicoding_submission/controllers/auth_controller.dart';
import 'package:dicoding_submission/routes/routes.dart';
import 'package:dicoding_submission/utils/themes.dart';
import 'package:dicoding_submission/widgets/common_button.dart';
import 'package:dicoding_submission/widgets/common_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = AuthController();

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    nameController.addListener(_validateForm);
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      isButtonEnabled = nameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty;
    });
  }

  Future<void> handleRegister() async {
    _showLoadingDialog();

    try {
      bool isSuccess = await authController.register(
        nameController.text,
        emailController.text,
        passwordController.text,
      );

      Navigator.pop(context);

      if (isSuccess) {
        Navigator.pushReplacementNamed(context, Routes.bottomNav);
      }
    } catch (e) {
      Navigator.pop(context);
      String errorMessage = 'Register failed: $e';

      if (e.toString().contains('Email')) {
        errorMessage = 'Email sudah terdaftar atau tidak valid.';
      } else if (e.toString().contains('Password')) {
        errorMessage = 'Password tidak valid. Harap periksa kembali.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
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
                Image.asset('assets/images/raiden_register.png', width: 300, height: 300),
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
                              'Belum Punya Akun?',
                              style: tsTitleRegularWhite,
                            ),
                            Text(
                              'Ayo buat akun pertamamu!',
                              style: tsSubtitleRegularWhite,
                            ),
                            SizedBox(height: 35),
                            CommonForm(
                              hintText: 'Name',
                              obscureText: false,
                              controller: nameController,
                              showVisibilityIcon: false,
                            ),
                            SizedBox(height: 20),
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
                                    text: 'Register',
                                    onPressed: isButtonEnabled
                                        ? handleRegister
                                        : null, // Disable button if form is not valid
                                  ),
                                  SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Sudah punya akun?',
                                        style: tsTextRegularWhite,
                                      ),
                                      SizedBox(width: 5),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushReplacementNamed(context, Routes.login);
                                        },
                                        child: Text(
                                          'Login',
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
