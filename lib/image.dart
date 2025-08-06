import 'package:flutter/material.dart';

class InteractiveSpotlightBackground extends StatefulWidget {
  final String imagePath;
  final Widget child;

  const InteractiveSpotlightBackground({
    super.key,
    required this.imagePath,
    required this.child,
  });

  @override
  State<InteractiveSpotlightBackground> createState() =>
      _InteractiveSpotlightBackgroundState();
}

class _InteractiveSpotlightBackgroundState
    extends State<InteractiveSpotlightBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  Offset _mousePosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _animationController.forward(),
      onExit: (_) => _animationController.reverse(),
      onHover: (event) {
        setState(() {
          _mousePosition = event.localPosition;
        });
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Layer 1: The background image
          Image.asset(
            widget.imagePath,
            fit: BoxFit.cover,
            gaplessPlayback: true, // Prevents flicker on rebuild
          ),
          // Layer 2: The animated shadow/spotlight effect
          AnimatedBuilder(
            animation: _animation,
            builder: (context, _) {
              return ShaderMask(
                shaderCallback: (bounds) {
                  return RadialGradient(
                    center: Alignment(
                      (_mousePosition.dx / bounds.width) * 2 - 1,
                      (_mousePosition.dy / bounds.height) * 2 - 1,
                    ),
                    radius:
                        0.25 * _animation.value, // Increased radius slightly
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.9), // Slightly darker edge
                    ],
                    stops: const [0.0, 1.0],
                  ).createShader(bounds);
                },
                child: Container(color: Colors.black.withOpacity(0.85)),
              );
            },
          ),
          // Layer 3: The content passed to the widget
          widget.child,
        ],
      ),
    );
  }
}
