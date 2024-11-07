enum ViewMode {
  waterfall, // 瀑布流
  timeline; // 时间线

  static ViewMode fromString(String? value) {
    return ViewMode.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ViewMode.waterfall, // 默认瀑布流
    );
  }
}
