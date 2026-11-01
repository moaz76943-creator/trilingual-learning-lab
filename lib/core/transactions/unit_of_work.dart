class UnitOfWork {
  final List<Future<void> Function()> _operations = [];
  bool _isCommitted = false;

  void register(Future<void> Function() op) {
    if (_isCommitted) throw StateError('UnitOfWork is already committed');
    _operations.add(op);
  }

  Future<void> commit() async {
    if (_isCommitted) return;
    for (final op in _operations) {
      await op();
    }
    _isCommitted = true;
    _operations.clear();
  }
}
