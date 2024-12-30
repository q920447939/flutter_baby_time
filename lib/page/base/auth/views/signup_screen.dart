import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../../constants.dart';
import '../../../../dao/base/auth/auth_dao.dart';
import 'components/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/img/register_background.jpeg",
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "让我们开始吧！",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  const Text(
                    "请输入您的有效数据以创建帐户。",
                  ),
                  const SizedBox(height: defaultPadding),
                  Column(
                    children: [
                      TDInput(
                        leftIcon: const Icon(TDIcons.mobile),
                        leftLabel: '手机号',
                        controller: _usernameController,
                        backgroundColor: Colors.white,
                        hintText: '请输入手机号',
                        onChanged: (text) {
                          setState(() {});
                        },
                        onClearTap: () {
                          setState(() {});
                        },
                      ),
                      TDInput(
                        leftIcon: const Icon(TDIcons.pin),
                        leftLabel: '密码',
                        controller: _passwordController,
                        backgroundColor: Colors.white,
                        obscureText: true,
                        hintText: '请输入密码',
                        onChanged: (text) {
                          setState(() {});
                        },
                        onClearTap: () {
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: defaultPadding),
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  /* Row(
                    children: [
                      Checkbox(
                        onChanged: (value) {},
                        value: false,
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: "我同意",
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    */ /*Navigator.pushNamed(
                                        context, termsOfServicesScreenRoute);*/ /*
                                  },
                                text: " 团队服务条款 ",
                                style: const TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const TextSpan(
                                text: "& 隐私政策.",
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: defaultPadding * 2),*/
                  Center(
                    child: TDButton(
                      text: '注册',
                      disabled: _usernameController.text.isEmpty ||
                          _passwordController.text.isEmpty,
                      size: TDButtonSize.medium,
                      type: TDButtonType.fill,
                      shape: TDButtonShape.rectangle,
                      theme: TDButtonTheme.primary,
                      onTap: () async {
/*                        var b = await AuthDao.login({
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
                        }*/
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("存在账户?"),
                      TextButton(
                        onPressed: () {
                          context.go("/signin");
                        },
                        child: const Text("去登录",
                            style: TextStyle(color: primaryColor)),
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
}
