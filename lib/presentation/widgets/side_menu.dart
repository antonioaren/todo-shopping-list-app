import 'package:flutter/material.dart';
import '../routes.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key, required this.title});

  final String title;

  // Create local state for the widget.
  @override
  State<SideMenu> createState() => _SideMenu();
}

class _SideMenu extends State<SideMenu> {
  // Here is the routes that we can use in the app.
  var _selectedIndex = 0;

  void _setIndexSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool _isMenuLabelsShowUp(double width) {
    return width >= 600;
  }

  @override
  Widget build(BuildContext context) {
    // This is a widget that gives us the constrains of the parent widget. We can make things responsive with this.
    return LayoutBuilder(builder: (context, constrains) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              // This is a widget that makes sure that the content is not behind the status bar or notch.
              child: NavigationRail(
                  extended: _isMenuLabelsShowUp(constrains.maxWidth),
                  destinations:
                      pageDestinations.map((e) => e.destination).toList(),
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _setIndexSelected),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: pageDestinations.elementAt(_selectedIndex).page,
              ),
            ),
          ],
        ),
      );
    });
  }
}
