import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hua_yi_tang/assets/style/style.dart';
import 'package:flutter_hua_yi_tang/custom/custom_divider.dart';
import 'package:flutter_hua_yi_tang/screens/add_diagnosis_explanation_screen.dart';
import 'package:flutter_hua_yi_tang/screens/edit_personal_credential_screen.dart';
import 'package:flutter_hua_yi_tang/screens/medicine_explanation_screen.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  Widget _listTile(IconData icon, String text) {
    return ListTile(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final double _drawerWidth = MediaQuery.of(context).size.width * 0.75;
    return Container(
      width: _drawerWidth,
      child: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Stack(
          children: <Widget>[
            ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  child: FutureBuilder(
                    future: FirebaseAuth.instance.currentUser(),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
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
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Card(
                                      elevation: 10,
                                      margin: EdgeInsets.all(10),
                                      child: InkWell(
                                        highlightColor: ownColors['Secondary'],
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                            EditPersonalCredentialScreen
                                                .routeName,
                                            arguments: {
                                              'fullName':
                                                  dataSnapshot.data['fullName'],
                                              'address':
                                                  dataSnapshot.data['address'],
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: 120,
                                          child: IntrinsicHeight(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                SizedBox(
                                                  width: _drawerWidth * 0.05,
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(30),
                                                  ),
                                                  child: Container(
                                                    width: _drawerWidth * 0.2,
                                                    height: _drawerWidth * 0.2,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
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
                                                SizedBox(
                                                  width: _drawerWidth * 0.05,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Text(
                                                        dataSnapshot
                                                            .data['fullName'],
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 25),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Container(
                                                          child: Text(
                                                            'ที่อยู่: ',
                                                            softWrap: true,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ),
                                                        Container(
                                                          width: _drawerWidth *
                                                              0.4,
                                                          child: Text(
                                                            dataSnapshot.data[
                                                                'address'],
                                                            softWrap: true,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: _drawerWidth * 0.05,
                                                ),
                                                Icon(Icons.navigate_next),
                                                SizedBox(
                                                  width: _drawerWidth * 0.05,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomDivider(),
                                InkWell(
                                  highlightColor: ownColors['Secondary'],
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        AddDiagnosisExplanationScreen
                                            .routeName);
                                  },
                                  child: _listTile(
                                    Icons.scatter_plot,
                                    'ขั้นตอนการส่งอาการ',
                                  ),
                                ),
                                CustomDivider(),
                                InkWell(
                                  highlightColor: ownColors['Secondary'],
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        MedicineExplanationScreen.routeName);
                                  },
                                  child: _listTile(
                                    Icons.more,
                                    'ประเภทยา',
                                  ),
                                ),
                                CustomDivider(),
                                InkWell(
                                  highlightColor: ownColors['Secondary'],
                                  onTap: () {},
                                  child: _listTile(
                                    Icons.question_answer,
                                    'สอบถามข้อมูลเพิ่มเติม',
                                  ),
                                ),
                                CustomDivider(),
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
            Positioned(
              bottom: 5,
              left: 10,
              right: 10,
              child: LogoutButton(),
            ),
          ],
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
    return _isLoggingOut
        ? Center(
            child: CircularProgressIndicator(),
          )
        : RaisedButton(
            onPressed: () async {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.exit_to_app),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'ออกจากระบบ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          );
  }
}
