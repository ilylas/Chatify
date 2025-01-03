import 'package:chatify_app/widgets/rounded_image.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String name;
  final double height;
  final double width;
  final Function onPressed;

  const RoundedButton({super.key, required this.name, required this.height, required this.width, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height*0.25),
          color: Color.fromRGBO(0, 82, 218, 1.0)
      ),
      child: TextButton(
          onPressed: (){onPressed();},
          child:
          Text(
            name,
            style:
            TextStyle(
                fontSize: 22,
                color: Colors.white,
                height: 1.5
            ),
          )
      ),
    );
  }
}

class RoundedImageNetworkWithStatusIndicator extends RoundedImageNetwork{

  final bool isActive;

  const RoundedImageNetworkWithStatusIndicator({
    required Key key,
    required String imagePath,
    required double size,
    required this.isActive
  }) : super(key: key, imagePath: imagePath,size: size);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomRight,
      children: [
        super.build(context),
        Container(
          height: size *0.20,
          width: size * 0.20,
          decoration: BoxDecoration(
            color: isActive ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(size)
          ),
        )
      ],
    );
  }

}