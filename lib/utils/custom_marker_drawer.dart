import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarker {
  final BitmapDescriptor marker;
  final double anchorDy;
  final double anchorDx;

  CustomMarker({
    required this.marker,
    required this.anchorDy,
    required this.anchorDx,
  });
}

class CustomMarkerDrawer {
  static const double canvasWidth = 98;
  static const double canvasHeight = 64;

  static const double defaultIconWidth = 20;
  static const double defaultIconHeight = 22;

  static const double likedIconWidth = 18.41;
  static const double likedIconHeight = 16.36;

  static const double selectedIconWidth = 26.408;
  static const double selectedIconHeight = 30;

  static const String likedPath = "assets/icons/map_place_favorite.png";
  static const String defaultPath = "assets/icons/map_place.png";
  static const String likedSelectedPath =
      "assets/icons/selected_map_place_favorite.png";
  static const String defaultSelectedPath =
      "assets/icons/selected_map_place.png";

  Future<CustomMarker> createCustomMarkerBitmap({
    required String title,
    required bool isLiked,
    required bool isSelected,
    required double scale,
    required bool showText,
  }) async {
    final scaledCanvasWidth = canvasWidth * scale;
    final scaledCanvasHeight = canvasHeight * scale;

    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(
      recorder,
      Rect.fromLTWH(
        0,
        0,
        scaledCanvasWidth,
        scaledCanvasHeight,
      ),
    );

    final imageHeight = await paintMarkerImage(
      scaledCanvasWidth: scaledCanvasWidth,
      canvas: canvas,
      scale: scale,
      isLiked: isLiked,
      isSelected: isSelected,
    );

    if (showText) {
      paintMarkerText(
        canvas: canvas,
        title: title,
        maxWidth: scaledCanvasWidth,
        offsetY: imageHeight,
        scale: scale,
      );
    }

    Picture picture = recorder.endRecording();
    ByteData? pngBytes = await (await picture.toImage(
      scaledCanvasWidth.toInt(),
      scaledCanvasHeight.toInt(),
    ))
        .toByteData(format: ImageByteFormat.png);

    Uint8List data = Uint8List.view(pngBytes!.buffer);

    final marker = BitmapDescriptor.fromBytes(data);
    const double anchorDx = .5;
    final anchorDy = imageHeight / scaledCanvasHeight;

    return CustomMarker(marker: marker, anchorDx: anchorDx, anchorDy: anchorDy);
  }

  /// Return drawed image height
  Future<double> paintMarkerImage({
    required Canvas canvas,
    required bool isLiked,
    required bool isSelected,
    required double scale,
    required double scaledCanvasWidth,
  }) async {
    Image myImage = await getImage(isLiked: isLiked, isSelected: isSelected);

    final double imageWidth;
    final double imageHeight;

    if (isSelected) {
      imageWidth = selectedIconWidth * scale;
      imageHeight = selectedIconHeight * scale;
    } else {
      imageWidth = (isLiked ? likedIconWidth : defaultIconWidth) * scale;
      imageHeight = (isLiked ? likedIconHeight : defaultIconHeight) * scale;
    }

    final imageDx = (scaledCanvasWidth - imageWidth) / 2;
    const imageDy = 0.0;

    paintImage(
      canvas: canvas,
      image: myImage,
      rect: Rect.fromLTWH(
        imageDx,
        imageDy,
        imageWidth,
        imageHeight,
      ),
    );

    return imageHeight;
  }

  void paintMarkerText({
    required Canvas canvas,
    required String title,
    required double scale,
    required double maxWidth,
    required double offsetY,
  }) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: title,
        style: const TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 14,
          height: 1.21428571429,
          decoration: TextDecoration.none,
          letterSpacing: 0.364,
          wordSpacing: 0.36400000000000005,
          color: Colors.black,
        ),
      ),
      textAlign: TextAlign.center,
      textScaleFactor: scale,
      textDirection: TextDirection.ltr,
      maxLines: 2,
    );

    textPainter.layout(maxWidth: maxWidth);

    final textDx = (maxWidth - textPainter.width) / 2;
    final textDy = offsetY + 3;

    textPainter.paint(canvas, Offset(textDx, textDy));
  }

  Future<Image> getImage({
    required bool isLiked,
    required bool isSelected,
  }) async {
    final completer = Completer<ImageInfo>();

    final String path;

    if (isSelected) {
      path = isLiked ? likedSelectedPath : defaultSelectedPath;
    } else {
      path = isLiked ? likedPath : defaultPath;
    }

    final img = AssetImage(path);

    img
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((info, _) {
      completer.complete(info);
    }));

    ImageInfo imageInfo = await completer.future;

    return imageInfo.image;
  }
}
