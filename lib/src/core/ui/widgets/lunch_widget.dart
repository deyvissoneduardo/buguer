import 'package:flutter/material.dart';

import '../helpers/size_extensions.dart';

class LunchWidget extends StatelessWidget {
  const LunchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenShortestSide = context.screenShortestSide;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: screenShortestSide * .5,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/lanche.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
