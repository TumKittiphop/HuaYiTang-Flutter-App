import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hua_yi_tang/screens/add_diagnosis_screen.dart';
import 'package:flutter_hua_yi_tang/screens/contact_us_screen.dart';
import 'package:flutter_hua_yi_tang/screens/diagnostic_screen.dart';
import 'package:flutter_hua_yi_tang/screens/medicine_explanation_screen.dart';
import 'package:flutter_hua_yi_tang/screens/personal_info_screen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main-screen';
  @override
  _MainSceenState createState() => _MainSceenState();
}

class _MainSceenState extends State<MainScreen> {
  bool _isLoading = true;
  int _currentIndex = 0;
  String userId;
  List<Widget> _widgetOptions;
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((value) {
      userId = value.uid;
      setState(() {
        _isLoading = false;
        final fbm = FirebaseMessaging();
        fbm.requestNotificationPermissions();
        fbm.configure(onMessage: (msg) {
          print('onmessage' + msg.toString());
          return;
        }, onLaunch: (msg) {
          print('lunch' + msg.toString());
          return;
        }, onResume: (msg) {
          print('resume' + msg.toString());
          return;
        });
        fbm.subscribeToTopic(userId);
      });
    });
    _widgetOptions = [
      DiagnosticScreen(),
      MedicineExplanationScreen(),
      ContactUsScreen(),
      PersonalInfoScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _widgetOptions[_currentIndex],
      // Move to Bottom Nav Bar (Personal Info Screen)
      // drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, //specify the location of the FAB
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed(AddDiagnosisScreen.routeName);
        },
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Icon(
            Icons.add,
            size: 27,
            color: Colors.white70,
          ),
        ),
        elevation: 2,
      ),
      bottomNavigationBar: FABBottomAppBar(
        color: Colors.grey,
        selectedColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          FABBottomAppBarItem(iconData: Icons.home, text: 'หน้าหลัก'),
          FABBottomAppBarItem(iconData: Icons.more_horiz, text: 'ประเภทยา'),
          FABBottomAppBarItem(iconData: Icons.navigation, text: 'ที่ตั้ง'),
          FABBottomAppBarItem(iconData: Icons.person, text: 'ตั้งค่า'),
        ],
      ),
      // Container(
      //   margin: EdgeInsets.only(left: 12.0, right: 12.0),
      //   height: 50,
      //   child: Row(
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: <Widget>[
      //       InkWell(
      //         radius: 10,
      //         borderRadius: BorderRadius.circular(10),
      //         onTap: () {},
      //         child: Column(
      //           mainAxisSize: MainAxisSize.min,
      //           children: [
      //             Icon(
      //               Icons.local_hospital,
      //               //darken the icon if it is selected or else give it a different color
      //               color: _currentIndex == 0
      //                   ? Colors.white
      //                   : Colors.grey.shade400,
      //             ),
      //             SizedBox(
      //               height: 10,
      //             ),
      //             Text(
      //               'หน้าหลัก',
      //               style: TextStyle(
      //                 color: Colors.white,
      //                 fontSize: 14,
      //                 letterSpacing: 0.5,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       IconButton(
      //         onPressed: () {
      //           setState(() {
      //             _currentIndex = 1;
      //           });
      //         },
      //         iconSize: 27.0,
      //         icon: Icon(
      //           Icons.shopping_cart,
      //           color:
      //               _currentIndex == 1 ? Colors.white : Colors.grey.shade400,
      //         ),
      //       ),
      //       //to leave space in between the bottom app bar items and below the FAB
      //       SizedBox(
      //         width: 60.0,
      //       ),
      //       IconButton(
      //         onPressed: () {
      //           setState(() {
      //             _currentIndex = 2;
      //           });
      //         },
      //         iconSize: 25.0,
      //         icon: Icon(
      //           Icons.favorite_border,
      //           color:
      //               _currentIndex == 2 ? Colors.white : Colors.grey.shade400,
      //         ),
      //       ),
      //       IconButton(
      //         onPressed: () {
      //           setState(() {
      //             _currentIndex = 3;
      //           });
      //         },
      //         iconSize: 25.0,
      //         icon: Icon(
      //           Icons.contact_mail,
      //           color:
      //               _currentIndex == 3 ? Colors.white : Colors.grey.shade400,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

class FABBottomAppBarItem {
  FABBottomAppBarItem({this.iconData, this.text});
  IconData iconData;
  String text;
}

class FABBottomAppBar extends StatefulWidget {
  final List<FABBottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;
  FABBottomAppBar({
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
  });
  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText ?? '',
              style: TextStyle(color: widget.color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.iconData, color: color, size: widget.iconSize),
                Text(
                  item.text,
                  style: TextStyle(color: color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
