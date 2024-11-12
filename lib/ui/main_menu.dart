import 'package:fakestore/ui/add_screen.dart';
import 'package:fakestore/ui/home_screen.dart';
import 'package:fakestore/ui/more_screen.dart';
import 'package:fakestore/ui/offer_screen.dart';
import 'package:fakestore/ui/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';

class MainMenu extends StatefulWidget {
  MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int visit = 0; // Current tab index
  final Color color2 = const Color(0XFF96B1FD);

  // List of tab items for the bottom navigation bar
  final List<TabItem> items = const [
    TabItem(icon: Icons.home, title: 'Home'),
    TabItem(icon: Icons.list_alt, title: 'Orders'),
    TabItem(icon: Icons.add_circle, title: 'Add'),
    TabItem(icon: Icons.local_offer, title: 'Offers'),
    TabItem(icon: Icons.more_horiz, title: 'More'),
  ];

  // PageController to manage page swipes
  final PageController _pageController = PageController();

  // Method to build screens
  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      OrderScreen(),
      AddScreen(),
      OfferScreen(),
      MoreScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Main Menu"),
      // ),
      body: Stack(
        children: [
          // PageView for swiping between screens
          PageView(
            controller: _pageController,  // Use _pageController
            onPageChanged: (index) {
              setState(() {
                visit = index;
              });
            },
            children: _buildScreens(),
          ),

          // Positioned Bottom Navigation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomBarInspiredOutside(
              items: items,
              backgroundColor: Colors.green,
              color: Color(0xECECECEF),
              colorSelected: Colors.white,
              indexSelected: visit,
              onTap: (int index) {
                // Set the visit index and update PageController
                setState(() {
                  visit = index;
                });
                // Ensure PageView is updated to the selected page
                _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
              },
              top: -28,
              animated: true,
              itemStyle: ItemStyle.hexagon,
              chipStyle: const ChipStyle(
                  background: Colors.green,
                  notchSmoothness: NotchSmoothness.smoothEdge),
            ),
          ),
        ],
      ),
    );
  }
}






// import 'package:fakestore/ui/add_screen.dart';
// import 'package:fakestore/ui/home_screen.dart';
// import 'package:fakestore/ui/more_screen.dart';
// import 'package:fakestore/ui/offer_screen.dart';
// import 'package:fakestore/ui/order_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
//
// class MainMenu extends StatefulWidget {
//    MainMenu({Key? key}) : super(key: key);
//
//   @override
//   _MainMenuState createState() => _MainMenuState();
// }
//
// class _MainMenuState extends State<MainMenu> {
//   late PersistentTabController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = PersistentTabController(initialIndex: 0);
//   }
//
//   List<Widget> _buildScreens() {
//     return [
//       HomeScreen(),
//       OrderScreen(),
//       AddScreen(),
//       OfferScreen(),
//       MoreScreen(),
//     ];
//   }
//
//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon:  Icon(Icons.home),
//         title: "Home",
//         activeColorPrimary: Colors.white,
//         inactiveColorPrimary: Color(0xECECECEF),
//       ),
//       PersistentBottomNavBarItem(
//         icon:  Icon(Icons.search),
//         title: "Order",
//         activeColorPrimary: Colors.white,
//         inactiveColorPrimary: Color(0xECECECEF),
//       ),
//       PersistentBottomNavBarItem(
//         icon:  Icon(Icons.add,color: Colors.black,),
//         title: "Add",
//         activeColorPrimary: Colors.white,
//         inactiveColorPrimary: Color(0xECECECEF),
//       ),
//       PersistentBottomNavBarItem(
//         icon:  Icon(Icons.message),
//         title: "Offer",
//         activeColorPrimary: Colors.white,
//         inactiveColorPrimary: Color(0xECECECEF),
//       ),
//       PersistentBottomNavBarItem(
//         icon:  Icon(Icons.settings),
//         title: "More",
//         activeColorPrimary: Colors.white,
//         inactiveColorPrimary: Color(0xECECECEF),
//       ),
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PersistentTabView(
//         context,
//         controller: _controller,
//         screens: _buildScreens(),
//         items: _navBarsItems(),
//         navBarStyle: NavBarStyle.style15,
//         // Set the nav bar style here
//         confineToSafeArea: true,
//         backgroundColor: Colors.green,
//         handleAndroidBackButtonPress: true,
//         resizeToAvoidBottomInset: false,
//         stateManagement: true,
//         hideNavigationBarWhenKeyboardAppears: true,
//         // popAllScreensOnTapOfSelectedTab: true,
//         // popActionScreens: PopActionScreensType.all,
//         // margin: EdgeInsets.all(10),
//         // padding: NavBarPadding.all(5),
//         navBarHeight: 50.0,
//       ),
//     );
//   }
// }
