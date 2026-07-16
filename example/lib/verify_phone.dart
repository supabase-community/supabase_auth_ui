import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import 'constants.dart';

class VerifyPhone extends StatelessWidget {
  const VerifyPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Verify Phone'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            SupaVerifyPhone(
              onSuccess: (response) {
                unawaited(Navigator.of(context).pushReplacementNamed('/home'));
              },
            ),
            TextButton(
              child: const Text(
                'Take me back to Sign Up',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                unawaited(Navigator.pushNamed(context, '/'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
