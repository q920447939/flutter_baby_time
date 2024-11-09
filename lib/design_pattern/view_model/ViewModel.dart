enum ViewMode {
  waterfall(
    'waterfall',
    '瀑布流模式',
  ),
  timeline(
    'timeline',
    '时间线模式',
  );

  final String value;
  final String label;

  const ViewMode(
    this.value,
    this.label,
  );

  static ViewMode fromString(String? value) {
    return ViewMode.values.firstWhere(
      (e) => e.value == value,
      orElse: () => ViewMode.waterfall,
    );
  }
}
