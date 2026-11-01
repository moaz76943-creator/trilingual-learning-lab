# قواعد ProGuard / R8 لتحسين وتقليص حجم كود أندرويد
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable

# الحفاظ على واجهات محرك فلاتر والاتصال بـ JNI
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.** { *; }

# الحفاظ على كائنات النماذج المشروحة بـ Keep
-keepclassmembers class * {
    @androidx.annotation.Keep *;
}

-dontwarn io.flutter.**
