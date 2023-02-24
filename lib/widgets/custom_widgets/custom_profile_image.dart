
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:fast_cached_network_image/src/models/fast_cache_progress_data.dart';
import 'package:flutter/material.dart';

import 'show_loading.dart';

class CustomProfileImage extends StatelessWidget {
  const CustomProfileImage({
    required this.imageURL,
    this.radius = 24,
    Key? key,
  }) : super(key: key);
  final String? imageURL;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return imageURL == null || (imageURL?.isEmpty ?? false)
        ? CircleAvatar(
            radius: radius - 2,
            child: CircleAvatar(
              radius: radius - 4,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: Icon(Icons.person, size: radius),
            ),
          )
        : FastCachedImage(
            url: imageURL!,
            fit: BoxFit.cover,

            // imageBuilder: (
            //   BuildContext context,
            //   ImageProvider<Object> imageProvider,
            // ) {
            //   return CircleAvatar(
            //     radius: radius,
            //     backgroundImage: imageProvider,
            //   );
            // },
            errorBuilder:  (BuildContext context, Object exception, StackTrace? stacktrace) {
          return const Icon(Icons.error);
        },
        loadingBuilder:(BuildContext p0,  FastCachedProgressData p1) {
          return const ShowLoading();
        },
          );
  }
}
