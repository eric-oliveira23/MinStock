import 'package:flutter/widgets.dart';

class OpacityAnimator extends StatefulWidget {
  final VoidCallback? onTap;
  final double downOpacity;
  final int duration;
  final Widget child;

  const OpacityAnimator({
    Key? key,
    this.onTap,
    this.downOpacity = 0.5,
    this.duration = 50,
    required this.child,
  }) : super(key: key);

  @override
  State<OpacityAnimator> createState() => _OpacityAnimatorState();
}

class _OpacityAnimatorState extends State<OpacityAnimator> {
  double _opacity = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap?.call(),
      onTapDown: (details) => setState(() => _opacity = widget.downOpacity),
      onTapCancel: () => setState(() => _opacity = 1.0),
      onTapUp: (details) => setState(() => _opacity = 1.0),
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: Duration(milliseconds: widget.duration),
        child: widget.child,
      ),
    );
  }
}
