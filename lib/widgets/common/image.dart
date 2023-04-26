import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../utils/colors.dart' show AppColors;

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder(
      {super.key, this.borderRadius = 25, this.width = 50, this.height = 50});
  final double borderRadius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Material(
          clipBehavior: Clip.hardEdge,
          color: AppColors.bg.borderContrast,
          child: const Icon(Icons.person, color: Colors.white),
        ),
      ),
    );
  }
}

class ImageOnNetwork extends HookWidget {
  const ImageOnNetwork({
    super.key,
    required this.imageURL,
    this.borderRadius = 25,
    this.height = 50,
    this.width = 50,
  });
  final String imageURL;
  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return imageURL.isEmpty
        ? ImagePlaceholder(
            borderRadius: borderRadius, width: width, height: height)
        : CachedNetworkImage(
            placeholder: (context, url) => const ImagePlaceholder(),
            imageUrl: imageURL,
            imageBuilder: (context, imageProvider) => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            errorWidget: (context, url, error) => const ImagePlaceholder(),
            width: width,
            height: height,
          );
  }
}
