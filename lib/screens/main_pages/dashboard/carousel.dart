import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final List<String> imageList = [
    "assets/images/1.jpeg",
    "assets/images/2.jpeg",
    "assets/images/3.jpeg",
    "assets/images/4.jpeg",
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GFCarousel(
        pagination: true,
        autoPlay: true,
        height: 150,
        items: imageList.map(
          (url) {
            return Container(
              margin: EdgeInsets.all(2.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Image.asset(
                    url,
                    fit: BoxFit.cover,
                    width: 1000.0,
                    height: 200,
                  )),
            );
          },
        ).toList(),
        onPageChanged: (index) {
          setState(() {
            index;
          });
        },
      ),
    );
  }
}
