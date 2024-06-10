import 'package:emojies_test/reaction_package/reaction_data.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Reaction extends StatefulWidget {
  const Reaction({super.key, required this.reactionAsset, required this.onTap, required this.index, required this.size});
  final ReactionAsset reactionAsset;
  final ReactionAsset index;
  final Size size;
  final Function(ReactionAsset) onTap;

  @override
  State<Reaction> createState() => _ReactionState();
}

class _ReactionState extends State<Reaction> with TickerProviderStateMixin {
  late AnimationController iconScaleController;
  late AnimationController slideController;
  double padding = 0;
  @override
  void initState() {
    super.initState();
    iconScaleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    slideController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
  }

  @override
  void dispose() {
    iconScaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, -0.3)).animate(
        CurvedAnimation(
          curve: Curves.linear,
          parent: slideController,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          iconScaleController.forward().whenComplete(() async {
            widget.onTap(widget.index);
          });
        },
        onPanStart: (details) {
          slideController.forward();
          iconScaleController.forward();
          setState(() {
            padding = 10;
          });
        },
        onPanUpdate: (details) {
          slideController.forward();
          iconScaleController.forward();
          setState(() {
            padding = 10;
          });
        },
        onPanEnd: (details) {
          iconScaleController.reverse();
          slideController.reverse();
          setState(() {
            padding = 0;
          });
        },
        child: ScaleTransition(
          scale: Tween(begin: 1.0, end: 1.5).animate(
            CurvedAnimation(
              curve: Curves.fastEaseInToSlowEaseOut,
              parent: iconScaleController,
            ),
          ),
          child: AnimatedPadding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            duration: const Duration(milliseconds: 200),
            child: Lottie.asset(
              widget.reactionAsset.path,
              height: widget.size.height,
              width: widget.size.width,
            ),
            // Image(
            //   image:
            //       AssetImage(widget.path, package: "flutter_animated_reaction"),
            //   width: widget.size.width,
            //   height: widget.size.height,
            // ),
          ),
        ),
      ),
    );
  }
}
