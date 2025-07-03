import 'dart:convert';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  WebSocketChannel? _channel;

  Future<void> init() async {
    // 🔐 Request notification permission
    if (Platform.isAndroid) {
      if (await Permission.notification.isDenied) {
        await Permission.notification.request();
      }
    } else if (Platform.isIOS) {
      await Permission.notification.request();
    }

    // 🔧 Initialization settings for Android and iOS
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

    // 🔁 Initialize plugin
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // 🔔 Create Android channel
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
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
  }

  void connectToWebSocket(String token) {

    final url = 'ws://10.0.2.2:8000/ws/notifications/?token=$token';
    print('🔌 Connecting to: $url');

    _channel = WebSocketChannel.connect(Uri.parse(url));

    _channel!.stream.listen(
          (message) {
        print('📥 WebSocket Response: $message');
        _handleIncomingMessage(message);
      },
      onError: (error) {
        print("❌ WebSocket error: ${error.toString()}");
      },
      onDone: () {
        print("🔌 WebSocket connection closed.");
      },
    );
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
    _channel?.sink.close();
  }

  void sendMessage(Map<String, dynamic> message) {
    final encoded = jsonEncode(message);
    print('📤 WebSocket Request: $encoded');
    _channel?.sink.add(encoded);
  }
}
