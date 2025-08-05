import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../design/color.dart';

class LikeButton extends StatefulWidget {
  final bool initiallyLiked;
  final Function(bool)? onChanged;

  const LikeButton({super.key, this.initiallyLiked = false, this.onChanged});

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late bool _isLiked;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.initiallyLiked;
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(_isLiked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
        color: _isLiked ? AppColors.dashboardRed : AppColors.textSecondaryBlack,
      ),
      onPressed: _toggleLike,
    );
  }
}
