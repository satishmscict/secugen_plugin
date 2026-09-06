import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:secugen_plugin/secugen_plugin_method_channel.dart';
import 'package:secugen_plugin/utils/constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final platform = MethodChannelSecugenPlugin();
  const channel = MethodChannel(CHANNEL);
  final calls = <MethodCall>[];

  setUp(() {
    calls.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        calls.add(methodCall);

        switch (methodCall.method) {
          case METHOD_CLEAR_ALL_FILES:
          case METHOD_INIT:
          case METHOD_VERIFY_FINGERPRINT:
            return true;
          case METHOD_SET_BRIGHTNESS:
          case METHOD_TOGGLE_LED:
          case METHOD_TOGGLE_SMART_CAPTURE:
            return null;
          case METHOD_CAPTURE_FINGERPRINT:
          case METHOD_CAPTURE_FINGERPRINT_WITH_QUALITY:
            return [
              Uint8List.fromList([1, 2]),
              Uint8List.fromList([3, 4]),
              76,
              '/tmp/fingerprint.png',
            ];
          case METHOD_GET_MATCHING_SCORE:
            return 91;
          default:
            return null;
        }
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      null,
    );
  });

  test('uses the Secugen fingerprint reader method channel', () async {
    expect(await platform.clearAllFiles(), isTrue);

    expect(calls.single.method, METHOD_CLEAR_ALL_FILES);
  });

  test('forwards initialization and device controls', () async {
    expect(await platform.initializeDevice(), isTrue);
    await platform.enableLed(true);
    await platform.enableSmartCapture(false);
    await platform.setBrightness(55);

    expect(calls.map((call) => call.method), [
      METHOD_INIT,
      METHOD_TOGGLE_LED,
      METHOD_TOGGLE_SMART_CAPTURE,
      METHOD_SET_BRIGHTNESS,
    ]);
    expect(calls[1].arguments, isTrue);
    expect(calls[2].arguments, isFalse);
    expect(calls[3].arguments, 55);
  });

  test('parses capture results and forwards capture arguments', () async {
    final captureResult = await platform.captureFingerprint(true);
    final qualityResult = await platform.captureFingerprintWithQuality(3000, 80, false);

    expect(captureResult?.rawBytes, [1, 2]);
    expect(captureResult?.imageBytes, [3, 4]);
    expect(captureResult?.quality, 76);
    expect(captureResult?.imageFilePath, '/tmp/fingerprint.png');
    expect(qualityResult?.rawBytes, [1, 2]);
    expect(calls[0].arguments, isTrue);
    expect(calls[1].arguments, [3000, 80, false]);
  });

  test('forwards fingerprint verification and score arguments', () async {
    final firstBytes = Uint8List.fromList([1, 2]);
    final secondBytes = Uint8List.fromList([3, 4]);

    expect(await platform.verifyFingerprint(firstBytes, secondBytes), isTrue);
    expect(await platform.getMatchingScore(firstBytes, secondBytes), 91);

    expect(calls[0].arguments, [firstBytes, secondBytes]);
    expect(calls[1].arguments, [firstBytes, secondBytes]);
  });
}
