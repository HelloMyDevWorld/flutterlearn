import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:discover/chat/main_chat.dart';
import 'package:discover/shop/screens/products_overview_screen.dart';
import 'package:discover/travel/screens/home.dart';
import 'package:discover/travel/widgets/icon_badge.dart';
import 'package:flutter/material.dart';

class MenuAppScreen {
  final Widget screen;
  final IconData icon;
  final bool isBadget;

  const MenuAppScreen({@required Widget screen, @required IconData icon, bool isBadget = false}) 
    : screen = screen,
      icon = icon,
      isBadget = isBadget;
}

class MainAppScreenNavigation extends StatefulWidget {
  @override
  _MainAppScreenNavigation createState() => _MainAppScreenNavigation();
}

class _MainAppScreenNavigation extends State<MainAppScreenNavigation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  int _selectedIndex = 0;

  final List<MenuAppScreen> _children = [
    new MenuAppScreen(screen: Home(), icon: Icons.home),
    new MenuAppScreen(screen: ProductsOverviewScreen(), icon: Icons.favorite),
    new MenuAppScreen(screen: Chat(), icon: Icons.mode_comment, isBadget: true),
    new MenuAppScreen(screen: Home(), icon: Icons.person),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget barIcon(
      {IconData icon = Icons.home, int page = 0, bool badge = false}) {
    return IconButton(
        icon: badge ? IconBadge(icon: icon, size: 24, badgeColor: Colors.blue) : Icon(icon, size: 24),
        color: _selectedIndex == page
            ? Theme.of(context).accentColor
            : Colors.blueGrey[300],
        onPressed: () => _onItemTapped(page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('MyShop'),
      // ),
      //drawer: AppDrawer(),
      body: _children[_selectedIndex].screen,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        items: _children
        .asMap()
        .map((index, menu) =>
            MapEntry(index, barIcon(icon: menu.icon, badge: menu.isBadget, page: index)))
        .values
        .toList(),
      //  onTap: _onItemTapped,
        index: _selectedIndex,
        height: 60,
      ),
    );
  }
}
