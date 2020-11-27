import 'package:flutter/material.dart';

class ToggleNotificationScreen extends StatelessWidget {
  static const routeName = '/toggle-notification-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แจ้งเตือน'),
      ),
      body: Column(
        children: [
          _ListTileSwitch(
            icon: Icons.notification_important,
            text: 'แจ้งเตือนสำคัญ',
            onTapFn: null,
          ),
          _ListTileSwitch(
            icon: Icons.notifications_paused,
            text: 'แจ้งเตือนอื่นๆ',
            onTapFn: null,
          )
        ],
      ),
    );
  }
}

class _ListTileSwitch extends StatefulWidget {
  const _ListTileSwitch({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.onTapFn,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Function onTapFn;

  @override
  __ListTileSwitchState createState() => __ListTileSwitchState();
}

class __ListTileSwitchState extends State<_ListTileSwitch> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTapFn,
      child: ListTile(
        leading: Icon(
          widget.icon,
          color: Colors.black,
        ),
        title: Text(
          widget.text,
          softWrap: true,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        trailing: Switch(
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
              print('isSwitched');
            });
          },
          activeTrackColor: Colors.lightGreenAccent,
          activeColor: Colors.green,
        ),
      ),
    );
  }
}
