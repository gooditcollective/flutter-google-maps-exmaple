import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../datasource.dart';
import 'card_info.dart';
import 'like_button.dart';

class MapPlaceCard extends StatelessWidget {
  final Place place;
  final bool isLiked;
  final VoidCallback likeTapHandler;

  static const double photoHeight = 132;
  static const double photoWidth = 109;

  const MapPlaceCard({
    Key? key,
    required this.place,
    required this.isLiked,
    required this.likeTapHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.black.withOpacity(0.24),
      shadowColor: Colors.black.withOpacity(0.24),
      borderRadius: BorderRadius.circular(12),
      elevation: 12,
      child: Stack(
        children: [
          Container(
            height: photoHeight,
            width: MediaQuery.of(context).size.width - 40,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: photoHeight,
                  width: photoWidth,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(place.photo),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width -
                              photoWidth -
                              72,
                        ),
                        child: Text(
                          place.name,
                          style: _titleTextStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      CardInfo(
                        align: MainAxisAlignment.start,
                        vibe: place.vibes.first,
                        occasion: place.occasions.first,
                        budget: place.budget.first,
                        textStyle: _infoTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 12,
            right: 12,
            child: LikeButton(
              isLiked: isLiked,
              onTap: likeTapHandler,
            ),
          ),
        ],
      ),
    );
  }

  final _titleTextStyle = const TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 17,
    height: 1.29411764706,
    decoration: TextDecoration.none,
    letterSpacing: -0.408,
    wordSpacing: -0.408,
    color: Colors.black,
  );
  final _infoTextStyle = const TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 12,
    height: 1.33333333333,
    decoration: TextDecoration.none,
    letterSpacing: 0,
    wordSpacing: 0,
    color: Colors.black,
  );
}
