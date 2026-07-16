import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import 'constants.dart';

class PhoneSignIn extends StatelessWidget {
  const PhoneSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Phone Sign In'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            SupaPhoneAuth(
              authAction: SupaAuthAction.signIn,
              onSuccess: (response) {
                unawaited(Navigator.of(context).pushReplacementNamed('/home'));
              },
            ),
            TextButton(
              child: const Text(
                'Don\'t have an account? Sign Up',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                unawaited(Navigator.pushNamed(context, '/phone_sign_up'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
