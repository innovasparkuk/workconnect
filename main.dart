import 'package:flutter/material.dart';
import 'package:upwork/loginPage.dart';
import 'package:upwork/payment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WorkConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor:  Color(0xFF3399FF),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        fontFamily: 'Poppins',
      ),
      home:  PaymentEscrowScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      ),
     // body:
    );
  }
}
