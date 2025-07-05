import 'dart:convert';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  WebSocket? _socket;

  Future<void> init() async {
      if (await Permission.notification.isDenied) {
        await Permission.notification.request();
    }

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initializationSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    _createNotificationChannel();
  }

  void _createNotificationChannel() {
    if (Platform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'default_channel',
        'General Notifications',
        description: 'Used for general notifications',
        importance: Importance.high,
      );

      _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);
    }
  }

  Future<void> connectToWebSocket(String token) async {
    try {
      _socket = await WebSocket.connect(
        'ws://localhost:8000/ws/notifications/?token=$token',
      );
      print('✅ Connected to WebSocket server');

      _socket!.listen(
        (message) {
          print('📥 Message received: $message');
          _handleIncomingMessage(message);
        },
        onDone: () {
          print('🔌 WebSocket connection closed');
        },
        onError: (error) {
          print('❌ WebSocket error: $error');
        },
      );
    } catch (e) {
      print('❗ Failed to connect to WebSocket: $e');
    }
  }

  void _handleIncomingMessage(String message) {
    try {
      final data = jsonDecode(message);
      final title = data['title'] ?? 'Notification';
      final body = data['body'] ?? 'You have a new message';
      final int id = data['id'];
      print(data);
      _showNotification(title, body, id);
    } catch (e) {
      print('⚠️ Invalid message format: $message');
    }
  }

  Future<void> _showNotification(String title, String body, int id) async {
    try {
      AndroidNotificationDetails? androidDetails;
      if (Platform.isAndroid) {
        androidDetails = AndroidNotificationDetails(
          'default_channel',
          'General Notifications',
          channelDescription: 'Used for general notifications',
          importance: Importance.high,
          priority: Priority.high,
        );
      }

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void disconnect() {
    print('🔌 Disconnecting from WebSocket...');
    _socket?.close();
  }

  void sendMessage(Map<String, dynamic> message) {
    if (_socket != null && _socket!.readyState == WebSocket.open) {
      final encoded = jsonEncode(message);
      print('📤 Sending message: $encoded');
      _socket!.add(encoded);
    } else {
      print('⚠️ Cannot send message — WebSocket is not connected.');
    }
  }
}
