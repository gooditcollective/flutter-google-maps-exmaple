import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final bool isLiked;
  final VoidCallback onTap;

  const LikeButton({
    required this.isLiked,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  Color get _likeColor => isLiked ? const Color(0xfff9b9ad) : Colors.black;

  AssetImage get _likeIcon => isLiked
      ? const AssetImage('assets/icons/liked.png')
      : const AssetImage('assets/icons/not_liked.png');

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: ImageIcon(
        _likeIcon,
        color: _likeColor,
        size: 24,
        semanticLabel: 'like',
      ),
      iconSize: 24,
      onPressed: onTap,
    );
  }
}
