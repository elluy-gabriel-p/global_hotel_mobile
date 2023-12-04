import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugdlayout2/View/login.dart';
import 'package:ugdlayout2/View/widgetTesting/login.dart';

void main() {
  group("Login", () {
    testWidgets('Login Sukses', (tester) async {
      FlutterError.onError = (FlutterErrorDetails details) {
        bool ifIsOverflowError = false;

        // Detect overflow error.
        var exception = details.exception;
        if (exception is FlutterError) {
          ifIsOverflowError = !exception.diagnostics.any((e) =>
              e.value.toString().startsWith("A RenderFlex overflowed by"));
        }

        // Ignore if it's an overflow error.
        if (ifIsOverflowError) {
          print('Overflow error.');
        } else {
          // Throw other errors.
          FlutterError.dumpErrorToConsole(details);
        }
      };

      await tester.pumpWidget(MaterialApp(
        home: Login(),
      ));

      await tester.enterText(find.byKey(Key('userField')), '1');
      await tester.enterText(find.byKey(Key('passField')), '1');
      await tester.tap(find.byKey(Key('loginButton')));
      await tester.pumpAndSettle(Duration(seconds: 2));

      //  bool statusLogin =  await LoginState().loginTesting('2','2');
      // print(statusLogin);

      expect(find.text('Login Berhasil'), findsOneWidget);
      await tester.pumpAndSettle(Duration(seconds: 5));
    });

    testWidgets('Login Gagal', (tester) async {
      FlutterError.onError = (FlutterErrorDetails details) {
        bool ifIsOverflowError = false;

        // Detect overflow error.
        var exception = details.exception;
        if (exception is FlutterError) {
          ifIsOverflowError = !exception.diagnostics.any((e) =>
              e.value.toString().startsWith("A RenderFlex overflowed by"));
        }

        // Ignore if it's an overflow error.
        if (ifIsOverflowError) {
          print('Overflow error.');
        } else {
          // Throw other errors.
          FlutterError.dumpErrorToConsole(details);
        }
      };

      await tester.pumpWidget(MaterialApp(
        home: Login(),
      ));

      await tester.enterText(find.byKey(Key('userField')), '2');
      await tester.enterText(find.byKey(Key('passField')), '2');
      await tester.tap(find.byKey(Key('loginButton')));
      await tester.pumpAndSettle(Duration(seconds: 2));

      // expect(find.text('Login Gagal'), findsOneWidget);
    });

    
  });


}
