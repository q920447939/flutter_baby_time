import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../../../constants.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TDInput(
          leftIcon: const Icon(TDIcons.mobile),
          leftLabel: '手机号',
          //controller: controller[10],
          backgroundColor: Colors.white,
          hintText: '请输入手机号',
          onChanged: (text) {
            setState(() {});
          },
          onClearTap: () {
            //controller[10].clear();
            setState(() {});
          },
        ),
        TDInput(
          leftIcon: const Icon(TDIcons.logo_adobe_photoshop_filled),
          leftLabel: '手机号',
          //controller: controller[10],
          backgroundColor: Colors.white,
          hintText: '请输入手机号',
          onChanged: (text) {
            setState(() {});
          },
          onClearTap: () {
            //controller[10].clear();
            setState(() {});
          },
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
