import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class RoundedImageNetwork extends StatelessWidget{
  final String imagePath;
  final double size;

  const RoundedImageNetwork({super.key, required this.imagePath, required this.size});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imagePath),
        ),
      borderRadius: BorderRadius.all(Radius.circular(size)),
      color: Colors.black,
      ),
    );
  }
}

class RoundedImageFile extends StatelessWidget{

  final PlatformFile image;
  final double size;

  const RoundedImageFile({super.key, required this.image, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: FileImage(File(image.path!)),
        ),
        borderRadius: BorderRadius.all(Radius.circular(size)),
        color: Colors.black,
      ),
    );
  }


}