import 'package:flutter/material.dart';
import 'package:flutter_hua_yi_tang/helper/map_of_detail.dart';
import 'package:flutter_hua_yi_tang/custom/custom_underline.dart';
import 'package:flutter_hua_yi_tang/widgets/google_map_container.dart';
import 'package:sa_multi_tween/sa_multi_tween.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum _AniProps {
  translateX,
  opacity,
}

class ContactUsScreen extends StatelessWidget {
  static const routeName = '/contact-us-screen';
  final MultiTween<_AniProps> _firstCardTween = MultiTween<_AniProps>()
    ..add(_AniProps.translateX, 300.0.tweenTo(0.0))
    ..add(_AniProps.opacity, 0.0.tweenTo(1.0));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ช่องทางการติดต่อ"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              GoogleMapContainer(),
              _LocationContainer(),
              SizedBox(
                height: 20,
              ),
              _OfficeHoursContainer(),
              SizedBox(
                height: 20,
              ),
              _SocialMediaContainer(),
              /**Offset for Bottom Nav Bar */
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialMediaContainer extends StatelessWidget {
  const _SocialMediaContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15),
      elevation: 7,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10, top: 20),
            width: double.infinity,
            child: Text(
              'อื่นๆ',
              style: TextStyle(fontSize: 22, fontStyle: FontStyle.italic),
              textAlign: TextAlign.left,
            ),
          ),
          CustomUnderline(
            width: 60,
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: CircleAvatar(
                backgroundImage: AssetImage('lib/assets/images/facebook.png')),
            title: Text(
              contactData['FB'],
              style: TextStyle(fontSize: 18),
            ),
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('lib/assets/images/line.png'),
            ),
            title: Text(
              contactData['LINE'],
              style: TextStyle(fontSize: 18),
            ),
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.grey[300],
                backgroundImage: AssetImage('lib/assets/images/phone.png')),
            title: Text(
              contactData['phone'],
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class _LocationContainer extends StatelessWidget {
  const _LocationContainer({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15),
      elevation: 7,
      child: Column(
        children: <Widget>[
          Container(
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 20),
                        child: Text(
                          'ที่ตั้งคลินิก',
                          style: TextStyle(
                              fontSize: 22, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      CustomUnderline(
                        width: 100,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, top: 4, bottom: 15),
                        child: Text(
                          contactData['address'],
                          style: TextStyle(fontSize: 18, height: 1.5),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () => {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                          width: 70,
                          height: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.navigation,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'นำทาง',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OfficeHoursContainer extends StatelessWidget {
  const _OfficeHoursContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15),
      elevation: 7,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10, top: 20),
            width: double.infinity,
            child: Text(
              'วันที่เปิดทำการ',
              style: TextStyle(fontSize: 22, fontStyle: FontStyle.italic),
              textAlign: TextAlign.left,
            ),
          ),
          CustomUnderline(
            width: 130,
          ),
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin:
                    EdgeInsets.only(left: 25, right: 25, top: 4, bottom: 15),
                width: double.infinity,
                child: Column(
                    children: openingDate
                        .map((eachDate) => Row(
                              children: [
                                Text(
                                  eachDate['day'],
                                  style: TextStyle(fontSize: 18, height: 1.5),
                                  textAlign: TextAlign.left,
                                ),
                                Expanded(
                                  flex: 5,
                                  child: SizedBox(),
                                ),
                                Text(
                                  eachDate['time'],
                                  style: TextStyle(fontSize: 18, height: 1.5),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ))
                        .toList()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
