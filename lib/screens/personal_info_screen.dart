import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hua_yi_tang/assets/style/style.dart';
import 'package:flutter_hua_yi_tang/custom/custom_divider.dart';
import 'package:flutter_hua_yi_tang/screens/add_diagnosis_explanation_screen.dart';
import 'package:flutter_hua_yi_tang/screens/edit_personal_credential_screen.dart';
import 'package:flutter_hua_yi_tang/screens/help_screen.dart';
import 'package:flutter_hua_yi_tang/screens/setting_screen.dart';
import 'package:flutter_hua_yi_tang/screens/toggle_notification_screen.dart';

class PersonalInfoScreen extends StatelessWidget {
  static const String routeName = '/personal-info-screen';

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              child: FutureBuilder(
                future: FirebaseAuth.instance.currentUser(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return StreamBuilder(
                    stream: Firestore.instance
                        .collection('user_credentials')
                        .document(userSnapshot.data.uid)
                        .snapshots(),
                    builder: (context, dataSnapshot) {
                      if (dataSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              child: Card(
                                elevation: 10,
                                margin: EdgeInsets.all(15),
                                child: InkWell(
                                  highlightColor: ownColors['Secondary'],
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      EditPersonalCredentialScreen.routeName,
                                      arguments: {
                                        'fullName':
                                            dataSnapshot.data['fullName'],
                                        'address': dataSnapshot.data['address'],
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 150,
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          flex: 4,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(100),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                child: Image.asset(
                                                  'lib/assets/images/male.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 8,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                height: 70,
                                                width: double.infinity,
                                                padding: EdgeInsets.only(
                                                  top: 30,
                                                ),
                                                child: Text(
                                                  dataSnapshot.data['fullName'],
                                                  textAlign: TextAlign.left,
                                                  softWrap: false,
                                                  overflow: TextOverflow.fade,
                                                  style:
                                                      TextStyle(fontSize: 28),
                                                ),
                                              ),
                                              Container(
                                                height: 80,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 2),
                                                      child: Text(
                                                        'ที่อยู่: ',
                                                        softWrap: true,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: _screenWidth * 0.4,
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Text(
                                                        dataSnapshot
                                                            .data['address'],
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                        softWrap: true,
                                                        overflow:
                                                            TextOverflow.fade,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Icon(Icons.navigate_next),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomDivider(),
                            _ListTileButton(
                              icon: Icons.settings,
                              text: 'ตั้งค่า',
                              onTapFn: () {
                                Navigator.of(context)
                                    .pushNamed(SettingScreen.routeName);
                              },
                            ),
                            CustomDivider(),
                            _ListTileButton(
                              icon: Icons.notifications_none,
                              text: 'แจ้งเตือน',
                              onTapFn: () {
                                Navigator.of(context).pushNamed(
                                    ToggleNotificationScreen.routeName);
                              },
                            ),
                            CustomDivider(),
                            _ListTileButton(
                              icon: Icons.live_help,
                              text: 'ช่วยเหลือ',
                              onTapFn: () {
                                Navigator.of(context)
                                    .pushNamed(HelpScreen.routeName);
                              },
                            ),
                            CustomDivider(),
                            _ListTileButton(
                              icon: Icons.apps,
                              text: 'เกี่ยวกับ',
                              onTapFn: () {
                                Navigator.of(context).pushNamed(
                                    AddDiagnosisExplanationScreen.routeName);
                              },
                            ),
                            CustomDivider(),
                            LogoutButton(),
                            CustomDivider(),
                            /**Offset for Bottom Nav Bar */
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListTileButton extends StatelessWidget {
  const _ListTileButton({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.onTapFn,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Function onTapFn;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFn,
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.black,
        ),
        title: Text(
          text,
          softWrap: true,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        trailing: Icon(
          Icons.navigate_next,
          color: Colors.black,
        ),
      ),
    );
  }
}

class LogoutButton extends StatefulWidget {
  const LogoutButton({
    Key key,
  }) : super(key: key);

  @override
  _LogoutButtonState createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  bool _isLoggingOut = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final fbm = FirebaseMessaging();
        setState(() {
          _isLoggingOut = true;
        });
        await fbm.deleteInstanceID();
        await FirebaseAuth.instance.signOut();
        setState(() {
          _isLoggingOut = false;
        });
      },
      child: ListTile(
        leading: Icon(
          Icons.exit_to_app,
          color: Colors.black,
        ),
        title: _isLoggingOut
            ? Text(
                'กำลังออกจากระบบ.....',
                softWrap: true,
                style: TextStyle(
                  fontSize: 18,
                ),
              )
            : Text(
                'ออกจากระบบ',
                softWrap: true,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
        trailing: Icon(
          Icons.navigate_next,
          color: Colors.black,
        ),
      ),
    );
  }
}
