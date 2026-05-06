import 'package:flutter/material.dart';

class Mc00recommend extends StatefulWidget {
  const Mc00recommend({super.key});

  @override
  State<Mc00recommend> createState() => _Mc00recommendState();
}

class _Mc00recommendState extends State<Mc00recommend> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 200,
        child: Text(
          "推荐",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        color: Colors.red,
      ),
    );
  }
}
