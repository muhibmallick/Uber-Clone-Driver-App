import 'package:flutter/material.dart';
import '../TabPages/Home_tab.dart';
import '../TabPages/Profile_tab.dart';

import '../TabPages/earning_tab.dart';
import '../tabPages/ratings_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;

  OnItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          HomeTabPage(),
          EarningsTabPage(),
          RatingsTabPage(),
          ProfileTabPage(),
        ],
      ),

      // ***********BOTTOM NAVIGATION***********/
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          //***********BOTTOM NAVIGATION ITEMS 1 ***********/
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          //***********BOTTOM NAVIGATION ITEMS 2 ***********/
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: "Earning",
          ),
          //***********BOTTOM NAVIGATION ITEMS 3 ***********/
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Rating",
          ),
          //***********BOTTOM NAVIGATION ITEMS 4 ***********/
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Accounts",
          ),
        ],
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 14),
        showSelectedLabels: true,
        currentIndex: selectedIndex,
        onTap: OnItemClicked,
      ),
    );
  }
}
