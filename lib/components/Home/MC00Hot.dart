import 'package:flutter/material.dart';

class Mc00hot extends StatefulWidget {
  const Mc00hot({super.key});

  @override
  State<Mc00hot> createState() => _Mc00hotState();
}

class _Mc00hotState extends State<Mc00hot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Text(
        "爆款推荐",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
      color: Colors.green,
    );
  }
}
