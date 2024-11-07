import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salons_app/core/theme/colors/app_colors.dart';
import 'package:salons_app/core/utils/app_utils.dart';
import 'package:salons_app/core/widget/text_field/custom_text_field.dart';
import 'package:salons_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:salons_app/features/home/presentation/page/bottom_sheet/custom_bottom_sheet_widget.dart';
import 'package:salons_app/features/home/presentation/page/widgets/map_widget.dart';
import 'package:salons_app/features/home/presentation/page/widgets/search_text_field_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<HomeBloc>().add(const HomeInitialCallEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              MapWidget(
                lat: state.lat,
                long: state.long,
                mapsBranch: state.salonsList?.salons,
              ),
              Positioned(
                top: 70,
                right: 15,
                left: 15,
                child: SearchTextFieldWidget(
                  title: 'Hair coloring',
                  subTitle: 'Los Angeles, CA, USA',
                ),
              ),
              CustomBottomSheetWidget(),
            ],
          ),
        );
      },
    );
  }
}
