import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_hua_yi_tang/helper/map_of_detail.dart';
import 'package:flutter_hua_yi_tang/widgets/diagnosis_list.dart';

import 'package:flutter/material.dart';

class DiagnosticScreen extends StatefulWidget {
  @override
  _DiagnosticScreenState createState() => _DiagnosticScreenState();
}

class _DiagnosticScreenState extends State<DiagnosticScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          floating: true,
          pinned: true,
          delegate: MySliverAppBar(
            minHeight: 150,
            maxHeight: 300,
          ),
        ),

        // SliverToBoxAdapter(
        //   child: Column(
        //     children: [
        //       Container(
        //         width: double.infinity,
        //         margin: EdgeInsets.only(left: 10, top: 20),
        //         child: Text(
        //           'รายการ',
        //           style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
        //           textAlign: TextAlign.left,
        //         ),
        //       ),
        //       CustomUnderline(
        //         width: 100,
        //       ),
        //       SizedBox(
        //         height: 10,
        //       ),
        //     ],
        //   ),
        // ),
        DiagnosisList(),
        //offset for bottom navigation bar
        SliverToBoxAdapter(
          child: const SizedBox(
            height: 90,
          ),
        ),
      ],
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;

  MySliverAppBar({
    @required this.minHeight,
    @required this.maxHeight,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DecorationCarouselImage(),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black54],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'ฮัวอุยตึ๋ง',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                      fontFamily: 'Supermarket',
                    ),
                  ),
                  WidgetSpan(
                    child: SizedBox(
                      width: 10,
                    ),
                  ),
                  TextSpan(
                    text: 'คลินิคการแพทย์แผนจีน',
                    style: TextStyle(
                      color:
                          Colors.white.withOpacity(titleOpacity(shrinkOffset)),
                      fontSize: 25.0,
                      fontFamily: 'Supermarket',
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  double titleOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0
    //return 1.0 - max(0.0, shrinkOffset) / maxExtent;
    // more complex formula: starts fading out text when shrinkOffset > minExtent
    return max(0.0,
        1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent));
  }

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  bool shouldRebuild(MySliverAppBar oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight;
  }
}

class DecorationCarouselImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DecorationCarouselImageState();
  }
}

class _DecorationCarouselImageState extends State<DecorationCarouselImage> {
  List<Widget> imageSliders;
  @override
  void initState() {
    super.initState();
    imageSliders = decorationImage
        .map((imageUrl) => Container(
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Center(child: CircularProgressIndicator()),
                    Center(
                      child: Image.asset(
                        imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      // child: FadeInImage.memoryNetwork(
                      //   height: double.infinity,
                      //   width: double.infinity,
                      //   fit: BoxFit.cover,
                      //   placeholder: kTransparentImage,
                      //   image: imageUrl,
                      // ),
                    ),
                  ],
                ),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 1.0,
            height: 300,
            enlargeCenterPage: true,
          ),
        ),
      ]),
    );
  }
}
