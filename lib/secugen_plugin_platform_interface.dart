import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'secugen_plugin_method_channel.dart';
import 'utils/barrels.dart';
//import 'secugenfplib_method_channel.dart';

// abstract class SecugenPluginPlatform extends PlatformInterface {
//   /// Constructs a SecugenPluginPlatform.
//   SecugenPluginPlatform() : super(token: _token);
//
//   static final Object _token = Object();
//
//   static SecugenPluginPlatform _instance = MethodChannelSecugenPlugin();
//
//   /// The default instance of [SecugenPluginPlatform] to use.
//   ///
//   /// Defaults to [MethodChannelSecugenPlugin].
//   static SecugenPluginPlatform get instance => _instance;
//
//   /// Platform-specific implementations should set this with their own
//   /// platform-specific class that extends [SecugenPluginPlatform] when
//   /// they register themselves.
//   static set instance(SecugenPluginPlatform instance) {
//     PlatformInterface.verifyToken(instance, _token);
//     _instance = instance;
//   }
//
//   Future<String?> getPlatformVersion() {
//    // throw UnimplementedError('platformVersion() has not been implemented.');
//   }
// }

///////////////////////
///////////////////////

abstract class SecugenPluginPlatform extends PlatformInterface {
  SecugenPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static SecugenPluginPlatform _instance = MethodChannelSecugenPlugin();

  static SecugenPluginPlatform get instance => _instance;

  static set instance(SecugenPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> clearAllFiles() {
    throw UnimplementedError('clearAllFiles() has not been implemented.');
  }

  Future<bool?> initializeDevice() {
    throw UnimplementedError('initializeDevice() has not been implemented.');
  }

  Future<void> enableLed(bool val) {
    throw UnimplementedError('toggleLed() has not been implemented.');
  }

  Future<void> enableSmartCapture(bool val) {
    throw UnimplementedError('enableSmartCapture() has not been implemented.');
  }

  Future<void> setBrightness(int val) {
    throw UnimplementedError('setBrightness() has not been implemented.');
  }

  Future<ImageCaptureResult?> captureFingerprint(bool auto) {
    throw UnimplementedError('captureFingerprint() has not been implemented.');
  }

  Future<ImageCaptureResult?> captureFingerprintWithQuality(
      int timeout, int quality, bool auto) {
    throw UnimplementedError(
        'captureFingerprintWithQuality() has not been implemented.');
  }

  Future<bool?> verifyFingerprint(Uint8List firstBytes, Uint8List secondBytes) {
    throw UnimplementedError('verifyFingerprint() has not been implemented.');
  }

  Future<int?> getMatchingScore(Uint8List firstBytes, Uint8List secondBytes) {
    throw UnimplementedError('getMatchingScore() has not been implemented.');
  }
}
