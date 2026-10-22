import re

def normalize_ar(text):
    s = re.sub(r'[\u064B-\u0652\u0640]', '', text)
    s = re.sub(r'[أإآ]', 'ا', s)
    s = s.replace('ة', 'ه').replace('ى', 'ي')
    return s.strip().lower()

def normalize_lat(text):
    s = text.lower()
    s = s.replace('ä', 'ae').replace('ö', 'oe').replace('ü', 'ue').replace('ß', 'ss')
    return s.strip()

def test_normalization():
    # 1. فحص تطبيع العربية
    assert normalize_ar("أَبٌ") == normalize_ar("اب")
    assert normalize_ar("تُفَّاحَةٌ") == normalize_ar("تفاحه")
    assert normalize_ar("مَاءٌ") == normalize_ar("ماء")
    
    # 2. فحص تطبيع الألمانية
    assert normalize_lat("Äpfel") == normalize_lat("aepfel")
    assert normalize_lat("Großvater") == normalize_lat("grossvater")
    assert normalize_lat("Hähnchen") == normalize_lat("haehnchen")
    
    print("PASS: Trilingual search normalization logic verified (Arabic diacritics + German umlauts).")

if __name__ == "__main__":
    test_normalization()
