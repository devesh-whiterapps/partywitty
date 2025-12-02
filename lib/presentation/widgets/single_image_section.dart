import 'package:cached_network_image/cached_network_image.dart';
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
    this.fit = BoxFit.fill,
    this.loadingWidget,
    this.errorWidget,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: SizedBox(
        height: height,
        width: width,
        child: 

CachedNetworkImage(
  key: ValueKey(imageUrl),
  imageUrl: imageUrl,
  fit: fit,
  // Equivalent to the original loadingBuilder
  placeholder: (BuildContext context, String url) {
    // Show a loading indicator while the image is loading
    return loadingWidget ??
        Center(
          // Note: CachedNetworkImage's placeholder doesn't provide
          // the exact ImageChunkEvent. We use a standard
          // CircularProgressIndicator. If you need the progress value,
          // you should use the progressBuilder instead.
          child: CircularProgressIndicator(),
        );
  },
  // Equivalent to the original errorBuilder
  errorWidget: (BuildContext context, String url, dynamic error) {
    // Show an error icon and text if the image fails to load
    return  Container(
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