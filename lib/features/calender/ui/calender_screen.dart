import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/calender/ui/cubit/calender_cubit.dart';
import 'package:hireny/features/calender/ui/cubit/state/calender_state.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/constants/dialogs/error_dialog.dart';
import 'package:hireny/utils/constants/dialogs/success_dialog.dart';
import 'package:hireny/utils/di/di.dart';

import '../../../utils/constants/dialogs/loading_dialog.dart';
import 'calender_screen_content.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<CalenderCubit>()..getEvents(),
      child: BlocConsumer<CalenderCubit, CalenderState>(
        builder: (context, state) {
          if (state is LoadingCalender) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (state is SuccessCalender) {
            return CalenderView(events: state.events);
          }
          return CalenderView(events: []);
        },
        listener: (context, state) {
          if (state is ErrorCalender) {
            showDialog(
              context: context,
              builder: (_) => ErrorDialog(message: 'can\'t get events'),
            );
          }
          if (state is SuccessAddedEvent) {
            Future.delayed(
              Duration(seconds: 1),
              () =>
                  Navigator.pushReplacementNamed(context, PagesRoute.calender),
            );
            showDialog(
              context: context,
              builder:
                  (_) => SuccessDialog(message: 'event added successfully'),
            );
          }
          if (state is LoadingAddEvent) {
            showDialog(context: context, builder: (_) => LoadingDialog());
          }
          if (state is HideLoadingCalender) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
