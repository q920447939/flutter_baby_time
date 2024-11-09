enum SexEnums {
  female(
    '0',
    '小公举',
  ),
  man(
    '1',
    '小正太',
  );

  final String value;
  final String label;

  const SexEnums(
    this.value,
    this.label,
  );

  static SexEnums fromString(String? value) {
    return SexEnums.values.firstWhere(
      (e) => e.value == value,
      orElse: () => SexEnums.female,
    );
  }
}
