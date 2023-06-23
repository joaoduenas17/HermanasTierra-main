import 'package:flutter/material.dart';
import 'package:hdt_flutter/utils/const.dart';

class CardDetallesWidget extends StatelessWidget {
  const CardDetallesWidget({super.key, required this.text, required this.height, required this.image, required this.onpre});
  final String text;
  final String image;
  final double height;
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FittedBox(
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Image(
                    image: AssetImage(image),
                    fit: BoxFit.contain,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
