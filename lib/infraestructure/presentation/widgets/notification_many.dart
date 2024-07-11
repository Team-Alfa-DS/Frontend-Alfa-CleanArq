import 'package:alpha_gymnastic_center/aplication/BLoC/notification/notification_many/notification_many_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/notification/notification_many/notification_many_event.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/notification/notification_many/notification_many_state.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/notification/get_notification_data_use_case.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/notifications/notification_detail_screen.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/listvertical.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:alpha_gymnastic_center/domain/entities/notification.dart';

class NotificationMany extends StatelessWidget {
  const NotificationMany({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NotificationListBloc(GetIt.instance<GetNotificationDataUseCase>())
            ..add(const LoadNotificationList()),
      child: BlocBuilder<NotificationListBloc, NotificationListState>(
        builder: (context, state) {
          if (state is NotificationListLoading) {
            return const CircularProgressIndicator();
          } else if (state is NotificationListLoaded) {
            final notification = state.notification.sublist(0, state.notification.length);
            return SizedBox(
              height: 195,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: notification.map((notification) {
                  return ListV<Map<String, dynamic>>(
                    item: {
                      'id': notification.id,
                      'titulo': notification.title,
                      'description': notification.body,
                      'fecha': notification.date.toString(),
                      'leido': notification.readed,
                    },
                    onTap: (item) {
                      var selectedNotification = Notifications(
                        id: notification.id,
                        title: notification.title,
                        body: notification.body,
                        date: notification.date,
                        readed: notification.readed,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScreenDetail(
                            notification: selectedNotification,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            );
          } else if (state is NotificationListFailed) {
            return Text('Error: ${state.failure}');
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
