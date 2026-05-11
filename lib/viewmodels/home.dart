class BannerItem {
  String id;
  String imageUrl;
  BannerItem({required this.id, required this.imageUrl});
  factory BannerItem.fromJson(Map<String, dynamic> json) {
    //网页返回json数据

    return BannerItem(
      id: json['id']?.toString() ?? "", //怎么我代码又变成deadcode了
      imageUrl: json['imgUrl']?.toString() ?? "",
    );
  } //工厂构造函数，接受一个json对象，返回一个BannerItem实例
  //最好能把。。。
}

class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem>? children; //子分类列表
  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
  });
  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id']?.toString() ?? "",
      name: json['name']?.toString() ?? "",
      picture: json['picture']?.toString() ?? "",
      children: json['children'] != null
          ? (json['children'] as List)
                .map((item) => CategoryItem.fromJson(item))
                .toList()
          : null,
    );
  }
}

class GoodsItem {
  String id;
  String name;
  String? desc;
  String price;
  String picture;
  int orderNum;

  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });

  factory GoodsItem.fromJson(Map<String, dynamic> json) {
    return GoodsItem(
      id: json['id']?.toString() ?? "",
      name: json['name']?.toString() ?? "",
      desc: json['desc']?.toString(),
      price: json['price']?.toString() ?? "",
      picture: json['picture']?.toString() ?? "",
      orderNum: json['orderNum'] is int
          ? json['orderNum']
          : int.tryParse(json['orderNum']?.toString() ?? "0") ?? 0,
    );
  }
}

class GoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodsItem> items;

  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory GoodsItems.fromJson(Map<String, dynamic> json) {
    return GoodsItems(
      counts: json['counts'] is int
          ? json['counts']
          : int.tryParse(json['counts']?.toString() ?? "0") ?? 0,
      pageSize: json['pageSize'] is int
          ? json['pageSize']
          : int.tryParse(json['pageSize']?.toString() ?? "0") ?? 0,
      pages: json['pages'] is int
          ? json['pages']
          : int.tryParse(json['pages']?.toString() ?? "0") ?? 0,
      page: json['page'] is int
          ? json['page']
          : int.tryParse(json['page']?.toString() ?? "0") ?? 0,
      items: json['items'] != null
          ? (json['items'] as List).map((e) => GoodsItem.fromJson(e)).toList()
          : [],
    );
  }
}

class SubType {
  String id;
  String title;
  GoodsItems? goodsItems;

  SubType({required this.id, required this.title, this.goodsItems});

  factory SubType.fromJson(Map<String, dynamic> json) {
    return SubType(
      id: json['id']?.toString() ?? "",
      title: json['title']?.toString() ?? "",
      goodsItems: json['goodsItems'] != null
          ? GoodsItems.fromJson(json['goodsItems'])
          : null,
    );
  }
}

class ResultData {
  String id;
  String title;
  List<SubType> subTypes;

  ResultData({required this.id, required this.title, required this.subTypes});

  factory ResultData.fromJson(Map<String, dynamic> json) {
    return ResultData(
      id: json['id']?.toString() ?? "",
      title: json['title']?.toString() ?? "",
      subTypes: json['subTypes'] != null
          ? (json['subTypes'] as List).map((e) => SubType.fromJson(e)).toList()
          : [],
    );
  }
}

class RecommendItem {
  String id;
  String name;
  double price;
  String picture;
  int payCount;

  RecommendItem({
    required this.id,
    required this.name,
    required this.price,
    required this.picture,
    required this.payCount,
  });

  factory RecommendItem.fromJson(Map<String, dynamic> json) {
    return RecommendItem(
      id: json['id']?.toString() ?? "",
      name: json['name']?.toString() ?? "",
      price: double.tryParse(json['price']?.toString() ?? "0") ?? 0,
      picture: json['picture']?.toString() ?? "",
      payCount: json['payCount'] is int
          ? json['payCount']
          : int.tryParse(json['payCount']?.toString() ?? "0") ?? 0,
    );
  }
}

class GoodsDetailItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodsItem> items;

  GoodsDetailItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory GoodsDetailItems.fromJson(Map<String, dynamic> json) {
    return GoodsDetailItems(
      counts: json['counts'] is int
          ? json['counts']
          : int.tryParse(json['counts']?.toString() ?? "0") ?? 0,
      pageSize: json['pageSize'] is int
          ? json['pageSize']
          : int.tryParse(json['pageSize']?.toString() ?? "0") ?? 0,
      pages: json['pages'] is int
          ? json['pages']
          : int.tryParse(json['pages']?.toString() ?? "0") ?? 0,
      page: json['page'] is int
          ? json['page']
          : int.tryParse(json['page']?.toString() ?? "0") ?? 0,
      items: json['items'] != null
          ? (json['items'] as List).map((e) => GoodsItem.fromJson(e)).toList()
          : [],
    );
  }
}
