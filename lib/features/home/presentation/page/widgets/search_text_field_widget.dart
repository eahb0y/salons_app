import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salons_app/core/theme/colors/app_colors.dart';
import 'package:salons_app/core/utils/app_utils.dart';
import 'package:salons_app/core/widget/text_field/custom_text_field.dart';

class SearchTextFieldWidget extends StatelessWidget {
  const SearchTextFieldWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subTitle),
        trailing: SizedBox(
          height: 50,
          width: 50,
          child: Padding(
            padding: AppUtils.kPaddingAll4,
            child: Container(
              padding: AppUtils.kPaddingAll12,
              decoration: BoxDecoration(
                border: Border.all(
                  color: LightThemeColors.textFieldSuffixBorder,
                ),
                borderRadius: AppUtils.kBorderRadius12,
              ),
              child: SvgPicture.asset("assets/svg/ic_map.svg"),
            ),
          ),
        ),
      ),
    );
  }
}
