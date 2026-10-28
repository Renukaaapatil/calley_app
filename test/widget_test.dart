import 'package:flutter_test/flutter_test.dart';
import 'package:calley_app/main.dart';

void main() {
  testWidgets('CalleyApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CalleyApp());

    // Verify language selection screen is rendered
    expect(find.text('Choose Your Language'), findsOneWidget);
  });
}
