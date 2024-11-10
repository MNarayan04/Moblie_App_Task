import 'package:flutter/material.dart';
import 'package:hackerkernel_task/hackerkernel_task.dart';
import 'package:hackerkernel_task/src/presentation/provider/product_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1C6EE7)),
          useMaterial3: true,
        ),
        home: const HackerkernalTask(),
      ),
    );
  }
}
