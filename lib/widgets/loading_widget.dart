import 'package:flutter/material.dart';

import '../core/theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey.withOpacity(0.5),
      child: Center(
        child: Container(
          color: Colors.white,
          child: Text(
            "Loading...",
            style: kTitleTextStyle,
          ),
        ),
      ),
    );
  }
}