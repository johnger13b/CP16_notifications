import 'dart:ui';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationManager {
  static final _instance = LocalNotificationManager._internal();
  late final FlutterLocalNotificationsPlugin _plugin;

  LocalNotificationManager._internal()
      : _plugin = FlutterLocalNotificationsPlugin();

  static LocalNotificationManager get instance => _instance;

  String get _channelId => "flutter_channel";

  Future<void> initializeLocalNotifications(
      {required String androidFavicon}) async {
    /* TO DO: inicializa las notificaciones locales para Android con el id del favicon */
    _plugin.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings(androidFavicon),
      ),
    );
  }

  Future<void> displayNotification(
      {required Color color, required RemoteMessage message}) async {
    final id = DateTime.now().millisecond ~/ 1000;
    /* TO DO: con la configuracion que se uso en el servicio crea los detalles de la notificacion y muestrala */
    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        "notifications PUSH",
        channelDescription: "Channel",
        importance: Importance.max,
        priority: Priority.high,
        color: color,
      ),
    );
    await _plugin.show(
      id,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      notificationDetails,
    );
  }
}
