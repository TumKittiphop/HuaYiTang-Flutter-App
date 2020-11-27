import 'package:flutter/material.dart';
import 'package:flutter_hua_yi_tang/custom/custom_underline.dart';
import 'package:flutter_hua_yi_tang/widgets/show_network_image.dart';

class WaitingForDiagnosisScreen extends StatelessWidget {
  static const routeName = '/waiting-for-diagnosis-screen';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    double _screenWidth = MediaQuery.of(context).size.width;
    String imageUrl = args['imageUrl'];

    String feverExplanation = args['feverExplanation'];
    String sweatExplanation = args['sweatExplanation'];
    String headacheExplanation = args['headacheExplanation'];
    String sleepingExplanation = args['sleepingExplanation'];
    String excretoryExplanation = args['excretoryExplanation'];
    String numbessExplanation = args['numbessExplanation'];
    String otherExplanation = args['otherExplanation'];
    return Scaffold(
      appBar: AppBar(
        title: Text('รอการวิเคราะห์'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: 10,
                  top: 30,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'อาการ',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CustomUnderline(width: 80),
              SizedBox(
                height: 20,
              ),
              ShowNetworkImage(imageUrl),
              Container(
                margin: EdgeInsets.only(left: 10, top: 20),
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  '** ข้อมูลของคุณจะได้รับการวิเคราะห์ภายใน 48 ชั่วโมง **',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  'ข้อมูล',
                  style: TextStyle(
                    height: 1.3,
                    fontSize: 18,
                  ),
                ),
              ),
              if (feverExplanation != null)
                TextContainer(
                  text: feverExplanation,
                  screenWidth: _screenWidth,
                ),
              if (sweatExplanation != null)
                TextContainer(
                  text: sweatExplanation,
                  screenWidth: _screenWidth,
                ),
              if (headacheExplanation != null)
                TextContainer(
                  text: headacheExplanation,
                  screenWidth: _screenWidth,
                ),
              if (sleepingExplanation != null)
                TextContainer(
                  text: sleepingExplanation,
                  screenWidth: _screenWidth,
                ),
              if (excretoryExplanation != null)
                TextContainer(
                  text: excretoryExplanation,
                  screenWidth: _screenWidth,
                ),
              if (numbessExplanation != null)
                TextContainer(
                  text: numbessExplanation,
                  screenWidth: _screenWidth,
                ),
              if (otherExplanation != null)
                TextContainer(
                  text: otherExplanation,
                  screenWidth: _screenWidth,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextContainer extends StatelessWidget {
  const TextContainer({
    Key key,
    @required this.text,
    @required this.screenWidth,
  }) : super(key: key);
  final double screenWidth;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10, top: 5),
            child: Text(
              '-',
              softWrap: true,
              style: TextStyle(height: 1.3, fontSize: 18),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, top: 5),
            width: screenWidth * 0.8,
            child: Text(
              text,
              softWrap: true,
              style: TextStyle(height: 1.3, fontSize: 18),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
