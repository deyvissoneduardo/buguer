import 'package:flutter/material.dart';

import '../helpers/size_extensions.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenShortestSide = context.screenShortestSide;
    return Container(
      width: screenShortestSide * .5,
      padding: EdgeInsets.only(top: context.percentHeight(.10)),
      child: Image.asset('assets/images/logo.png'),
    );
  }
}
