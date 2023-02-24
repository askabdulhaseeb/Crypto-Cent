
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:fast_cached_network_image/src/models/fast_cache_progress_data.dart';
import 'package:flutter/material.dart';

import 'show_loading.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    required this.imageURL,
    this.fit = BoxFit.cover,
    this.timeLimit = const Duration(days: 2),
    Key? key,
  }) : super(key: key);
  final String imageURL;
  final BoxFit? fit;
  final Duration? timeLimit;

  @override
  Widget build(BuildContext context) {
    return FastCachedImage(
      url:  imageURL,
      fit: fit,
      errorBuilder:  (BuildContext context, Object exception, StackTrace? stacktrace) {
          return const Icon(Icons.error);
        },
        loadingBuilder:(BuildContext p0, FastCachedProgressData p1) {
          return const ShowLoading();
        },
     
      
    );
  }
}