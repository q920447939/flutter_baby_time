import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnderLineTextField extends StatefulWidget {
  final String hintText;
  final TextStyle? hintTextStyle;
  final int maxInputNumber;
  final Function(String)? callback;

  const UnderLineTextField({
    Key? key,
    required this.hintText,
    required this.maxInputNumber,
    this.callback,
    this.hintTextStyle,
  }) : super(key: key);

  @override
  _UnderLineTextFieldState createState() => _UnderLineTextFieldState();
}

class _UnderLineTextFieldState extends State<UnderLineTextField> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: widget.hintText,
      ),
      textAlign: TextAlign.start,
      /* maxLines: 1,
      maxLength: widget.maxInputNumber,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,*/
      style: widget.hintTextStyle ??
          TextStyle(fontSize: 18.sp, color: Colors.black),
      onChanged: (text) {
        setState(() {
          widget.callback?.call(text);
        });
      },
    );
  }
}
