import 'package:flutter/material.dart';

/// Entrance animation: fade only (no vertical slide — lateral route transition
/// already handles directional movement).
/// Lightweight — uses only built-in Flutter animation primitives.
class MPGFadeIn extends StatefulWidget {
  const MPGFadeIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 350),
  });

  final Widget child;
  final Duration delay;
  final Duration duration;

  @override
  State<MPGFadeIn> createState() => _MPGFadeInState();
}

class _MPGFadeInState extends State<MPGFadeIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);

    if (widget.delay == Duration.zero) {
      _ctrl.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _ctrl.forward();
      });
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _fade, child: widget.child);
  }
}
