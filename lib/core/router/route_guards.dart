class ContentReadyGuard {
  static bool _isContentReady = false;

  static void setContentReady(bool ready) {
    _isContentReady = ready;
  }

  static bool canNavigateToLearning() {
    return _isContentReady;
  }
}
