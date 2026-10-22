# حالة المشروع (PROJECT_STATE)

* **Cycle**: 021
* **Phase**: PHASE 16 — محرك حروف الجر والقواعد المكانية (Prepositions Engine)
* **Status**: Local Verified & Pushed
* **Content Inventory**:
  - `Vocabulary`: 305 مفاهيم لغوية متكاملة عبر 12 قسمًا نشطًا كاملًا
  - `Verbs`: 15 فعلًا أساسيًا مع جداول تصريف كاملة باللغات الثلاث
  - `Prepositions`: 20 حرف جر بقواعد الحالات الإعرابية (Wechsel / Dativ / Akkusativ)
  - `Sentences`: 20 تمرين تركيب جمل تفاعلي
  - `Assets`: 340 ملف SVG متجهي أصلي مدمج محليًا
* **Architecture Additions**:
  - `prepositions_a1.json`: قاعدة بيانات حروف الجر مع تصنيف الحالات الإعرابية والأمثلة.
  - `lib/models/preposition_model.dart`: نموذج Dart لحروف الجر وقواعدها.
  - `lib/screens/prepositions_screen.dart`: واجهة تفاعلية مع فلاتر سريعة للـ Wechsel و Dativ و Akkusativ.
* **Next Step**: CYCLE 022 — إطلاق محرك المحادثات اليومية وحوارات التعارف والمواقف الواقعية (Situational Dialogues Engine).
