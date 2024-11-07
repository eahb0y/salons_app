import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:salons_app/constants/constants.dart';

class Functions{
  static Future<Uint8List?> createImageFromWidget(
      Widget widget, {
        Duration? wait,
        Size? logicalSize,
        Size? imageSize,
        required BuildContext context,
      }) async {
    final repaintBoundary = RenderRepaintBoundary();

    logicalSize ??=
        View.of(context).physicalSize / View.of(context).devicePixelRatio;
    imageSize ??= View.of(context).physicalSize;

    assert(logicalSize.aspectRatio == imageSize.aspectRatio,
    'logicalSize and imageSize must not be the same');

    final renderView = RenderView(
      view: View.of(context),
      child: RenderPositionedBox(
          alignment: Alignment.center, child: repaintBoundary),
      configuration: const ViewConfiguration(
        devicePixelRatio: 1,
      ),
    );

    final pipelineOwner = PipelineOwner();
    final buildOwner = BuildOwner(focusManager: FocusManager());

    pipelineOwner.rootNode = renderView;
    renderView.prepareInitialFrame();

    final rootElement = RenderObjectToWidgetAdapter<RenderBox>(
        container: repaintBoundary,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: widget,
        )).attachToRenderTree(buildOwner);

    // final rootElement = RenderObjectToWidgetAdapter<RenderBox>(
    //   container: repaintBoundary,
    //   child: widget,
    // ).attachToRenderTree(buildOwner);

    buildOwner.buildScope(rootElement);

    if (wait != null) {
      await Future.delayed(wait);
    }

    buildOwner
      ..buildScope(rootElement)
      ..finalizeTree();

    pipelineOwner
      ..flushLayout()
      ..flushCompositingBits()
      ..flushPaint();

    final image = await repaintBoundary.toImage(
        pixelRatio: imageSize.width / logicalSize.width);
    final byteData = await image.toByteData(format: ImageByteFormat.png);

    return byteData?.buffer.asUint8List();
  }

  // static EdgeInsets getDialogPadding(BuildContext context, String category) {
  //   if (category.toLowerCase()==AppConst.store) {
  //     return (MediaQuery.sizeOf(context).width > 900)
  //         ? AppUtils.kPaddingHor360
  //         : AppUtils.kPaddingHor200;
  //   } else {
  //     return (MediaQuery.sizeOf(context).width > 900)
  //         ? AppUtils.kPaddingHor200
  //         : AppUtils.kPaddingHor16;
  //   }
  // }

}