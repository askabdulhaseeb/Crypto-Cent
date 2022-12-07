import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ContactImage extends StatefulWidget {
  const ContactImage({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final Contact contact;

  @override
  _ContactImageState createState() => _ContactImageState();
}

class _ContactImageState extends State<ContactImage> {
  late Future<Uint8List?> _imageFuture;

  @override
  void initState() {
    super.initState();
    _imageFuture = FastContacts.getContactImage(widget.contact.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: _imageFuture,
      builder: (context, snapshot) => Container(
        width: 56,
        height: 56,
        child: snapshot.hasData
            ? Image.memory(snapshot.data!, gaplessPlayback: true)
            : Icon(Icons.account_box_rounded),
      ),
    );
  }
}
