import 'package:flutter/material.dart';
import 'package:hackerkernel_task/src/data/data_sources/shared_pref.dart';
import 'package:hackerkernel_task/src/presentation/view/dashboard.dart';
import 'package:hackerkernel_task/src/presentation/view/login_page.dart';
import 'package:lottie/lottie.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool isLogin = false;

  @override
  void initState() {
    loginStatus();

    super.initState();
  }

  loginStatus() async {
    isLogin = await SharedPref().getLoginStatus();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => isLogin ? const Dashboard() : const LoginPage(),
        ),
        (routes) => false,
      );
    });
    setState(() {});
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Lottie.network(
            'https://lottie.host/084a2f74-a305-453c-b8f6-c7ab6ff07622/4wXKx9iH7J.json',
          ),
        ),
      ),
    );
  }
}
