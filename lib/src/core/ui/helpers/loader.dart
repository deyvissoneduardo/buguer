import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

mixin Loader<T extends StatefulWidget> on State<T> {
  var isOPen = false;

  void showLoader() {
    if (!isOPen) {
      isOPen = true;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => LoadingAnimationWidget.threeArchedCircle(
          color: Colors.white,
          size: 60,
        ),
      );
    }
  }

  void hiderLoader() {
    if (isOPen) {
      isOPen = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  void dispose() {
    hiderLoader();
    super.dispose();
  }
}
