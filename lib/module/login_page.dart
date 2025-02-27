import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_route_animator/page_route_animator.dart';
import 'package:primajasa/component/costum_button.dart';
import 'package:primajasa/component/costum_text_input.dart';
import 'package:primajasa/controller/auth.dart';
import 'package:primajasa/module/home_page.dart';
import 'package:primajasa/module/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        minimum: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.2,
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1,
                ),
                child: Column(
                  children: [
                    Text(
                      'Hello Again!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Welcome Back, Please Login to continue',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.05,
                      ),
                      child: CostumTextInput(
                        controller: usernameController,
                        hintText: 'Username',
                        keyboardType: TextInputType.text,
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
                    ButtonInput(
                      onPressed: () {
                        login(usernameController.text, passwordController.text).then((v) {
                          if (v == 200) {
                            Navigator.of(context).push(
                              PageRouteAnimator(
                                child: const HomePage(),
                                routeAnimation: RouteAnimation.bottomLeftToTopRight,
                              ),
                            );
                          }
                        });
                      },
                      text: 'Sign In',
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                ),
                child: Text.rich(
                  TextSpan(
                    text: 'Don\'t have an account? ',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sign Up',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(
                              PageRouteAnimator(
                                child: const RegisterPage(),
                                routeAnimation: RouteAnimation.leftToRight,
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
