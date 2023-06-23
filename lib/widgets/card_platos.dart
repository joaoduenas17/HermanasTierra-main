import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hdt_flutter/models/menu_model.dart';
import 'package:hdt_flutter/utils/const.dart';

class CardPlatos extends StatelessWidget {
  const CardPlatos({super.key, required this.menu, this.height, this.width, required this.onTap});
  final MenuModels menu;
  final double? height;
  final double? width;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.saturation),
                child: CachedNetworkImage(
                  imageUrl: menu.imagen,
                  progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: secundario,
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    debugPrint("Error: $error");
                    return const Icon(Icons.error);
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: FittedBox(
                  child: Text(
                    menu.nombre,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
