import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
        : CachedNetworkImage(
            imageUrl: imageURL!,
            fit: BoxFit.cover,
            imageBuilder: (
              BuildContext context,
              ImageProvider<Object> imageProvider,
            ) {
              return CircleAvatar(
                radius: radius,
                backgroundImage: imageProvider,
              );
            },
            progressIndicatorBuilder: (BuildContext context, String url,
                    DownloadProgress downloadProgress) =>
                Center(
                    child: Text(
              'loading...  ${downloadProgress.progress?.toStringAsFixed(1) ?? ''}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.grey),
            )),
            errorWidget: (BuildContext context, String url, dynamic _) =>
                const Icon(Icons.error, color: Colors.grey),
          );
  }
}
