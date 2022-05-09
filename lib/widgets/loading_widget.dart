import 'package:flutter/material.dart';

import '../core/theme.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation = StepTween(begin: 0, end: 5).animate(_animationController);
    animation.addListener(() {
      setState(() {});
    });

    _animationController.repeat();
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey.withOpacity(0.5),
      child: Center(
        child: Container(
          color: Colors.white,
          child: Text(
            'Loading'+'.'*animation.value,
            style: kTitleTextStyle,
          ),
        ),
      ),
    );
  }
}
