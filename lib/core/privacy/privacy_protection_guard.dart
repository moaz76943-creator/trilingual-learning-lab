class PrivacyProtectionGuard {
  // يمنع تخزين أو تسجيل أي بيانات شخصية أو استشارات حساسة
  static String sanitizeText(String input) {
    String clean = input;
    // حظر وحذف أرقام الهواتف والبريد الإلكتروني من أي سجل كاش محلي
    clean = clean.replaceAll(RegExp(r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b'), '[PROTECTED_EMAIL]');
    clean = clean.replaceAll(RegExp(r'\b\+?[0-9]{8,15}\b'), '[PROTECTED_PHONE]');
    return clean.trim();
  }

  static bool isSafeEducationalQuery(String query) {
    final lower = query.toLowerCase();
    // استبعاد أي استشارات طبية تشخيصية أو قضايا محاكم جافة
    const forbiddenPatterns = ['تشخيص مرض', 'وصفة علاجية', 'دعوى قضائية', 'استشارة محكمة'];
    return !forbiddenPatterns.any((pattern) => lower.contains(pattern));
  }
}
