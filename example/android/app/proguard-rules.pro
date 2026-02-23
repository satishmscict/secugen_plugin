# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

# Retain the AlCamNative class and its members
-keep class com.alcorlink.camera.AlCamNative { *; }

# Preserve all native methods (required for JNI bindings)
-keepclassmembers class com.alcorlink.camera.AlCamNative {
    native <methods>;
}

# Retain the StreamConfig class and its fields, accessed by native code
-keepclassmembers class com.alcorlink.camera.StreamConfig {
    int format;
    int height;
    int width;
    byte streamId;
    *;  # Preserve all other fields if any
}

# Retain all classes, fields, and methods under the alcorlink.camera package
-keep class com.alcorlink.camera.** { *; }

# Preserve annotations (if required by libraries or runtime processing)
-keepattributes *Annotation*

# Preserve classes used by JNI that might be accessed through reflection
-keepclasseswithmembers class * {
    native <methods>;
}

# Keep all ProGuard logs for debugging any runtime issues
# -verbose

-keep class SecuGen.FDxSDKPro.SGFingerInfo { *; }

-keepclassmembers class SecuGen.FDxSDKPro.SGFingerInfo {
    int FingerNumber;
    *;
}

-keepclasseswithmembers class SecuGen.FDxSDKPro.** {
    native <methods>;
}
