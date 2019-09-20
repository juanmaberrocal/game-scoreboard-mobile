import 'package:flutter/material.dart';

enum MediaSize {xs, s, m, l, xl,}

Device _device;

class Device {
  static const Map<MediaSize, double> mediaBreakpoints = {
    MediaSize.xs: 480,
    MediaSize.s: 600,
    MediaSize.m: 840,
    MediaSize.l: 960,
    MediaSize.xl: 1280,
  };

  static MediaSize getMediaSize(Size size) {
    final double width = size.width;
    MediaSize mediaSize;

    mediaBreakpoints.forEach((MediaSize breakpointMediaSize, double breakpointWidth) {
      if (mediaSize == null && width <= breakpointWidth) {
        mediaSize = breakpointMediaSize;
      }
    });

    return mediaSize;
  }

  final MediaSize mediaSize;
  final Orientation orientation;
  final double height;
  final double width;

  Device({
    this.mediaSize,
    this.orientation,
    this.height,
    this.width,
  });

  factory Device.get(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final Size size = mediaQueryData.size;
    final Orientation orientation = mediaQueryData.orientation;

    if (_device?.orientation == orientation) {
      return _device;
    }

    return Device(
      mediaSize: getMediaSize(size),
      orientation: orientation,
      height: size.height,
      width: size.width,
    );
  }
}