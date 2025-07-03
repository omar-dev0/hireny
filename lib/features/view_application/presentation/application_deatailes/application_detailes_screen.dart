import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/my_assessment/presentation/ui/assissment_detailes/assissment_details_screen_content.dart';
import 'package:hireny/features/my_assessment/presentation/ui/assissment_detailes/cubit/assiss_cubit.dart';
import 'package:hireny/features/my_assessment/presentation/ui/assissment_detailes/cubit/state/assissment_states.dart';

import '../../../../utils/di/di.dart';
import '../../../auth/domain/modules/assessment/assessment.dart';
import 'cubit/application_deatailes_cubit.dart';

class AssissmentDetailsScreen extends StatelessWidget {
  final AssessmentModel? assessmentModel;
  const AssissmentDetailsScreen({super.key, required this.assessmentModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<ApplicationDeatailesCubit>(),
      child: BlocConsumer<AssissmentCubit, AssissmentState>(
        builder:
            (context, state) => AssissmentDetailsScreenContent(
              assessmentModel: assessmentModel,
            ),
        listener: (context, state) {},
      ),
    );
  }
}
