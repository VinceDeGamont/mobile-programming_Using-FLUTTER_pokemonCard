import 'package:flutter/material.dart';

class CustomImageNetwork extends StatelessWidget {
  final String imageUrl;
  final double? height;

  const CustomImageNetwork({super.key, required this.imageUrl, this.height});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      height: height,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }
}
