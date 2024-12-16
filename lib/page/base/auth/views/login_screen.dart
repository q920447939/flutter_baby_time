import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/base_stack/base_stack.dart';
import 'package:flutter_baby_time/widget/custom_safe_area/CustomSafeArea.dart';
import 'package:flutter_baby_time/widget/gap/gap_height.dart';
import 'package:flutter_baby_time/widget/smart_dialog/smart_dialog_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../../constants.dart';
import '../../../../dao/base/auth/auth_dao.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  var userName = '';
  var password = '';

  @override
  void initState() {
    _usernameController.text = 'abc1234';
    _passwordController.text = '123456';
    userName = _usernameController.text;
    password = _passwordController.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomerSafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Image.asset(
              "assets/images/login_dark.png",
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "欢迎回来",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  const Text(
                    "使用您在注册时输入的数据登录。",
                  ),
                  const SizedBox(height: defaultPadding),
                  TDInput(
                    required: true,
                    leftIcon: const Icon(TDIcons.mobile),
                    leftLabel: '手机号',
                    controller: _usernameController,
                    backgroundColor: Colors.white,
                    hintText: '请输入手机号',
                    onChanged: (newVal) {
                      setState(() {
                        userName = newVal;
                      });
                    },
                    onClearTap: () {
                      setState(() {
                        userName = '';
                        _usernameController.text = '';
                      });
                    },
                  ),
                  TDInput(
                    required: true,
                    leftIcon: const Icon(TDIcons.photo),
                    leftLabel: '密码',
                    controller: _passwordController,
                    backgroundColor: Colors.white,
                    hintText: '请输入密码',
                    obscureText: true,
                    onChanged: (newVal) {
                      setState(() {
                        password = newVal;
                      });
                    },
                    onClearTap: () {
                      setState(() {
                        password = '';
                        _passwordController.text = '';
                      });
                    },
                  ),
                  gapHeightLarge(),
                  Align(
                    child: TDButton(
                      text: '登录',
                      disabled: userName.isEmpty || password.isEmpty,
                      size: TDButtonSize.medium,
                      type: TDButtonType.fill,
                      shape: TDButtonShape.rectangle,
                      theme: TDButtonTheme.primary,
                      onTap: () async {
                        var b = await AuthDao.login({
                          "userName": userName,
                          "password": password,
                          "registerChannel": 3,
                          "inviteMemberSimpleId": 0,
                          "verificationCode": "1111"
                        });
                        if (b) {
                          await dialogSuccess('登录成功', onDismiss: () {
                            context.go("/");
                          });
                        }
                      },
                    ),
                  ),
                  Align(
                    child: TextButton(
                      child: const Text("忘记密码?"),
                      onPressed: () {
                        context.go("/passwordRecovery");
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("还没有账户?"),
                      TextButton(
                        onPressed: () {
                          context.go("/signup");
                        },
                        child: const Text("注册"),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
