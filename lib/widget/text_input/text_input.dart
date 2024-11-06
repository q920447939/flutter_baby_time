import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  //输入框类型
  TextInputType textInputType;

  String title;

  //自动聚焦
  bool autofocus;

  //改动
  ValueChanged<String>? onChanged;

  //光标改动
  ValueChanged<bool>? focusChange;

  //是否是安全文本（密码）
  bool isObscureText;

  //提示文字
  String hintText;

  //提示样式
  TextStyle hintStyle;

  TextInput({
    required this.textInputType,
    required this.title,
    required this.hintText,
    this.autofocus = false,
    this.onChanged,
    this.focusChange,
    this.isObscureText = false,
    this.hintStyle = const TextStyle(fontSize: 16),
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  //聚焦事件
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      print("has focus ${_focusNode.hasFocus}");
      if (widget.focusChange != null) {
        widget.focusChange!(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 100,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 16, decoration: TextDecoration.none),
              ),
            ),
            Expanded(child: _buildTextField()),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 5, left: 10, right: 10),
          child: Divider(
            height: 1,
            thickness: 0.5,
          ),
        ),
      ],
    );
  }

  TextField _buildTextField() {
    return TextField(
      keyboardType: widget.textInputType,
      autofocus: widget.autofocus,
      onChanged: widget.onChanged,
      focusNode: _focusNode,
      obscureText: widget.isObscureText,
      style: TextStyle(
        fontSize: 16,
        color: Colors.black54,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          border: InputBorder.none),
    );
  }
}
