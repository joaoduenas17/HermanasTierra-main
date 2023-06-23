import 'package:flutter/material.dart';
import 'package:hdt_flutter/utils/const.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.text, required this.onpre, required this.image, required this.widthimage, required this.heightimage, required this.height, this.posicion = true});
  final String text;
  final String image;
  final double height;
  final double widthimage;
  final double heightimage;
  final bool posicion;
  final Null Function() onpre;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: principal,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onpre,
            child: posicion ? textup() : dowtext(),
          ),
        ),
      ),
    );
  }

  Widget dowtext() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 0, top: 8, bottom: 0),
          child: Image(
            image: AssetImage(image),
            fit: BoxFit.contain,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget textup() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        text == ""
            ? Container()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'FutuBk',
                      ),
                    ),
                  ],
                ),
              ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 0, top: 8, bottom: 0),
            child: Image(
              image: AssetImage(image),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
