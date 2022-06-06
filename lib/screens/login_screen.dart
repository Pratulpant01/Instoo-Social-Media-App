import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instoo/resources/auth_methods.dart';
import 'package:instoo/responsive/mobile_screen_layout.dart';
import 'package:instoo/screens/signup_screen.dart';
import 'package:instoo/utils/colors.dart';
import 'package:instoo/utils/utils.dart';
import 'package:instoo/widgets/text_field.dart';

import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String result = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (result == 'success') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      showSnackBar(
        result,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 32,
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),
            Hero(
              tag: 1,
              child: SvgPicture.asset(
                'assets/instoo logo.svg',
                height: 64,
                color: primaryColor,
              ),
            ),
            SizedBox(
              height: 64,
            ),
            TextFieldInput(
              textEditingController: _emailController,
              hintText: "Enter your email",
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 24,
            ),
            TextFieldInput(
              textEditingController: _passwordController,
              hintText: "Enter your password",
              textInputType: TextInputType.text,
              isPass: true,
            ),
            SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: loginUser,
              child: Container(
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: textPrimaryColor,
                        ),
                      )
                    : Text(
                        'Log in',
                        style: TextStyle(
                            color: textPrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                ),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text('Don\'t have an account?'),
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupScreen(),
                      ),
                    );
                  },
                  child: Container(
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
