import 'package:flutter/material.dart';
import 'package:gestapp/provider/transaction_provider.dart';
import 'package:gestapp/screens/summary_screen.dart';
import 'package:gestapp/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => TransactionProvider())], 
    child: const MyApp()
  )
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: AppTheme.ligtTheme,
      home: const SummaryScreen(),
    );
  }
}