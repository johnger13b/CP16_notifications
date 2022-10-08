import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';

typedef MessageHandler = Future<void> Function(RemoteMessage message);
typedef MessageOpenedAppHandler = Future<void> Function(RemoteMessage message);

class CloudMessagingService {
  static final _instance = CloudMessagingService._internal();
  late final FirebaseMessaging _messaging;

  CloudMessagingService._internal() : _messaging = FirebaseMessaging.instance;

  static CloudMessagingService get instance => _instance;

/* TO DO: define el id del canal que se usara */
  String get _channelId => "flutter_channel";

  Future<String?> get deviceToken => _messaging.getToken();

  Future<NotificationSettings> requestPermission({
    bool alert = true,
    bool announcement = false,
    bool badge = true,
    bool carPlay = false,
    bool criticalAlert = false,
    bool provisional = false,
    bool sound = true,
  }) async {
    /* TO DO: solicita el permiso para mostrar notificaciones */
    return await _messaging.requestPermission(
      alert: alert,
      announcement: announcement,
      badge: badge,
      carPlay: carPlay,
      criticalAlert: criticalAlert,
      provisional: provisional,
      sound: sound,
    );
  }

  Future<void> initChannel() async {
    /* TO DO: registra el canal que se usara usando [FlutterNotificationChannel] */
    await FlutterNotificationChannel.registerNotificationChannel(
      id: _channelId,
      name: "Channel",
      description: "notifications PUSH",
      importance: NotificationImportance.IMPORTANCE_HIGH,
      allowBubbles: true,
      enableVibration: true,
      enableSound: true,
      showBadge: true,
    );
  }

  void registerHandlers(
      {required BackgroundMessageHandler onBackground,
      required MessageHandler onMessage,
      MessageOpenedAppHandler? onOpenedApp}) {
    FirebaseMessaging.onBackgroundMessage(onBackground);
    FirebaseMessaging.onMessage.listen(onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(onOpenedApp);
  }

  Future<void> setNotificationPresentationOptions(
      {bool alert = false, bool badge = false, bool sound = false}) async {
    /* TO DO: set presentation options for iOS */
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: alert,
      badge: badge,
      sound: sound,
    );
  }

  Future<void> subscribeToTopic({required String topic}) async {
    /* TO DO: suscribe el app a [topic] */
    await _messaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic({required String topic}) async {
    /* TO DO: desuscribe el app a [topic] */
    await _messaging.unsubscribeFromTopic(topic);
  }
}
