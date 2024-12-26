// class SecugenPlugin {
//   Future<String?> getPlatformVersion() {
//     return SecugenPluginPlatform.instance.getPlatformVersion();
//   }
// }

import 'dart:typed_data';

import 'secugen_plugin_platform_interface.dart';
//import 'SecugenPlugin_platform_interface.dart';
import 'utils/barrels.dart';

export 'utils/barrels.dart';
export 'utils/sgfplib_exception.dart';

class SecugenPlugin {
  Future<bool?> initializeDevice() {
    return SecugenPluginPlatform.instance.initializeDevice();
  }

  Future<void> enableLed(bool val) async {
    SecugenPluginPlatform.instance.enableLed(val);
  }

  Future<void> enableSmartCapture(bool val) async {
    SecugenPluginPlatform.instance.enableSmartCapture(val);
  }

  Future<void> setBrightness(int val) async {
    return SecugenPluginPlatform.instance.setBrightness(val);
  }

  Future<ImageCaptureResult?> captureFingerprint({bool auto = false}) async {
    return SecugenPluginPlatform.instance.captureFingerprint(auto);
  }

  Future<ImageCaptureResult?> captureFingerprintWithQuality(
      {required int timeout, required int quality, bool auto = false}) async {
    return SecugenPluginPlatform.instance
        .captureFingerprintWithQuality(timeout, quality, auto);
  }

  Future<bool?> verifyFingerprint(
      {required Uint8List firstBytes, required Uint8List secondBytes}) async {
    return SecugenPluginPlatform.instance
        .verifyFingerprint(firstBytes, secondBytes);
  }

  Future<int?> getMatchingScore(
      {required Uint8List firstBytes, required Uint8List secondBytes}) async {
    return SecugenPluginPlatform.instance
        .getMatchingScore(firstBytes, secondBytes);
  }
}
