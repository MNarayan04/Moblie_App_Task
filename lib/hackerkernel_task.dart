import 'package:flutter/material.dart';
import 'package:hackerkernel_task/src/data/data_sources/shared_pref.dart';
import 'package:hackerkernel_task/src/presentation/view/loading_page.dart';

class HackerkernalTask extends StatefulWidget {
  const HackerkernalTask({super.key});

  @override
  State<HackerkernalTask> createState() => _HackerkernalTaskState();
}

class _HackerkernalTaskState extends State<HackerkernalTask> {
  bool isLogin = false;

  @override
  void initState() {
    loginStatus();
    super.initState();
  }

  loginStatus() async {
    isLogin = await SharedPref().getLoginStatus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingPage();
  }
}
