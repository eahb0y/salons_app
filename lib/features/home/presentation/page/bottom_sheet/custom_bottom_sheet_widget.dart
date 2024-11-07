import 'package:flutter/material.dart';
import 'package:salons_app/core/theme/colors/app_colors.dart';
import 'package:salons_app/core/utils/app_utils.dart';
import 'package:salons_app/features/home/presentation/page/bottom_sheet/widgets/item_info_widget.dart';

class CustomBottomSheetWidget extends StatelessWidget {
  const CustomBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: true,
      minChildSize: 0.2,
      snap: true,
      builder: (BuildContext context, scrollController) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: LightThemeColors.white,
              borderRadius: AppUtils.kBorderRadiusTop12),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverList.separated(
                itemBuilder: (_, __) => ItemInfoWidget(),
                separatorBuilder: (_, __) => AppUtils.kPadHor15Divider,
              ),
            ],
          ),
        );
      },
    );
  }
}
