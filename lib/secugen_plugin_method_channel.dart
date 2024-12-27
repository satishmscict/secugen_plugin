import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'secugen_plugin_platform_interface.dart';
import 'utils/barrels.dart';
import 'utils/constants.dart';
import 'utils/sgfplib_exception.dart';

/// An implementation of [SecugenPluginPlatform] that uses method channels.
// class MethodChannelSecugenPlugin extends SecugenPluginPlatform {
//   /// The method channel used to interact with the native platform.
//   @visibleForTesting
//   final methodChannel = const MethodChannel('secugen_plugin');
//
//   @override
//   Future<String?> getPlatformVersion() async {
//     final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
//     return version;
//   }
// }

///////////////////////////
//////////////////////////

class MethodChannelSecugenPlugin extends SecugenPluginPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel(CHANNEL);

  @override
  Future<bool?> clearAllFiles() async {
    try {
      final result =
          await methodChannel.invokeMethod<bool>(METHOD_CLEAR_ALL_FILES);
      return result;
    } on PlatformException catch (e) {
      throw _libException(e);
    }
  }

  @override
  Future<bool?> initializeDevice() async {
    try {
      final result = await methodChannel.invokeMethod<bool>(METHOD_INIT);
      return result;
    } on PlatformException catch (e) {
      throw _libException(e);
    }
  }

  @override
  Future<void> enableLed(bool val) async {
    try {
      await methodChannel.invokeMethod(METHOD_TOGGLE_LED, val);
    } on PlatformException catch (e) {
      //exception handling
      throw _libException(e);
    }
  }

  @override
  Future<void> enableSmartCapture(bool val) async {
    try {
      await methodChannel.invokeMethod(METHOD_TOGGLE_SMART_CAPTURE, val);
    } on PlatformException catch (e) {
      //exception handling
      throw _libException(e);
    }
  }

  @override
  Future<void> setBrightness(int val) async {
    try {
      await methodChannel.invokeMethod(METHOD_SET_BRIGHTNESS, val);
    } on PlatformException catch (e) {
      throw _libException(e);
    }
  }

  @override
  Future<ImageCaptureResult?> captureFingerprint(bool auto) async {
    try {
      final result =
          await methodChannel.invokeMethod(METHOD_CAPTURE_FINGERPRINT, auto);
      return ImageCaptureResult(
        rawBytes: result[0],
        imageBytes: result[1],
        quality: result[2],
        imageFilePath: result[3],
      );
    } on PlatformException catch (e) {
      throw _libException(e);
    }
  }

  @override
  Future<ImageCaptureResult?> captureFingerprintWithQuality(
      int timeout, int quality, bool auto) async {
    try {
      final result = await methodChannel.invokeMethod(
          METHOD_CAPTURE_FINGERPRINT_WITH_QUALITY, [timeout, quality, auto]);
      return ImageCaptureResult(
        rawBytes: result[0],
        imageBytes: result[1],
        quality: result[2],
        imageFilePath: result[3],
      );
    } on PlatformException catch (e) {
      throw _libException(e);
    }
  }

  @override
  Future<bool?> verifyFingerprint(
      Uint8List firstBytes, Uint8List secondBytes) async {
    try {
      final result = await methodChannel.invokeMethod<bool>(
          METHOD_VERIFY_FINGERPRINT, [firstBytes, secondBytes]);
      return result;
    } on PlatformException catch (e) {
      throw _libException(e);
    }
  }

  @override
  Future<int?> getMatchingScore(
      Uint8List firstBytes, Uint8List secondBytes) async {
    try {
      final result = await methodChannel.invokeMethod<int>(
          METHOD_GET_MATCHING_SCORE, [firstBytes, secondBytes]);
      return result;
    } on PlatformException catch (e) {
      throw _libException(e);
    }
  }

  SgfplibException _libException(PlatformException exception) {
    SgfplibException sgfplibException = SgfplibException();

    switch (exception.code) {
      case ERROR_NOT_SUPPORTED:
        sgfplibException =
            DeviceNotSupportedException(message: exception.message);
        break;

      case ERROR_INITIALIZATION_FAILED:
        sgfplibException =
            InitializationFailedException(message: exception.message);
        break;

      case ERROR_SENSOR_NOT_FOUND:
        sgfplibException = SensorNotFoundException(message: exception.message);
        break;

      case ERROR_SMART_CAPTURE_ENABLED:
        sgfplibException =
            SmartCaptureEnabledException(message: exception.message);
        break;

      case ERROR_OUT_OF_RANGE:
        sgfplibException = OutOfRangeException(message: exception.message);
        break;

      case ERROR_NO_FINGERPRINT:
        sgfplibException = NoFingerprintException(message: exception.message);
        break;

      case ERROR_TEMPLATE_INITIALIZE_FAILED:
        sgfplibException =
            TemplateInitializationException(message: exception.message);
        break;

      case ERROR_TEMPLATE_MATCHING_FAILED:
        sgfplibException =
            TemplateMatchingException(message: exception.message);
        break;
      default:
        sgfplibException = SgfplibException(message: "Unknown exception");
    }

    return sgfplibException;
  }
}
