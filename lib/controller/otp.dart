import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_route_animator/page_route_animator.dart';
import 'package:primajasa/module/otp_page.dart';

Future<void> sendOtp(String phone, BuildContext context) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  print('a');

  await auth.verifyPhoneNumber(
    phoneNumber: phone,
    verificationCompleted: (PhoneAuthCredential credential) async {},
    verificationFailed: (FirebaseAuthException e) {},
    codeSent: (String verificationId, int? resendToken) {
      Navigator.of(context).push(
        PageRouteAnimator(
          child: OtpPage(
            noHandphone: phone,
            verifyId: verificationId,
          ),
          routeAnimation: RouteAnimation.leftToRight,
        ),
      );
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
    timeout: const Duration(seconds: 60),
    forceResendingToken: null,
  );
}

Future<void> verifyOtp({
  required String otp,
  required String phone,
  required String verificationId,
}) async {
  try {
    await FirebaseAuth.instance.signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      ),
    );
  } catch (e) {
    throw Exception(e);
  }
}
