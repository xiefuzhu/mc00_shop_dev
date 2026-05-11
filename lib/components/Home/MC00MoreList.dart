import 'package:flutter/material.dart';
import 'package:mc00_shop/viewmodels/home.dart';

class Mc00morelist extends StatefulWidget {
  final List<dynamic> productlist;

  const Mc00morelist({super.key, required this.productlist});

  @override
  State<Mc00morelist> createState() => _Mc00morelistState();
}

class _Mc00morelistState extends State<Mc00morelist> {
  int _readSellCount(dynamic item) {
    if (item is RecommendItem) {
      return item.payCount;
    }

    if (item is GoodsItem) {
      return item.orderNum;
    }

    if (item is Map<String, dynamic>) {
      final payCount = item['payCount'];
      final orderNum = item['orderNum'];
      if (payCount is int) return payCount;
      if (orderNum is int) return orderNum;
      return int.tryParse(
            payCount?.toString() ?? orderNum?.toString() ?? '0',
          ) ??
          0;
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate:
          //网格一定要是两列
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
      itemCount: widget.productlist.length,
      itemBuilder: (BuildContext context, int index) {
        final item = widget.productlist[index];
        final picture = item.picture?.toString() ?? '';
        final name = item.name?.toString() ?? '';
        final price = item.price;
        final payCount = _readSellCount(item);
        final priceValue = price is num
            ? price.toDouble()
            : double.tryParse(price?.toString() ?? '0') ?? 0;
        return Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withAlpha(300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: picture.isNotEmpty
                    ? Image.network(
                        picture,
                        height: 110,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 110,
                          color: Colors.white24,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.white70,
                            size: 18,
                          ),
                        ),
                      )
                    : Container(
                        height: 110,
                        color: Colors.white24,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.white70,
                          size: 18,
                        ),
                      ),
              ),
              SizedBox(height: 8),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6),
              Text(
                "¥${priceValue.toStringAsFixed(2)}  ",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "${(priceValue + 20).toStringAsFixed(2)}",

                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withAlpha(300),
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Spacer(),
              Text(
                "已售 $payCount",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }
}
