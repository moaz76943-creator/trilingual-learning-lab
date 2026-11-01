class ArabicTextShaper {
  static const Set<String> _tashkeel = {
    '\u064B', // Tanwin Fath
    '\u064C', // Tanwin Damm
    '\u064D', // Tanwin Kasr
    '\u064E', // Fatha
    '\u064F', // Damma
    '\u0650', // Kasra
    '\u0651', // Shadda
    '\u0652', // Sukun
    '\u0670', // Superscript Alef
  };

  static String stripDiacritics(String text) {
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      if (!_tashkeel.contains(char)) {
        buffer.write(char);
      }
    }
    return buffer.toString();
  }

  static String normalize(String text) {
    String res = stripDiacritics(text);
    res = res.replaceAll(RegExp(r'[إأآا]'), 'ا');
    res = res.replaceAll('ة', 'ه');
    res = res.replaceAll('ى', 'ي');
    return res.trim();
  }
}
