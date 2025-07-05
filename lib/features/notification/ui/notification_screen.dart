import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/notification/domain/notification_module.dart';
import 'package:hireny/features/notification/ui/cubit/notification_cubit.dart';

import '../../../utils/constants/dialogs/error_dialog.dart';
import '../../../utils/di/di.dart';
import 'cubit/state/notifciation_state.dart';
import 'notification_screen_content.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<NotificationCubit>()..getNotification(),
      child: BlocConsumer<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (state is SuccessNotificationGet) {
            return NotificationScreenContent(
              notifications: state.notifications,
            );
          }
          return NotificationScreenContent(notifications: []);
        },
        listener: (context, state) {
          if (state is ErrorNotificationGet) {
            showDialog(context: context, builder: (_) => ErrorDialog());
          }
        },
      ),
    );
  }
}
