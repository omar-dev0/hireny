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
    // Request notification permissions
    if (Platform.isAndroid) {
      if (await Permission.notification.isDenied) {
        await Permission.notification.request();
      }
    } else if (Platform.isIOS) {
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
    final url =
        'ws://localhost:8000/ws/notifications/?token=$token'; // for Android emulator

    try {
      print('🔌 Connecting to: $url');
      _socket = await WebSocket.connect(url);

      _socket!.listen(
        (message) {
          print('📥 WebSocket Response: $message');
          _handleIncomingMessage(message);
        },
        onError: (error) {
          print('❌ WebSocket error: $error');
        },
        onDone: () {
          print("🔌 WebSocket connection closed.");
        },
      );

      print('✅ WebSocket connected');
    } catch (e) {
      print('❗ WebSocket connection failed: $e');
    }
  }

  void _handleIncomingMessage(String message) {
    try {
      final data = jsonDecode(message);
      print('🔔 Incoming notification: $data');
      final title = data['title'] ?? 'Notification';
      final body = data['body'] ?? 'You have a new message';

      _showNotification(title, body);
    } catch (e) {
      print('⚠️ Invalid message format: $message');
    }
  }

  Future<void> _showNotification(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'General Notifications',
      channelDescription: 'Used for general notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      notificationDetails,
    );
  }

  void disconnect() {
    print('🔌 Disconnecting from WebSocket...');
    _socket?.close();
  }

  void sendMessage(Map<String, dynamic> message) {
    final encoded = jsonEncode(message);
    print('📤 WebSocket Request: $encoded');
    _socket?.add(encoded);
  }
}
