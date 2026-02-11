import 'package:flutter/material.dart';
import 'package:jal_sanchalan/providers/login_provider.dart';
import 'package:jal_sanchalan/providers/master_provider.dart';
import 'package:provider/provider.dart';
import 'screens/Dashboard.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => MasterProvider()), // 👈 ADD THIS
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DashboardScreen(),
    );
  }
}
