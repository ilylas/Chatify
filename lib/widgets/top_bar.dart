import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String barTitle;
  final Widget? primaryAction;
  final Widget? secondryAction;
  final double? size;

  late double deviceheight;
  late double devicewidth;

  TopBar({super.key, required this.barTitle, this.primaryAction, this.secondryAction, this.size = 35});

  @override
  Widget build(BuildContext context) {
    deviceheight= MediaQuery.of(context).size.height;
    devicewidth= MediaQuery.of(context).size.width;
    return Container(
      height: deviceheight * 0.10,
      width: devicewidth,
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (secondryAction != null) secondryAction!,
            _titleBar(),
            if (primaryAction != null) primaryAction!,

          ]
      ),
    );
  }

  Widget _titleBar() {
    return Text(
      barTitle,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.white,
        fontSize: size,
        fontWeight: FontWeight.w700
      )
    );
  }

}

