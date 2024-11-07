import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:salons_app/core/functions/base_functions.dart';
import 'package:salons_app/core/theme/app_text_styles.dart';
import 'package:salons_app/core/theme/colors/app_colors.dart';
import 'package:salons_app/core/utils/app_utils.dart';
import 'package:salons_app/features/home/domain/entity/nearest_salons_response_entity.dart';
import 'package:salons_app/features/home/presentation/page/mixin/map_mixin.dart';
import 'package:salons_app/features/home/presentation/page/widgets/custom_painter_clipper_widget.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapWidget extends StatefulWidget {
  final double? lat;
  final double? long;
  final List<SalonResponseEntity>? mapsBranch;

  const MapWidget({
    super.key,
    required this.long,
    required this.lat,
    required this.mapsBranch,
  });

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> with MapWidgetMixin {
  @override
  void didUpdateWidget(covariant MapWidget oldWidget) {
    if (widget.mapsBranch != oldWidget.mapsBranch && mounted) {
      addClusterPlaceMark(widget.mapsBranch);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print("list length :: ${widget.mapsBranch?.length}");
    return Positioned.fill(
      child: YandexMap(
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
        zoomGesturesEnabled: true,
        scrollGesturesEnabled: true,
        logoAlignment: const MapAlignment(
          horizontal: HorizontalAlignment.center,
          vertical: VerticalAlignment.top,
        ),
        mapObjects: mapObjects,
        onMapCreated: (mapController) async {
          await initMap(mapController);
          if ((widget.mapsBranch?.length ?? 0) > 0 && mounted) {
            addClusterPlaceMark(widget.mapsBranch);
          }
          if ((widget.long ?? 0) != 0 && (widget.lat ?? 0) != 0) {
            if (mounted) {
              moveCameraNoAnimation(Point(
                  latitude: widget.lat ?? 0, longitude: widget.long ?? 0));
            }
          } else {
            moveToCurrentLocation().then((value) {
              if (mounted) {
                // context.read<ShowOnBloc>().add(
                //     SetUserLocation(lat: value.latitude, long: value.longitude));
              }
            });
          }
        },
      ),
    );
  }

  Future<void> addClusterPlaceMark(
      List<SalonResponseEntity>? mapsBranch) async {
    {
      // if (mapObjects.any((el) => el.mapId == largeMapObjectId)) {
      //   return;
      // }
      if (mapsBranch == null) {
        return;
      }
      var bitmapList = await getBitmapWidget(mapsBranch);
      final largeMapObject = ClusterizedPlacemarkCollection(
        mapId: largeMapObjectId,
        radius: 46,
        minZoom: 15,
        onClusterAdded:
            (ClusterizedPlacemarkCollection self, Cluster cluster) async {
          return cluster.copyWith(
            appearance: cluster.appearance.copyWith(
              opacity: 1,
              icon: PlacemarkIcon.single(
                PlacemarkIconStyle(
                  image: BitmapDescriptor.fromBytes(
                    await buildClusterAppearance(cluster),
                  ),
                  scale: 1,
                ),
              ),
            ),
          );
        },
        onClusterTap: (self, cluster) {},
        placemarks: List<PlacemarkMapObject>.generate(
          mapsBranch.length,
          (i) {
            print("lat :: ${mapsBranch[i].lat}");
            return PlacemarkMapObject(
              mapId: MapObjectId(mapsBranch[i].id.toString()),
              point: Point(
                latitude: mapsBranch[i].lat ?? 0,
                longitude: mapsBranch[i].long ?? 0,
              ),
              opacity: 1,
              icon: (bitmapList.length) > i
                  ? PlacemarkIcon.single(
                      PlacemarkIconStyle(
                        image: BitmapDescriptor.fromBytes(bitmapList[i]!),
                        scale: 1,
                      ),
                    )
                  : null,
              onTap: (object, point) {
                moveCameraCloser(object.point);
                // context
                //     .read<ShowOnBloc>()
                //     .add(SetStoreIdEvent(id: object.mapId.value));
              },
            );
          },
        ),
        onTap: (self, point) {},
      );
      mapObjects.add(largeMapObject);
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future<List<Uint8List?>> getBitmapWidget(
      List<SalonResponseEntity> mapsBranch) async {
    List<Uint8List?> bitmapList = [];
    await Future.forEach(mapsBranch, (item) async {
      if (!mounted) {
        return;
      }
      var bitmap = await Functions.createImageFromWidget(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: AppUtils.kBorderRadius10,
                color: LightThemeColors.borderLight,
              ),
              child: Text(
                item.name ?? "",
                style: AppTextStyles.appBarTitle,
              ),
            ),
            ClipPath(
              clipper: CustomPointerClipper(),
              child: Container(
                width: 20,
                height: 14,
                color: LightThemeColors.borderColor,
              ),
            ),
          ],
        ),
        context: context,
      );
      bitmapList.add(bitmap);
    });

    return bitmapList;
  }
}
