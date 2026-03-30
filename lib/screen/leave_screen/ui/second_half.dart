import 'package:flutter/material.dart';
class SecondHalfScreen extends StatefulWidget {
  const SecondHalfScreen({super.key});

  @override
  State<SecondHalfScreen> createState() => _SecondHalfScreenState();
}

class _SecondHalfScreenState extends State<SecondHalfScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Second Half'),
    );
  }
}
