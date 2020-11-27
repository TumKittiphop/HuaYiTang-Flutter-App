import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hua_yi_tang/helper/map_of_detail.dart';
import 'package:transparent_image/transparent_image.dart';

class CarouselImage extends StatefulWidget {
  final String medicineType;
  CarouselImage(this.medicineType);
  @override
  State<StatefulWidget> createState() {
    return _CarouselImageState();
  }
}

class _CarouselImageState extends State<CarouselImage> {
  List<Widget> imageSliders;
  int _current = 0;
  @override
  void initState() {
    super.initState();
    imageSliders = medicineImageUrl[widget.medicineType]
        .map((imageUrl) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: Stack(
                  children: <Widget>[
                    Center(child: CircularProgressIndicator()),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Stack(
                          children: <Widget>[
                            FadeInImage.memoryNetwork(
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                              placeholder: kTransparentImage,
                              image: imageUrl,
                            ),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(200, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: Text(
                                  'No. ${medicineImageUrl[widget.medicineType].indexOf(imageUrl)} image',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
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
    return Column(children: [
      CarouselSlider(
        items: imageSliders,
        options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: medicineImageUrl[widget.medicineType].map((url) {
          int index = medicineImageUrl[widget.medicineType].indexOf(url);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index
                  ? Color.fromRGBO(0, 0, 0, 0.9)
                  : Color.fromRGBO(0, 0, 0, 0.4),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
