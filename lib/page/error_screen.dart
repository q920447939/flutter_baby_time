import 'package:flutter/material.dart';

import '../config/go_router_config.dart';
import '../router/has_bottom_navigator/shell_default_router.dart';

class ErrorScreenPage extends StatefulWidget {
  final Exception error;

  const ErrorScreenPage({super.key, required this.error});

  @override
  State<ErrorScreenPage> createState() => _ErrorScreenPageState();
}

class _ErrorScreenPageState extends State<ErrorScreenPage> {
  @override
  Widget build(BuildContext context) {
    print("error ${widget.error}");
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          /*Image.asset(
            Assets.router.error404.path,
            fit: BoxFit.cover,
          ),*/
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xFF6B92F2),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              onPressed: () {
                const HomeRoute().go(context);
              },
              child: Text(
                '返回主页',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
