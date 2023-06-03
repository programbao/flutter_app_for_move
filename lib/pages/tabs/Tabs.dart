import 'package:flutter/material.dart';
import 'Cart.dart';
import 'Home.dart';
import 'User.dart';
import 'Category.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 1;
  late PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = new PageController(initialPage: _currentIndex);
  }

  final List<Widget> _pageList = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    UserPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('贝贝电影'),
      ),
      body: PageView(
        controller: _pageController,
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.jumpToPage(_currentIndex);
            });
          },
          fixedColor: Colors.red,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ("首页")),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: ("分类")),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: ("购物车")),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: ("我的")),
          ]),
    );
  }
}
