import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ShowNetworkImage extends StatelessWidget {
  final String imageUrl;
  ShowNetworkImage(this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Stack(
        children: <Widget>[
          Center(child: CircularProgressIndicator()),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: FadeInImage.memoryNetwork(
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                placeholder: kTransparentImage,
                image: imageUrl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
