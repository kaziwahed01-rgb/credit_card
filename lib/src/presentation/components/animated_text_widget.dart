import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedTextWidget extends StatefulWidget {
  const AnimatedTextWidget({
    super.key,
    required this.text,
    required this.style,
  });

  final String text;
  final TextStyle style;

  @override
  State<AnimatedTextWidget> createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget> {
  Timer? _revealTimer;
  int _displayedCharacters = 0;

  @override
  void initState() {
    super.initState();
    _animateTextAppearance();
  }

  @override
  void didUpdateWidget(AnimatedTextWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _revealTimer?.cancel();
      _displayedCharacters = 0;
      _animateTextAppearance();
    }
  }

  void _animateTextAppearance() {
    _revealTimer?.cancel();

    if (_displayedCharacters < widget.text.length) {
      _revealTimer = Timer(const Duration(milliseconds: 30), () {
        if (!mounted) {
          return;
        }

        setState(() {
          _displayedCharacters++;
        });
        _animateTextAppearance();
      });
    }
  }

  @override
  void dispose() {
    _revealTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayedText = widget.text.substring(
      0,
      _displayedCharacters.clamp(0, widget.text.length),
    );

    return Text(displayedText, style: widget.style);
  }
}
