import 'package:flutter/material.dart';
import 'package:mc00_shop/api/home.dart';
import 'package:mc00_shop/components/Home/MC00Category.dart';
import 'package:mc00_shop/components/Home/MC00Hot.dart';
import 'package:mc00_shop/components/Home/MC00MoreList.dart';
import 'package:mc00_shop/components/Home/MC00Recommend.dart';
import 'package:mc00_shop/components/Home/MC00Slider.dart';
import 'package:mc00_shop/utils/DioRequest.dart';
import 'package:mc00_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<BannerItem> _bannerlist = []; //轮播图
  List<CategoryItem> _categorylist = []; //分类列表
  @override
  void initState() {
    super.initState();
    fetchBanner();
    fetchCategory();
  }

  void fetchBanner() async {
    var data = await dioRequest.get("/home/banner");
    setState(() {
      _bannerlist = (data as List).map((e) => BannerItem.fromJson(e)).toList();
    });
  }

  void fetchCategory() async {
    var data = await getCategoryListAPI();
    setState(() {
      _categorylist = data;
    });
  }

  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(child: Mc00slider(bannerlist: _bannerlist)), //轮播图
      SliverToBoxAdapter(child: SizedBox(height: 20)), //间距
      SliverToBoxAdapter(child: Mc00category(categorylist: _categorylist)), //分类
      SliverToBoxAdapter(child: SizedBox(height: 20)), //间距
      SliverToBoxAdapter(child: Mc00recommend()), //推荐
      SliverToBoxAdapter(child: SizedBox(height: 20)), //间距

      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: Mc00hot()),
              SizedBox(width: 10),
              Expanded(child: Mc00hot()),
            ],
          ),
        ), //爆款推荐
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)), //间距
      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        sliver: Mc00morelist(),
      ), //无限滚动
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: _getScrollChildren(), //减少build里面内容
    );
    // return Center(
    //   child: Text(
    //     "首页",
    //     style: TextStyle(
    //       fontSize: 30,
    //       fontWeight: FontWeight.bold,
    //       color: Theme.of(context).brightness == Brightness.dark
    //           ? Colors.white
    //           : Colors.black,
    //     ),
    //   ),
    // );
  }
}
