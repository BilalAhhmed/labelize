import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:labelize/project_theme.dart';
import 'package:labelize/view/bottomNavigationBarScreens/InfoScreen.dart';
import 'package:labelize/view/bottomNavigationBarScreens/NotificationScreen.dart';
import 'package:labelize/view/bottomNavigationBarScreens/SettingsScreen.dart';
import 'package:labelize/view/bottomNavigationBarScreens/home.dart';
// import 'file:///D:/Projects/labelize/lib/view/bottomNavigationBarScreens/home.dart';
import 'package:labelize/view/bottomNavigationBarScreens/wallet.dart';

class BottomNavigation extends StatefulWidget {
  static const routeName = '/Bbar';
  int index;
  BottomNavigation({this.index});
  @override
  _BottomNavigationState createState() => _BottomNavigationState();


}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 2;

  @override
  List<Widget> _children = [
    NotificationScreen(),
    WalletScreen(),
    HomeScreen(),
    SettingsScreen(),
    InfoScreen()
  ];

  PageController _pageController;



  @override
  void initState() {
    super.initState();
    //  _pageController = PageController();
    //  _currentIndex = 2;

    _currentIndex = widget.index??2;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return ColorfulSafeArea(
      color: ProjectTheme.projectBackgroundColor,
      child: Scaffold(
        bottomNavigationBar: Container(
            height: _height * 0.1,
            decoration: BoxDecoration(
              color: ProjectTheme.projectBackgroundColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 0),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                type: BottomNavigationBarType.fixed,
                backgroundColor: ProjectTheme.projectBackgroundColor,
                selectedLabelStyle: TextStyle(
                  fontSize: 14,
                ),
                selectedItemColor: Colors.black,
                items: [
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage(
                        'assets/1.png',
                      ),
                      size: 35,
                    ),
                    label: 'Notifications',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage(
                        'assets/2.png',
                      ),
                      size: 35,
                    ),
                    label: 'Wallet',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                        AssetImage(
                          'assets/3.png',
                        ),
                        size: 35),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                        AssetImage(
                          'assets/4.png',
                        ),
                        size: 35),
                    label: 'Settings',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                        AssetImage(
                          'assets/5.png',
                        ),
                        size: 35),
                    label: 'info',
                  ),
                ],
                onTap: (int index) {
                  setState(() {
                    _currentIndex = index;
                    _pageController.animateToPage(index,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeOut);
                  });
                },
              ),
            )),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: _children,
        ),
      ),
    );
  }
}
