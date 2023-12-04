
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugdlayout2/View/widgetTesting/login.dart';
import 'package:ugdlayout2/View/widgetTesting/register.dart';

enum Gender { male, female }
void main() {
  
    group("Register", () {
    testWidgets('Register Sukses', (tester) async {
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
        home: Register(),
      ));

      await tester.enterText(find.byKey(Key('userField')), 'mic');
      await tester.pumpAndSettle(Duration(seconds: 1));
      await tester.enterText(find.byKey(Key('emailField')), 'mic@gmail.com');
      await tester.pumpAndSettle(Duration(seconds: 1));
      await tester.enterText(find.byKey(Key('passField')), '124');
      await tester.pumpAndSettle(Duration(seconds: 1));
      await tester.enterText(find.byKey(Key('noTelpField')), 'noTelp');
      await tester.pumpAndSettle(Duration(seconds: 1));
      await tester.tap(find.byKey(Key('femaleRadio')));
      await tester.pumpAndSettle(Duration(seconds: 1));
      await tester.tap(find.byKey(Key('registerButton')));

      // var status = await RegisterState(). registerTesting('mic','123','mic@gmail.com','124','male');

      


      // expect(find.text('Berhasil Register'), findsOneWidget);
      await tester.pumpAndSettle(Duration(seconds: 5));
    });


  testWidgets('Register Gagal', (tester) async {
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
        home: Register(),
      ));

      await tester.enterText(find.byKey(Key('userField')), '');
      await tester.pumpAndSettle(Duration(seconds: 1));
      await tester.enterText(find.byKey(Key('emailField')), '');
      await tester.pumpAndSettle(Duration(seconds: 1));
      await tester.enterText(find.byKey(Key('passField')), '124');
      await tester.pumpAndSettle(Duration(seconds: 1));
      await tester.enterText(find.byKey(Key('noTelpField')), 'noTelp');
      await tester.pumpAndSettle(Duration(seconds: 1));
      await tester.tap(find.byKey(Key('femaleRadio')));
      await tester.pumpAndSettle(Duration(seconds: 1));
      await tester.tap(find.byKey(Key('registerButton')));

      // var status = await RegisterState(). registerTesting('mic','123','mic@gmail.com','124','male');

      


      // expect(find.text('Berhasil Register'), findsOneWidget);
      await tester.pumpAndSettle(Duration(seconds: 2));
    });
  
  });
}
