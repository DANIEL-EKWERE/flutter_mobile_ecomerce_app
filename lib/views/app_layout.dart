import 'package:ecommerce1/views/Homescreen.dart';
import 'package:ecommerce1/views/favorites_screen.dart';
import 'package:ecommerce1/views/cart_screen.dart';
import 'package:ecommerce1/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int selectedIndex = 0;
  bool isChecked = false;
  int currentIndex = 1;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const FavoritesScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: selectedIndex == 0
                  ? SvgPicture.asset('assest/images/home.svg')
                  : SvgPicture.asset('assest/images/home_unselected.svg'),
              label: "Home"),
          BottomNavigationBarItem(
              icon: selectedIndex == 1
                  ? SvgPicture.asset('assest/images/favourite.svg')
                  : SvgPicture.asset('assest/images/favorite1_unselected.svg'),
              label: "Favorites"),
          BottomNavigationBarItem(
              icon: selectedIndex == 2
                  ? SvgPicture.asset('assest/images/cart.svg')
                  : SvgPicture.asset('assest/images/cart_unselected.svg'),
              label: "Cart"),
          BottomNavigationBarItem(
              icon: selectedIndex == 3
                  ? SvgPicture.asset('assest/images/profile.svg')
                  : SvgPicture.asset('assest/images/profile_unselected.svg'),
              label: "Profile"),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
