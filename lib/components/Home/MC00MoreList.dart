import 'package:flutter/material.dart';

class Mc00morelist extends StatefulWidget {
  const Mc00morelist({super.key});

  @override
  State<Mc00morelist> createState() => _Mc00morelistState();
}

class _Mc00morelistState extends State<Mc00morelist> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate:
          //网格一定要是两列
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.blue,
          child: Text(
            "普通商品${index + 1}",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
