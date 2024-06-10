import 'package:emojies_test/reaction_package/reaction.dart';
import 'package:emojies_test/reaction_package/reaction_data.dart';
import 'package:flutter/material.dart';

class ReactionOverlay extends StatefulWidget {
  const ReactionOverlay({
    super.key,
    required this.onDismiss,
    required this.onPressReact,
    required this.relativeRect,
    required this.overlaySize,
    required this.reactions,
    this.backgroundColor,
    this.size,
  });
  final Function() onDismiss;
  final Function(ReactionAsset) onPressReact;
  final List<ReactionAsset> reactions;
  final RelativeRect relativeRect;
  final double overlaySize;
  final Color? backgroundColor;
  final Size? size;

  @override
  State<ReactionOverlay> createState() => _ReactionOverlayState();
}

class _ReactionOverlayState extends State<ReactionOverlay> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInSine,
    );
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          ModalBarrier(onDismiss: widget.onDismiss),
          Positioned.fromRelativeRect(
              rect: widget.relativeRect,
              child: ScaleTransition(
                scale: animation,
                child: Material(
                  type: MaterialType.card,
                  elevation: 0.5,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: widget.overlaySize,
                    constraints: const BoxConstraints(maxHeight: 60, minHeight: 60),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: widget.backgroundColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                         for(ReactionAsset reactionAsset in widget.reactions)
                          Reaction(
                            reactionAsset: reactionAsset,
                            onTap: widget.onPressReact,
                            index: reactionAsset,
                            size: widget.size ?? const Size(45, 45),
                          )
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
