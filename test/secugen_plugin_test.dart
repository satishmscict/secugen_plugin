import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:secugen_plugin/secugen_plugin.dart';
import 'package:secugen_plugin/secugen_plugin_method_channel.dart';
import 'package:secugen_plugin/secugen_plugin_platform_interface.dart';

class MockSecugenPluginPlatform with MockPlatformInterfaceMixin implements SecugenPluginPlatform {
  bool? lastLedValue;
  bool? lastSmartCaptureValue;
  int? lastBrightnessValue;
  bool? lastCaptureAutoValue;
  List<Object?>? lastCaptureWithQualityArgs;
  List<Uint8List>? lastVerifyArgs;
  List<Uint8List>? lastScoreArgs;

  @override
  Future<bool?> clearAllFiles() async => true;

  @override
  Future<bool?> initializeDevice() async => true;

  @override
  Future<void> enableLed(bool val) async {
    lastLedValue = val;
  }

  @override
  Future<void> enableSmartCapture(bool val) async {
    lastSmartCaptureValue = val;
  }

  @override
  Future<void> setBrightness(int val) async {
    lastBrightnessValue = val;
  }

  @override
  Future<ImageCaptureResult?> captureFingerprint(bool auto) async {
    lastCaptureAutoValue = auto;
    return ImageCaptureResult(
      rawBytes: Uint8List.fromList([1, 2]),
      imageBytes: Uint8List.fromList([3, 4]),
    );
  }

  @override
  Future<ImageCaptureResult?> captureFingerprintWithQuality(
    int timeout,
    int quality,
    bool auto,
  ) async {
    lastCaptureWithQualityArgs = [timeout, quality, auto];
    return ImageCaptureResult(
      rawBytes: Uint8List.fromList([5, 6]),
      imageBytes: Uint8List.fromList([7, 8]),
    );
  }

  @override
  Future<bool?> verifyFingerprint(Uint8List firstBytes, Uint8List secondBytes) async {
    lastVerifyArgs = [firstBytes, secondBytes];
    return true;
  }

  @override
  Future<int?> getMatchingScore(Uint8List firstBytes, Uint8List secondBytes) async {
    lastScoreArgs = [firstBytes, secondBytes];
    return 87;
  }
}

void main() {
  final initialPlatform = SecugenPluginPlatform.instance;

  tearDown(() {
    SecugenPluginPlatform.instance = initialPlatform;
  });

  test('$MethodChannelSecugenPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSecugenPlugin>());
  });

  test('public wrapper forwards calls to platform implementation', () async {
    final secugenPlugin = SecugenPlugin();
    final fakePlatform = MockSecugenPluginPlatform();
    SecugenPluginPlatform.instance = fakePlatform;

    final firstBytes = Uint8List.fromList([1]);
    final secondBytes = Uint8List.fromList([2]);

    expect(await secugenPlugin.clearAllFiles(), isTrue);
    expect(await secugenPlugin.initializeDevice(), isTrue);
    await secugenPlugin.enableLed(true);
    await secugenPlugin.enableSmartCapture(false);
    await secugenPlugin.setBrightness(60);
    final captureResult = await secugenPlugin.captureFingerprint(auto: true);
    final qualityResult = await secugenPlugin.captureFingerprintWithQuality(
      timeout: 3000,
      quality: 80,
      auto: true,
    );
    expect(
      await secugenPlugin.verifyFingerprint(firstBytes: firstBytes, secondBytes: secondBytes),
      isTrue,
    );
    expect(
      await secugenPlugin.getMatchingScore(firstBytes: firstBytes, secondBytes: secondBytes),
      87,
    );

    expect(fakePlatform.lastLedValue, isTrue);
    expect(fakePlatform.lastSmartCaptureValue, isFalse);
    expect(fakePlatform.lastBrightnessValue, 60);
    expect(fakePlatform.lastCaptureAutoValue, isTrue);
    expect(fakePlatform.lastCaptureWithQualityArgs, [3000, 80, true]);
    expect(fakePlatform.lastVerifyArgs, [firstBytes, secondBytes]);
    expect(fakePlatform.lastScoreArgs, [firstBytes, secondBytes]);
    expect(captureResult?.rawBytes, [1, 2]);
    expect(qualityResult?.imageBytes, [7, 8]);
  });
}
