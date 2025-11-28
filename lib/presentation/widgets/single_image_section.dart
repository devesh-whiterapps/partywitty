import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class SingleImageSection extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final BoxFit fit;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Function onTap;

  const SingleImageSection({
    Key? key,
    required this.imageUrl,
    this.height = 450.0, // Default height
    this.width = 456.0,  // Default width
    this.fit = BoxFit.cover,
    this.loadingWidget,
    this.errorWidget,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap,
      child: SizedBox(
        height: height,
        width: width,
        child: Image.network(
          imageUrl,
          fit: fit,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child; // Image is fully loaded, show the image
            }
            // Show a loading indicator while the image is loading
            return loadingWidget ??
                Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
          },
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            // Show an error icon and text if the image fails to load
            return errorWidget ??
                Container(
                  color: Colors.grey[200], // Light grey background for error
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image,
                        color: Colors.grey[600],
                        size: 60,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Failed to load image',
                        style: TextStyle(color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
          },
        ),
      ),
    );
  }
}