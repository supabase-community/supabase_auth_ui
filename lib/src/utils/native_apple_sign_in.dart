import 'package:sign_in_with_apple/sign_in_with_apple.dart';

typedef AppleCredential = ({
  String? identityToken,
  String? givenName,
  String? familyName,
});

Future<AppleCredential> getNativeAppleCredential({
  required String nonce,
}) async {
  final credential = await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
    nonce: nonce,
  );
  return (
    identityToken: credential.identityToken,
    givenName: credential.givenName,
    familyName: credential.familyName,
  );
}

bool isNativeAppleSignInCanceled(Object error) =>
    error is SignInWithAppleAuthorizationException &&
    error.code == AuthorizationErrorCode.canceled;
