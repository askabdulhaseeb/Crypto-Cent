import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../models/product/product_url.dart';
import '../../screens/product_screens/image_full_screen.dart';

class ProductURLsSlider extends StatelessWidget {
  const ProductURLsSlider({
    required this.urls,
    this.aspectRatio = 4 / 3,
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);
  final List<ProductURL> urls;
  final double aspectRatio;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: urls
          .map((ProductURL proDetail) => _Attachment(
                url: proDetail,
                totalLength: urls.length,
              ))
          .toList(),
      options: CarouselOptions(
        aspectRatio: 5 / 6,
        viewportFraction: 0.5,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
      ),
    );
  }
}

class _Attachment extends StatelessWidget {
  const _Attachment({required this.url, required this.totalLength, Key? key})
      : super(key: key);
  final ProductURL url;
  final int totalLength;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: double.infinity,
            child: InteractiveViewer(
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailScreen(
                        url: url.url,
                      );
                    }));
                  },
                  child: Hero(
                      tag: 'imageHero',
                      child: Image(image: NetworkImage( url.url),fit: BoxFit.fill,),
                  ))
            ),
          ),
          if (totalLength > 1)
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black45,
              ),
              child: Text(
                '${url.index + 1}/$totalLength',
                style: const TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}


class WebProductURLsSlider extends StatelessWidget {
  const WebProductURLsSlider({
    required this.urls,
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);
  final List<ProductURL> urls;

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      // height: 930/2,
      // width: 886/2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.network(urls[0].url,fit: BoxFit.fill,),
    );
    // return Column(
    //   children: urls.map((ProductURL proDetail) => _Attachments(
    //             url: proDetail,
    //             totalLength: urls.length,
    //           ))
    //       .toList(),
    // );
  }
}

class _Attachments extends StatelessWidget {
  const _Attachments({required this.url, required this.totalLength, Key? key})
      : super(key: key);
  final ProductURL url;
  final int totalLength;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        SizedBox(
          width: 200,
          height: 300,
          child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return DetailScreen(
                    url: url.url,
                  );
                }));
              },
              child: Hero(
                  tag: 'imageHero',
                  child: Image(image: NetworkImage( url.url),fit: BoxFit.fill,),
              )),
        ),
        if (totalLength > 1)
          Container(
            
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 8,
            ),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            child: Text(
              '${url.index + 1}/$totalLength',
              style: const TextStyle(color: Colors.white),
            ),
          ),
      ],
    );
  }
}
