class PhoneValidator {
  /// 验证中国大陆手机号
  static bool isChinaMainlandPhone(String phone) {
    if (phone.isEmpty) return false;

    // 去除所有空格
    phone = phone.replaceAll(RegExp(r'\s+'), '');

    // 验证手机号格式
    RegExp cnPhoneReg = RegExp(r'^1[3-9]\d{9}$');
    return cnPhoneReg.hasMatch(phone);
  }

  /// 格式化手机号 (xxx xxxx xxxx)
  static String formatPhone(String phone) {
    if (phone.isEmpty) return phone;

    // 去除所有空格
    phone = phone.replaceAll(RegExp(r'\s+'), '');

    if (phone.length != 11) return phone;

    // 格式化为 xxx xxxx xxxx
    return '${phone.substring(0, 3)} ${phone.substring(3, 7)} ${phone.substring(7)}';
  }

  /// 隐藏手机号中间四位 (例如：138****8888)
  static String maskPhone(String phone) {
    if (phone.isEmpty) return phone;

    // 去除所有空格
    phone = phone.replaceAll(RegExp(r'\s+'), '');

    if (phone.length != 11) return phone;

    return '${phone.substring(0, 3)}****${phone.substring(7)}';
  }
}
