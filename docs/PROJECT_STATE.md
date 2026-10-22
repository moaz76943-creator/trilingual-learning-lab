# حالة المشروع (PROJECT_STATE)

* **Cycle**: 022
* **Phase**: PHASE 20 — محرك المحادثات اليومية والمواقف الواقعية (Situational Dialogues Engine)
* **Status**: Local Verified & Pushed
* **Content Inventory**:
  - `Vocabulary`: 305 مفاهيم لغوية متكاملة عبر 12 قسمًا نشطًا كاملًا
  - `Verbs`: 15 فعلًا أساسيًا مع جداول تصريف كاملة باللغات الثلاث
  - `Prepositions`: 20 حرف جر مصنف بالحالات الإعرابية
  - `Sentences`: 20 تمرين تركيب جمل تفاعلي
  - `Dialogues`: 5 محادثات مواقف واقعية بنظام فقاعات المحادثة والترجمة الفورية بالنقرة (Tap-to-Reveal)
  - `Assets`: 345 ملف SVG متجهي أصلي مدمج محليًا
* **Architecture Additions**:
  - `dialogues_a1.json`: محتوى المحادثات اليومية للمواقف الحياتية (التعارف، المقهى، السوبرماركت، الطريق، الفندق).
  - `lib/models/dialogue_model.dart`: نموذج Dart للمحادثات وأسطر الحوار.
  - `lib/screens/dialogues_screen.dart`: واجهة دردشة تفاعلية وميزة إظهار وإخفاء التشكيل والترجمة بالنقرة.
* **Next Step**: CYCLE 023 — إطلاق خوارزمية التكرار المتباعد الذكي (SuperMemo-2 / Leitner Spaced Repetition Algorithm) لجدولة مراجعة المفردات والأفعال بناءً على أداء المتعلم.
