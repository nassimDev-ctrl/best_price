import 'dart:async';
import 'dart:io';

import 'package:best_price/core/utils/logger.dart' as logger;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// FCM Helper class for handling Firebase Cloud Messaging
class FcmHelper {
  static final FcmHelper instance = FcmHelper._internal();
  factory FcmHelper() => instance;
  FcmHelper._internal();

  // Firebase Messaging instance
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Local notifications plugin
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // Notification stream controller
  final StreamController<RemoteMessage> _notificationStreamController =
      StreamController<RemoteMessage>.broadcast();
  Stream<RemoteMessage> get notificationStream =>
      _notificationStreamController.stream;

  String? _fcmToken;
  String? get fcmToken => _fcmToken;

  /// Initialize FCM and request permissions
  Future<void> initialize() async {
    try {
      // Request notification permissions
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      logger.LoggerHelper.info(
          'User granted permission: ${settings.authorizationStatus}');

      // Initialize local notifications
      await _initializeLocalNotifications();

      // Get FCM token
      await getFcmToken();

      // Configure foreground message handler
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

      // Configure background message handler (when app is in background)
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

      // Check if app was opened from a notification
      _checkInitialMessage();

      // Handle token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        _fcmToken = newToken;
        logger.LoggerHelper.info('FCM Token refreshed: $newToken');
        // TODO: Send token to your backend
      });

      logger.LoggerHelper.info('FCM initialized successfully');
    } catch (e) {
      logger.LoggerHelper.error('Error initializing FCM: $e');
    }
  }

  /// Initialize local notifications for foreground messages
  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        logger.LoggerHelper.info('Notification tapped: ${response.payload}');
        // Handle notification tap
      },
    );

    // Create notification channel for Android
    if (Platform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'best_price_notifications', // channel id
        'Best Price Notifications', // channel name
        description: 'Notifications for Best Price app',
        importance: Importance.high,
        playSound: true,
        enableVibration: true,
      );

      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
  }

  /// Get FCM token
  Future<String?> getFcmToken() async {
    try {
      _fcmToken = await _firebaseMessaging.getToken();
      logger.LoggerHelper.info('FCM Token: $_fcmToken');
      return _fcmToken;
    } catch (e) {
      logger.LoggerHelper.error('Error getting FCM token: $e');
      return null;
    }
  }

  /// Handle foreground messages
  void _handleForegroundMessage(RemoteMessage message) {
    logger.LoggerHelper.info(
        'Foreground message received: ${message.messageId}');

    // Add to stream for listeners
    _notificationStreamController.add(message);

    // Show local notification
    _showLocalNotification(message);
  }

  /// Handle message when app is opened from notification
  void _handleMessageOpenedApp(RemoteMessage message) {
    logger.LoggerHelper.info('Notification opened app: ${message.messageId}');

    // Add to stream for listeners
    _notificationStreamController.add(message);

    // Navigate to specific screen based on notification data
    _handleNotificationNavigation(message);
  }

  /// Check if app was opened from a notification
  Future<void> _checkInitialMessage() async {
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      logger.LoggerHelper.info(
          'App opened from notification: ${initialMessage.messageId}');
      _handleNotificationNavigation(initialMessage);
    }
  }

  /// Show local notification for foreground messages
  Future<void> _showLocalNotification(RemoteMessage message) async {
    final RemoteNotification? notification = message.notification;
    if (notification == null) return;

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'best_price_notifications',
      'Best Price Notifications',
      channelDescription: 'Notifications for Best Price app',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      playSound: true,
      enableVibration: true,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      details,
      payload: message.data.toString(),
    );
  }

  /// Handle navigation based on notification data
  void _handleNotificationNavigation(RemoteMessage message) {
    final Map<String, dynamic> data = message.data;

    // TODO: Implement navigation logic based on notification data
    // Example:
    // if (data['type'] == 'order') {
    //   // Navigate to order details
    // } else if (data['type'] == 'product') {
    //   // Navigate to product details
    // }

    logger.LoggerHelper.info('Notification data: $data');
  }

  /// Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      logger.LoggerHelper.info('Subscribed to topic: $topic');
    } catch (e) {
      logger.LoggerHelper.error('Error subscribing to topic: $e');
    }
  }

  /// Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      logger.LoggerHelper.info('Unsubscribed from topic: $topic');
    } catch (e) {
      logger.LoggerHelper.error('Error unsubscribing from topic: $e');
    }
  }

  /// Delete FCM token (for logout)
  Future<void> deleteToken() async {
    try {
      await _firebaseMessaging.deleteToken();
      _fcmToken = null;
      logger.LoggerHelper.info('FCM Token deleted');
    } catch (e) {
      logger.LoggerHelper.error('Error deleting FCM token: $e');
    }
  }

  /// Dispose resources
  void dispose() {
    _notificationStreamController.close();
  }
}

/// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  logger.LoggerHelper.info('Background message received: ${message.messageId}');
  // Handle background message
}
