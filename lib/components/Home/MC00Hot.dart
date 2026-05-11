import 'package:flutter/material.dart';
import 'package:mc00_shop/viewmodels/home.dart';

class Mc00hot extends StatefulWidget {
  //接收爆款推荐数据
  final ResultData hotlist;

  const Mc00hot({super.key, required this.hotlist});

  @override
  State<Mc00hot> createState() => _Mc00hotState();
}

class _Mc00hotState extends State<Mc00hot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.hotlist.title.isNotEmpty ? widget.hotlist.title : "爆款推荐",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              itemCount: widget.hotlist.subTypes.length,
              separatorBuilder: (_, __) => SizedBox(height: 8),
              itemBuilder: (context, index) {
                final subType = widget.hotlist.subTypes[index];
                final imageUrl = subType.goodsItems?.items.isNotEmpty == true
                    ? subType.goodsItems!.items.first.picture
                    : "";
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: imageUrl.isNotEmpty
                            ? Image.network(
                                imageUrl,
                                width: 34,
                                height: 34,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  width: 34,
                                  height: 34,
                                  color: Colors.white24,
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Colors.white70,
                                    size: 16,
                                  ),
                                ),
                              )
                            : Container(
                                width: 34,
                                height: 34,
                                color: Colors.white24,
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: Colors.white70,
                                  size: 16,
                                ),
                              ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          subType.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
