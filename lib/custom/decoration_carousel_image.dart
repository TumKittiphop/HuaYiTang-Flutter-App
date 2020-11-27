import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hua_yi_tang/helper/map_of_detail.dart';
import 'package:transparent_image/transparent_image.dart';

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
                      child: ClipRRect(
                        child: Stack(
                          children: <Widget>[
                            FadeInImage.memoryNetwork(
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: kTransparentImage,
                              image: imageUrl,
                            ),
                          ],
                        ),
                      ),
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
