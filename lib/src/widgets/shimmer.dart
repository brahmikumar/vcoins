import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBlock extends StatelessWidget {
  double width;
  double height;
  ShimmerBlock(this.width, this.height, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
      baseColor: Colors.grey,
      highlightColor: Theme.of(context).primaryColor,
    );
  }
}
