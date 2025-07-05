import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hireny/features/notification/domain/notification_module.dart';
import 'package:hireny/features/notification/ui/widget/notification_card.dart';
import 'package:lottie/lottie.dart';

class NotificationScreenContent extends StatefulWidget {
  final List<AppNotification> notifications;

  const NotificationScreenContent({super.key, required this.notifications});

  @override
  State<NotificationScreenContent> createState() =>
      _NotificationScreenContentState();
}

class _NotificationScreenContentState extends State<NotificationScreenContent> {
  late List<AppNotification> _notifs;

  @override
  void initState() {
    super.initState();
    _notifs = List.from(widget.notifications); // Copy to mutate state
  }

  void _markAsRead(int index) {
    setState(() {
      _notifs[index] = AppNotification(
        id: _notifs[index].id,
        title: _notifs[index].title,
        message: _notifs[index].message,
        createdAt: _notifs[index].createdAt,
        isRead: true,
        user: _notifs[index].user,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      body:
          _notifs.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/animations/notification.json'),
                    const Text(
                      "No notifications yet",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _notifs.length,
                itemBuilder: (context, index) {
                  return FadeIn(
                    duration: const Duration(milliseconds: 600),
                    delay: Duration(milliseconds: index * 100),
                    child: SlideInUp(
                      duration: const Duration(milliseconds: 600),
                      delay: Duration(milliseconds: index * 100),
                      child: GestureDetector(
                        onTap: () => _markAsRead(index),
                        child: NotificationCard(notification: _notifs[index]),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
