import 'package:flutter/material.dart';
import 'package:mobile/flavors.dart';
import 'package:mobile/view/account_screen.dart';
import 'package:mobile/view/create_new_button.dart';
import 'package:mobile/view/home_screen.dart';
import 'package:mobile/view/playground_screen.dart';

class RootScreenDestination {
  final int index;
  final String title;
  final Widget body;
  final IconData icon;

  RootScreenDestination(this.index, this.title, this.body, this.icon);
}

final List<RootScreenDestination> rootScreenDestinations = [
  RootScreenDestination(0, 'Home', HomeScreen(), Icons.home),
  RootScreenDestination(1, 'Account', AccountScreen(), Icons.account_circle),
  F.appFlavor == Flavor.DEV
      ? RootScreenDestination(
          2, 'Playground', PlaygroundScreen(), Icons.airplay)
      : null,
].where((item) => item != null).toList();

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: rootScreenDestinations.map((e) => e.body).toList(),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Material(
      elevation: 4,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[500],
        currentIndex: _currentIndex,
        items: rootScreenDestinations
            .map(
              (item) => BottomNavigationBarItem(
                icon: Icon(item.icon),
                title: Text(item.title),
              ),
            )
            .toList(),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
