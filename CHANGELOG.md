## 1.3.0

* Updated Android and example project configuration for Flutter 3.47+ compatibility.
* Fixed standalone example release build by removing stale generated plugin registrant source.
* Updated Java/Kotlin compile targets to Java 17 to support modern Android toolchains.
* Added and repaired plugin tests for the current SecuGen public API and method channel behavior.
* Cleaned Dart wrapper forwarding and exception constructors for maintainability.
* Added repository ignore rules for generated Flutter/build artifacts.

## 1.2.1

* Resolved the Android 16 KB memory page size limit issue.
* Updated all .so files to the latest version.

## 1.1.1

* Device Connection Issue Fixed: Resolved the issue where the fingerprint device was connecting only the first time the application was opened, and failing to reconnect on subsequent launches.

## 1.1.0

* Save Captured Image to Scoped Storage: Added functionality to save fingerprint images directly to scoped storage, ensuring better file management and security.
* Clear Captured Images: Introduced a feature to clear all previously captured fingerprint images from scoped storage, providing users with an easy way to manage stored data.

## 1.0.0

* First version of Secugen plugin to connect and access the device features.
