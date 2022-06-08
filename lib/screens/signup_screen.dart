import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instoo/resources/auth_methods.dart';
import 'package:instoo/utils/colors.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';
import '../widgets/text_field.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _profileImage;
  AssetImage defaultProfile = AssetImage('assets/defaultUserimage.png');
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _profileImage = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _profileImage!,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
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
              height: 32,
            ),
            // Circle Avatar to accept and show our profile photo
            Stack(
              children: [
                _profileImage != null
                    ? CircleAvatar(
                        backgroundColor: textPrimaryColor,
                        radius: 64,
                        backgroundImage: MemoryImage(_profileImage!),
                      )
                    : CircleAvatar(
                        backgroundColor: textPrimaryColor,
                        radius: 64,
                        backgroundImage: defaultProfile,
                      ),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: Icon(
                        Icons.add_a_photo,
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 24,
            ),
            TextFieldInput(
              textEditingController: _usernameController,
              hintText: "Enter your username",
              textInputType: TextInputType.text,
            ),
            SizedBox(
              height: 24,
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
            TextFieldInput(
              textEditingController: _bioController,
              hintText: "Enter your bio ",
              textInputType: TextInputType.text,
            ),
            SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: signUpUser,
              child: Container(
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: textPrimaryColor,
                        ),
                      )
                    : Text(
                        'Sign up',
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
                  child: Text('Already have an account?'),
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Text(
                      'Log in',
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
