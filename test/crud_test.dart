import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugdlayout2/View/kamar_page.dart';
import 'package:ugdlayout2/View/login.dart';
import 'package:ugdlayout2/View/ugdAPI2/kamarPage.dart';
import 'package:ugdlayout2/View/widgetTesting/login.dart';
import 'package:ugdlayout2/View/widgetTesting/showTesting.dart';
import 'package:ugdlayout2/entity/kamar.dart';

void main() {
  group('Crud', () {
    testWidgets('Show Sukses', (tester) async {
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

      List<Room> rooms = [
        Room('Kamar 101', 'Single'),
        Room('Kamar 102', 'Double'),
        Room('Kamar 103', 'Suite'),
      ];

      await tester.pumpWidget(MaterialApp(
        home: RoomListPage(),
      ));

      RoomListPage().isiDataRoom(rooms);

      await tester.pumpAndSettle(Duration(seconds: 5));
    });

    testWidgets('Show Failed', (tester) async {
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

      List<Room> rooms = [];

      await tester.pumpWidget(MaterialApp(
        home: RoomListPage2(),
      ));

      RoomListPage().isiDataRoom(rooms);
      await tester.pumpAndSettle(Duration(seconds: 5));
    });
  });
}
