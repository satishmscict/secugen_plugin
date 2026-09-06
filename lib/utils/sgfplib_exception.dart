class SgfplibException implements Exception {
  String? message;

  SgfplibException({this.message});
}

class DeviceNotSupportedException extends SgfplibException {
  DeviceNotSupportedException({required super.message});
}

class InitializationFailedException extends SgfplibException {
  InitializationFailedException({required super.message});
}

class SensorNotFoundException extends SgfplibException {
  SensorNotFoundException({required super.message});
}

class SmartCaptureEnabledException extends SgfplibException {
  SmartCaptureEnabledException({required super.message});
}

class OutOfRangeException extends SgfplibException {
  OutOfRangeException({required super.message});
}

class NoFingerprintException extends SgfplibException {
  NoFingerprintException({required super.message});
}

class TemplateInitializationException extends SgfplibException {
  TemplateInitializationException({required super.message});
}

class TemplateMatchingException extends SgfplibException {
  TemplateMatchingException({required super.message});
}
