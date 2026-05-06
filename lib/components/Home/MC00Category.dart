import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:mc00_shop/viewmodels/home.dart';

class Mc00category extends StatefulWidget {
  //分类列表
  final List<CategoryItem>? categorylist; //分类列表数据
  const Mc00category({super.key, required this.categorylist});

  @override
  State<Mc00category> createState() => _Mc00categoryState();
}

class _Mc00categoryState extends State<Mc00category> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.08,
      child: DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.categorylist?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              final category = widget.categorylist?[index];
              return Container(
                width: MediaQuery.sizeOf(context).width * 0.23,
                alignment: Alignment.center,

                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withAlpha(100),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      category?.picture ?? "",
                      width: 30,
                      height: 30,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error, size: 30);
                      },
                    ),
                    SizedBox(height: 5),
                    Text(category?.name ?? "", style: TextStyle(fontSize: 12)),
                  ],
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
              );
            },
          );
        },
      ),
    );
  }
}
