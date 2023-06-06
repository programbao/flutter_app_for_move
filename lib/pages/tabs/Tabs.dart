import 'package:flutter/material.dart';
import 'Cart.dart';
import 'Home.dart';
import 'User.dart';
import 'Category.dart';
import '../../utils/ScreenAdapter.dart';
import '../../icons/FlightBookingAPPIconfont.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 1;
  late PageController _pageController;
  List<String> barIconNamesList = [
    'home',
    'discovery',
    'ticket',
    'profile',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
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
      appBar: _currentIndex == 0
          ? AppBar(
              // toolbarHeight: 40,
              leading: const IconButton(
                  onPressed: null,
                  icon: Icon(FlightBookingAPPIconfont.bz_flight_o)),
              title: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/search');
                },
                child: Container(
                  height: ScreenAdapter.height(60),
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.8),
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      const Icon(Icons.search),
                      Text('笔记本',
                          style: TextStyle(fontSize: ScreenAdapter.size(28)))
                    ],
                  ),
                ),
              ),
              actions: const [
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.message,
                      size: 28,
                      color: Colors.black87,
                    ))
              ],
            )
          : AppBar(
              title: Text('用户中心'),
            ),
      body: PageView(
        controller: _pageController,
        children: _pageList,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        physics: const NeverScrollableScrollPhysics(), // 禁止pageView滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.jumpToPage(_currentIndex);
            });
          },
          fixedColor: const Color.fromRGBO(31, 117, 236, 1),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(FlightBookingAPPIconfont.icons[_currentIndex == 0
                    ? '${barIconNamesList[0]}_fill'
                    : barIconNamesList[0]]),
                label: ("Home")),
            BottomNavigationBarItem(
                icon: Icon(FlightBookingAPPIconfont.icons[_currentIndex == 1
                    ? '${barIconNamesList[1]}_fill'
                    : barIconNamesList[1]]),
                label: ("Explore")),
            BottomNavigationBarItem(
                icon: Icon(FlightBookingAPPIconfont.icons[_currentIndex == 2
                    ? '${barIconNamesList[2]}_fill'
                    : barIconNamesList[2]]),
                label: ("My Ticket")),
            BottomNavigationBarItem(
                icon: Icon(FlightBookingAPPIconfont.icons[_currentIndex == 3
                    ? '${barIconNamesList[3]}_fill'
                    : barIconNamesList[3]]),
                label: ("My Profile")),
          ]),
    );
  }
}
