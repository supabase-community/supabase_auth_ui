import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import '../test_utils.dart';

void main() {
  setUpAll(initializeSupabaseForTest);
  setUp(() => testServer.reset());

  testWidgets('shows an ErrorWidget when the provider list is empty', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrapForTest(
        SupaSocialsAuth(socialProviders: const [], onSuccess: (_) {}),
      ),
    );

    expect(find.byType(ErrorWidget), findsOneWidget);
  });

  testWidgets('renders a labelled button per provider in iconAndText mode', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrapForTest(
        SupaSocialsAuth(
          socialProviders: const [
            OAuthProvider.github,
            OAuthProvider.google,
          ],
          onSuccess: (_) {},
        ),
      ),
    );

    expect(find.text('Continue with Github'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);
    // `ElevatedButton.icon` returns an `ElevatedButton` subclass on some
    // Flutter versions, which `find.byType` would miss, so match by predicate.
    expect(
      find.byWidgetPredicate((widget) => widget is ElevatedButton),
      findsNWidgets(2),
    );
  });

  testWidgets('uses 16 logical pixels of spacing by default', (tester) async {
    await tester.pumpWidget(
      wrapForTest(
        SupaSocialsAuth(
          socialProviders: const [
            OAuthProvider.github,
            OAuthProvider.google,
          ],
          onSuccess: (_) {},
        ),
      ),
    );

    final column = tester.widget<Column>(
      find.descendant(
        of: find.byType(SupaSocialsAuth),
        matching: find.byType(Column),
      ),
    );

    expect(column.spacing, 16.0);
  });

  testWidgets('applies custom spacing in iconAndText mode', (tester) async {
    await tester.pumpWidget(
      wrapForTest(
        SupaSocialsAuth(
          socialProviders: const [
            OAuthProvider.github,
            OAuthProvider.google,
          ],
          spacing: 24,
          onSuccess: (_) {},
        ),
      ),
    );

    final column = tester.widget<Column>(
      find.descendant(
        of: find.byType(SupaSocialsAuth),
        matching: find.byType(Column),
      ),
    );

    expect(column.spacing, 24.0);
  });

  testWidgets('renders icon-only buttons without labels in icon mode', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrapForTest(
        SupaSocialsAuth(
          socialProviders: const [OAuthProvider.github],
          socialButtonVariant: SocialButtonVariant.icon,
          onSuccess: (_) {},
        ),
      ),
    );

    expect(find.text('Continue with Github'), findsNothing);
    expect(
      find.byWidgetPredicate((widget) => widget is ElevatedButton),
      findsNothing,
    );
    expect(find.byType(InkResponse), findsOneWidget);
  });

  testWidgets('applies custom spacing in icon mode', (tester) async {
    await tester.pumpWidget(
      wrapForTest(
        SupaSocialsAuth(
          socialProviders: const [
            OAuthProvider.github,
            OAuthProvider.google,
          ],
          socialButtonVariant: SocialButtonVariant.icon,
          spacing: 24,
          onSuccess: (_) {},
        ),
      ),
    );

    final wrap = tester.widget<Wrap>(
      find.descendant(
        of: find.byType(SupaSocialsAuth),
        matching: find.byType(Wrap),
      ),
    );

    expect(wrap.spacing, 24.0);
    expect(wrap.runSpacing, 24.0);
  });

  testWidgets('uses a custom label from oAuthButtonLabels when provided', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrapForTest(
        SupaSocialsAuth(
          socialProviders: const [OAuthProvider.azure],
          oAuthButtonLabels: {OAuthProvider.azure: 'Microsoft (Azure)'},
          onSuccess: (_) {},
        ),
      ),
    );

    expect(find.text('Microsoft (Azure)'), findsOneWidget);
  });
}
