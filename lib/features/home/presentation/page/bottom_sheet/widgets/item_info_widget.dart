import 'package:flutter/material.dart';
import 'package:salons_app/core/theme/colors/app_colors.dart';
import 'package:salons_app/core/utils/app_utils.dart';
import 'package:salons_app/core/widget/cached_network_image/custom_cached_network_image.dart';

class ItemInfoWidget extends StatelessWidget {
  const ItemInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppUtils.kPaddingVer20Hor15,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: AppUtils.kBorderRadius10,
            child: const CustomCachedNetworkImage(
              imageUrl: 'https://h5p.org/sites/default/files/h5p/content/1209180/images/file-6113d5f8845dc.jpeg',
              width: double.infinity,
              height: 190,
            ),
          ),
          AppUtils.kBoxHeight18,
          const ListTile(
            title: Text(""),
            subtitle: Text(""),
            trailing: CustomCachedNetworkImage(
              imageUrl: '',
              width: 40,
              height: 40,
            ),
          ),
          SizedBox(
            height: 22,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, __) => Ink(
                padding: AppUtils.kPaddingHor10Ver5,
                decoration: BoxDecoration(
                    borderRadius: AppUtils.kBorderRadius5,
                    border:
                        Border.all(color: LightThemeColors.itemCategoryBorder)),
                child: Text(""),
              ),
              separatorBuilder: (_, __) => AppUtils.kBoxWidth6,
              itemCount: 3,
            ),
          )
        ],
      ),
    );
  }
}
