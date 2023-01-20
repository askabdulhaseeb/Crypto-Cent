import 'dart:io';

import 'package:flutter/material.dart';

class GetProductAttachments extends StatefulWidget {
  const GetProductAttachments({
    required this.file,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final List<File?> file;
  final VoidCallback onTap;
  @override
  // ignore: library_private_types_in_public_api
  _GetProductImageAttachments createState() => _GetProductImageAttachments();
}

class _GetProductImageAttachments extends State<GetProductAttachments> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - 32 - 20;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: widget.onTap,
              child: Container(
                height: (width / 3) * 2,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).secondaryHeaderColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    SizedBox(height: 16),
                    Icon(Icons.add_circle_rounded),
                    SizedBox(height: 6),
                    Text('Add Images'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: (width / 3) - 4,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(width: 5),
                    itemBuilder: (BuildContext context, int index) => _ImageBox(
                      index: index + 1,
                      width: width / 4,
                      file: widget.file[index],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: (width / 3) - 4,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(width: 5),
                    itemBuilder: (BuildContext context, int index) => _ImageBox(
                      index: index + 3,
                      width: width / 4,
                      file: widget.file[index + 2],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageBox extends StatelessWidget {
  const _ImageBox({
    required this.index,
    required double width,
    this.file,
    Key? key,
  })  : _width = width,
        super(key: key);

  final double _width;
  final int index;
  final File? file;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: SizedBox(
        height: _width,
        width: _width,
        child: (file == null)
            ? Container(
                height: double.infinity,
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                color: Theme.of(context).secondaryHeaderColor.withOpacity(0.3),
                child: FittedBox(
                  child: Text(
                    index.toString(),
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.08),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              )
            : SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image.file(File(file!.path)),
              ),
      ),
    );
  }
}
