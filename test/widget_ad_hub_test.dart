import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_ad_hub/widget_ad_hub.dart';

void main() {
  const MethodChannel channel = MethodChannel('widget_ad_hub');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await WidgetAdHub.platformVersion, '42');
  });
}
