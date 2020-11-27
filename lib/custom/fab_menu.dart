import 'package:flutter/material.dart';
import 'package:flutter_hua_yi_tang/screens/add_diagnosis_explanation_screen.dart';
import 'package:flutter_hua_yi_tang/screens/add_diagnosis_screen.dart';

class FABMenu extends StatefulWidget {
  @override
  _FABMenuState createState() => _FABMenuState();
}

class _FABMenuState extends State<FABMenu> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _degOneTranslationAnimation, _degTwoTranslationAnimation;
  Animation _rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    _degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(_animationController);

    _degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(_animationController);

    // _degThreeTranslationAnimation = TweenSequence([
    //   TweenSequenceItem<double>(
    //       tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
    //   TweenSequenceItem<double>(
    //       tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    // ]).animate(_animationController);
    _rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        children: <Widget>[
          Positioned(
              right: 30,
              bottom: 30,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  /**Help for Navigation */
                  IgnorePointer(
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                    ),
                  ),
                  /**Add Button */
                  Transform.translate(
                    offset: Offset.fromDirection(getRadiansFromDegree(250),
                        _degOneTranslationAnimation.value * 100),
                    child: Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(_rotationAnimation.value))
                        ..scale(_degOneTranslationAnimation.value),
                      alignment: Alignment.center,
                      child: CircularButton(
                        color: Theme.of(context).primaryColorLight,
                        width: 50,
                        height: 50,
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onClick: () {
                          _animationController.reverse();
                          Navigator.of(context)
                              .pushNamed(AddDiagnosisScreen.routeName);
                        },
                      ),
                    ),
                  ),
                  /**Help button */
                  Transform.translate(
                    offset: Offset.fromDirection(getRadiansFromDegree(200),
                        _degTwoTranslationAnimation.value * 100),
                    child: Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(_rotationAnimation.value))
                        ..scale(_degTwoTranslationAnimation.value),
                      alignment: Alignment.center,
                      child: CircularButton(
                        color: Theme.of(context).primaryColorLight,
                        width: 50,
                        height: 50,
                        icon: Icon(
                          Icons.live_help,
                          color: Colors.white,
                        ),
                        onClick: () {
                          _animationController.reverse();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddDiagnosisExplanationScreen(),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Transform.translate(
                  //   offset: Offset.fromDirection(getRadiansFromDegree(180),
                  //       _degThreeTranslationAnimation.value * 100),
                  //   child: Transform(
                  //     transform: Matrix4.rotationZ(
                  //         getRadiansFromDegree(_rotationAnimation.value))
                  //       ..scale(_degThreeTranslationAnimation.value),
                  //     alignment: Alignment.center,
                  //     child: CircularButton(
                  //       color: Theme.of(context).primaryColorLight,
                  //       width: 50,
                  //       height: 50,
                  //       icon: Icon(
                  //         Icons.person,
                  //         color: Colors.white,
                  //       ),
                  //       onClick: () {
                  //         print('Third Button');
                  //       },
                  //     ),
                  //   ),
                  // ),
                  Transform(
                    transform: Matrix4.rotationZ(
                        getRadiansFromDegree(_rotationAnimation.value)),
                    alignment: Alignment.center,
                    child: CircularButton(
                      color: Theme.of(context).primaryColor,
                      width: 65,
                      height: 65,
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onClick: () {
                        if (_animationController.isCompleted) {
                          _animationController.reverse();
                        } else {
                          _animationController.forward();
                        }
                      },
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function onClick;

  CircularButton(
      {this.color, this.width, this.height, this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon, enableFeedback: true, onPressed: onClick),
    );
  }
}
