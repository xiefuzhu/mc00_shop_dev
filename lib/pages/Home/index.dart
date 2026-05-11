import 'package:flutter/material.dart';
import 'package:mc00_shop/api/home.dart';
import 'package:mc00_shop/components/Home/MC00Category.dart';
import 'package:mc00_shop/components/Home/MC00Hot.dart';
import 'package:mc00_shop/components/Home/MC00MoreList.dart';
import 'package:mc00_shop/components/Home/MC00Recommend.dart';
import 'package:mc00_shop/components/Home/MC00Slider.dart';
import 'package:mc00_shop/utils/DioRequest.dart';
import 'package:mc00_shop/utils/ToastUtils.dart';
import 'package:mc00_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<BannerItem> _bannerlist = []; //轮播图
  List<CategoryItem> _categorylist = []; //分类列表
  List<RecommendItem> _recommendlist = []; //推荐列表
  ResultData _inVoguelist = ResultData(
    id: "",
    title: "",
    subTypes: [],
  ); //爆款推荐列表
  ResultData _oneStoplist = ResultData(
    id: "",
    title: "",
    subTypes: [],
  ); //一站式推荐列表
  @override
  void initState() {
    super.initState();
    // fetchBanner();
    // fetchCategory();
    // fetchRecommend();
    // fetchInVogue();
    // fetchOneStop();
    Future.microtask(() {
      _key.currentState?.show();
    });
    //显示刷新动画
    _regestEvent(); //监听滚动到底部的事件
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _regestEvent() {
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final isNearBottom =
        _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100;

    if (isNearBottom && !_bottomTriggered) {
      _bottomTriggered = true;
      fetchRecommend();
      return;
    }

    if (!isNearBottom) {
      _bottomTriggered = false;
    }
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

  bool _isLoading = false; //是否正在加载数据，初始为false
  bool _hasMore = true; //是否还有更多数据，初始为true
  bool _bottomTriggered = false; //避免同一次触底重复触发

  Future<void> fetchRecommend({bool reset = false}) async {
    if (_isLoading) return;
    if (!reset && !_hasMore) return;

    if (reset) {
      _hasMore = true;
      if (mounted) {
        setState(() {
          _recommendlist = [];
        });
      }
    }

    _isLoading = true;
    final data = await getRecommendListAPI();

    if (!mounted) {
      _isLoading = false;
      return;
    }

    setState(() {
      if (data.isEmpty) {
        _hasMore = false;
      } else if (reset) {
        _recommendlist = data;
      } else {
        _recommendlist.addAll(data);
      }
      _isLoading = false;
    });
  }

  void fetchInVogue() async {
    var data = await getInVogueListAPI();
    setState(() {
      _inVoguelist = data;
    });
  }

  void fetchOneStop() async {
    var data = await getOneStopListAPI();
    setState(() {
      _oneStoplist = data;
    });
  }

  Future<void> _onRefresh() async {
    _bottomTriggered = false;
    await Future.wait([
      Future.sync(fetchBanner),
      Future.sync(fetchCategory),
      fetchRecommend(reset: true),
      Future.sync(fetchInVogue),
      Future.sync(fetchOneStop),
    ]);
    ToastUtils.showToast(context, "刷新成功");
  }

  final ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      onRefresh: _onRefresh,
      child: CustomScrollView(
        controller: _scrollController, //绑定控制器
        slivers: _getScrollChildren(),
      ),
    );
  }

  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(child: Mc00slider(bannerlist: _bannerlist)), //轮播图
      SliverToBoxAdapter(child: SizedBox(height: 20)), //间距
      SliverToBoxAdapter(child: Mc00category(categorylist: _categorylist)), //分类
      SliverToBoxAdapter(child: SizedBox(height: 20)), //间距
      SliverToBoxAdapter(
        child: Mc00recommend(productlist: _recommendlist),
      ), //推荐
      SliverToBoxAdapter(child: SizedBox(height: 20)), //间距

      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: Mc00hot(hotlist: _inVoguelist)),
              SizedBox(width: 10),
              Expanded(child: Mc00hot(hotlist: _oneStoplist)),
            ],
          ),
        ), //爆款推荐
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)), //间距
      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        sliver: Mc00morelist(productlist: _recommendlist),
      ), //无限滚动（使用推荐商品渲染）
    ];
  }
}
