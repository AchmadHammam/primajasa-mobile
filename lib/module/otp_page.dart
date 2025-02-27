import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_route_animator/page_route_animator.dart';
import 'package:primajasa/component/costum_button.dart';
import 'package:primajasa/controller/otp.dart';
import 'package:primajasa/module/login_page.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({
    super.key,
    required this.noHandphone,
    required this.verifyId,
  });
  final String noHandphone;
  final String verifyId;
  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  String _getOtp() {
    String otp = '';
    for (TextEditingController controller in _otpControllers) {
      otp += controller.text;
    }
    return otp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.1,
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'We have sent an OTP SMS to number\n${widget.noHandphone}',
              textAlign: TextAlign.center,
            ),
            GridView.builder(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.1,
              ),
              itemCount: 6,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 25,
                crossAxisSpacing: 25,
                crossAxisCount: 6,
              ),
              itemBuilder: (context, index) {
                return TextFormField(
                  controller: _otpControllers[index],
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      FocusScope.of(context).previousFocus();
                    } else if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                        width: 2.0,
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                );
              },
            ),
            ButtonInput(
              onPressed: () {
                verifyOtp(
                        otp: _getOtp(), phone: widget.noHandphone, verificationId: widget.verifyId)
                    .then((_) {
                  Navigator.push(
                    context,
                    PageRouteAnimator(
                      child: LoginPage(),
                      routeAnimation: RouteAnimation.leftToRight,
                    ),
                  );
                });
              },
              text: 'Submit',
            )
          ],
        ),
      ),
  
    );
  }
}
