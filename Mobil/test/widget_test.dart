import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/ui/anasayfa.dart';

void main(){
   MaterialApp app = MaterialApp(
    home: Scaffold(
        body:  Anasayfa()
    ),
  );
  testWidgets('Anasayfa UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(app);

    expect(find.byType(Anasayfa),findsOneWidget);
    expect(find.byType(PageView),findsOneWidget);
    expect(find.byType(Container),findsWidgets);
  });
}
