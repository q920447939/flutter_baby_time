import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/smart_dialog/smart_dialog_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../../constants.dart';
import '../../../../dao/base/auth/auth_dao.dart';
import 'components/login_form.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                    "Welcome back!",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  const Text(
                    "Log in with your data that you intered during your registration.",
                  ),
                  const SizedBox(height: defaultPadding),
                  TDInput(
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
                  Align(
                    child: TextButton(
                      child: const Text("Forgot password"),
                      onPressed: () {
                        context.go("/passwordRecovery");
                      },
                    ),
                  ),
                  SizedBox(
                    height:
                        size.height > 700 ? size.height * 0.1 : defaultPadding,
                  ),
                  Align(
                    child: TDButton(
                      text: "登录",
                      disabled: userName.isEmpty || password.isEmpty,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          context.go("/signup");
                        },
                        child: const Text("Sign up"),
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
