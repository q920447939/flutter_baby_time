import 'package:flutter/services.dart';

/**
 * 限制只能输入小数点后两位 数字
 */
class EnhancedDecimalFormatter extends TextInputFormatter {
  final int decimalPlaces;

  EnhancedDecimalFormatter({this.decimalPlaces = 2});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;
    if (newText.isEmpty) {
      return newValue;
    }

    // 允许单个小数点或单个负号
    if (newText == '.' || newText == '-') {
      return newValue;
    }

    // 检查格式
    final RegExp regExp = RegExp(r'^-?\d*\.?\d*$');
    if (!regExp.hasMatch(newText)) {
      return oldValue;
    }

    // 处理小数点后的位数
    if (newText.contains('.')) {
      List<String> parts = newText.split('.');
      if (parts.length > 1 && parts[1].length > decimalPlaces) {
        newText = '${parts[0]}.${parts[1].substring(0, decimalPlaces)}';
      }
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
