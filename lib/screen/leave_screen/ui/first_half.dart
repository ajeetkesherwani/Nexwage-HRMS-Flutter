import 'package:flutter/material.dart';
class FirstHalfScreen extends StatefulWidget {
  const FirstHalfScreen({super.key});

  @override
  State<FirstHalfScreen> createState() => _FirstHalfScreenState();
}

class _FirstHalfScreenState extends State<FirstHalfScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('First Half'),
    );
  }
}
