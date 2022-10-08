import 'package:f_notifications/domain/use_cases/cloud_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  Future<void> initialize(
      {required String androidFavicon, required Color color}) async {
    /* TO DO: Inicializa el administrador de notificaciones */
    await CloudMessagingManager.init(
        androidFavicon: androidFavicon, color: color);
  }

  Future<void> subscribeTopic() async {
    /* TO DO: Agrega la suscripcion al tema 'flutter_messages' */
    await CloudMessagingManager.subscribeToTopic(topic: 'flutter_messages');
  }

  Future<void> unsubscribeTopic() async {
    /* TO DO: Elimina la suscripcion al tema 'flutter_messages' */
    await CloudMessagingManager.unsubscribeFromTopic(topic: 'flutter_messages');
  }

  Future<void> showLocalNotification(
      {required String title, required String content}) async {
    /* TO DO: Crea una instancia de [RemoteMessage] y muestrala usando .displayFunction() */
    final message = RemoteMessage(
        notification: RemoteNotification(title: title, body: content));
    await CloudMessagingManager.displayNotification(
        color: Colors.blue, message: message);
  }
}
