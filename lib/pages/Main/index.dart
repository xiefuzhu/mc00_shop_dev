import 'package:flutter/material.dart';
import 'package:mc00_shop/pages/Cart/index.dart';
import 'package:mc00_shop/pages/Category/index.dart';
import 'package:mc00_shop/pages/Home/index.dart';
import 'package:mc00_shop/pages/Mine/index.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //定义数据,根据数据进行渲染的4个导航
  //一般应用的导航是固定的
  final List<Map<String, dynamic>> _tapList = [
    {
      "icon": Icons.home_outlined, //正常显示的图标
      "active_icon": Icons.home, //激活状态
      "text": "首页",
    },
    {
      "icon": Icons.category_outlined, //正常显示的图标
      "active_icon": Icons.category, //激活状态
      "text": "分类",
    },
    {
      "icon": Icons.shopping_cart_outlined, //正常显示的图标
      "active_icon": Icons.shopping_cart, //激活状态
      "text": "购物车",
    },
    {
      "icon": Icons.person_outline, //正常显示的图标
      "active_icon": Icons.person, //激活状态
      "text": "我的",
    },
  ];
  int _currentIndex = 0; //当前激活的索引

  //返回底部渲染的四个导航组件
  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(4, (int index) {
      return BottomNavigationBarItem(
        icon: Icon(_tapList[index]["icon"]!, size: 30), //正常图标
        activeIcon: Icon(_tapList[index]["active_icon"]!, size: 30), //激活图标
        label: _tapList[index]["text"], //文本
      );
    });
  }

  List<Widget> _getChildren() {
    return [HomeView(), CategoryView(), CartView(), MinePage()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MC00_Shop")),
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex, //根据当前激活的索引显示对应的组件
          children: _getChildren(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true, //显示未选中时的文本

        onTap: (int index) {
          _currentIndex = index; //更新当前激活的索引
          setState(() {}); //刷新页面
        },
        currentIndex: _currentIndex, //当前激活的索引
        items: _getTabBarWidget(),
      ),
    );
  }
}
