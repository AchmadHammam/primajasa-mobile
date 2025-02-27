import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_route_animator/page_route_animator.dart';
import 'package:primajasa/component/costum_button.dart';
import 'package:primajasa/component/costum_text_input.dart';
import 'package:primajasa/controller/auth.dart';
import 'package:primajasa/module/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfrimController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nohandphoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.1,
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.05,
                  ),
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.05,
                  ),
                  child: CostumTextInput(
                    controller: nameController,
                    hintText: 'Name',
                    keyboardType: TextInputType.name,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.05,
                  ),
                  child: CostumTextInput(
                    controller: usernameController,
                    hintText: 'Username',
                    keyboardType: TextInputType.name,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.05,
                  ),
                  child: CostumTextInput(
                    controller: passwordController,
                    hintText: 'Password',
                    keyboardType: TextInputType.text,
                    secureText: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.05,
                  ),
                  child: CostumTextInput(
                    controller: passwordConfrimController,
                    hintText: 'Confirm Password',
                    keyboardType: TextInputType.text,
                    secureText: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.05,
                  ),
                  child: CostumTextInput(
                    controller: emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.05,
                  ),
                  child: CostumTextInput(
                    controller: nohandphoneController,
                    hintText: 'No Handphone',
                    keyboardType: TextInputType.phone,
                  ),
                ),
                ButtonInput(
                  onPressed: () {
                    register(
                      usernameController.text,
                      passwordController.text,
                      passwordConfrimController.text,
                      emailController.text,
                      nameController.text,
                      nohandphoneController.text,
                    ).then((v) {
                      if (v == 200) {
                        Navigator.push(
                            context,
                            PageRouteAnimator(
                              child: const LoginPage(),
                              routeAnimation: RouteAnimation.leftToRight,
                            ));
                      }
                    });
                  },
                  text: 'Sign up',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
