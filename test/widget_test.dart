import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyage/main.dart';

void main() {
  testWidgets('Démarre sur Authentification si non connecté', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Page Authentification'), findsOneWidget);
  });

  testWidgets('Démarre sur Home si connecté', (tester) async {
    SharedPreferences.setMockInitialValues({'connecte': true});
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Page Home'), findsOneWidget);
  });
}
