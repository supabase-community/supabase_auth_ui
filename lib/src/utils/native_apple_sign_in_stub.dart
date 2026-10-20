typedef AppleCredential = ({
  String? identityToken,
  String? givenName,
  String? familyName,
});

Future<AppleCredential> getNativeAppleCredential({required String nonce}) =>
    throw UnsupportedError(
      'Native Apple sign in is not supported on this platform.',
    );

bool isNativeAppleSignInCanceled(Object error) => false;
