import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salons_app/core/theme/colors/app_colors.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

mixin MapWidgetMixin {
  late YandexMapController mapController;
  final List<MapObject> mapObjects = [];
  final animation = const MapAnimation(
    type: MapAnimationType.smooth,
    duration: 2,
  );
  final animationLinear = const MapAnimation(
    type: MapAnimationType.linear,
    duration: 0,
  );
  final MapObjectId largeMapObjectId =
      const MapObjectId('large_clusterized_placemark_collection');

  Future<void> initMap(YandexMapController mapCont) async {
    mapController = mapCont;
  }

  Future<Position> moveToCurrentLocation() async {
    var response = await determinePosition();
    moveCamera(
        Point(latitude: response.latitude, longitude: response.longitude));
    return response;
  }

  void disposeMap() {
    mapController.dispose();
  }

  //** Get permission to use map **//
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  void moveCamera(Point movePoint) {
    mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: movePoint,
          zoom: 12,
        ),
      ),
      animation: animation,
    );
  }

  void moveCameraNoAnimation(Point movePoint) {
    mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: movePoint,
          zoom: 12,
        ),
      ),
      animation: animationLinear,
    );
  }

  void moveCameraCloser(Point movePoint) {
    mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: movePoint,
          zoom: 18,
        ),
      ),
      animation: animation,
    );
  }

  Future<Uint8List> buildClusterAppearance(Cluster cluster) async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    const size = Size(200, 200);
    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = LightThemeColors.selectedItemColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    const radius = 60.0;

    final textPainter = TextPainter(
        text: TextSpan(
            text: cluster.size.toString(),
            style: const TextStyle(
                color: LightThemeColors.grayButton,
                fontSize: 50,
                fontWeight: FontWeight.w600)),
        textDirection: TextDirection.ltr);

    textPainter.layout(minWidth: 0, maxWidth: size.width);

    final textOffset = Offset((size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2);
    final circleOffset = Offset(size.height / 2, size.width / 2);

    canvas.drawCircle(circleOffset, radius, fillPaint);
    canvas.drawCircle(circleOffset, radius, strokePaint);
    textPainter.paint(canvas, textOffset);

    final image = await recorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());
    final pngBytes = await image.toByteData(format: ImageByteFormat.png);

    return pngBytes!.buffer.asUint8List();
  }
}
