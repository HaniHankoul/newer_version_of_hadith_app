import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'app/core/navigation/logic/navigation_cubit.dart';
import 'app/core/font_size/logic/font_size_cubit.dart';
import 'app/core/routing/app_route.dart';
import 'app/core/theme/logic/theme_cubit.dart';
import 'app/core/theme/logic/theme_state.dart';

import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel notificationChannel =
    AndroidNotificationChannel(
      'high_importance_channel',
      'إشعارات الأحاديث',
      description: 'إشعارات الأحاديث المنتشرة التي لا تصح',
      importance: Importance.high,
    );

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  debugPrint('FCM BACKGROUND MESSAGE: ${message.messageId}');

  debugPrint('FCM BACKGROUND DATA: ${message.data}');
}

void openFakeHadithNotification(Map<String, dynamic> data) {
  final type = data['type']?.toString();
  final fakeHadithId = data['fakeHadithId']?.toString();

  if (type != 'fake_hadith') {
    return;
  }

  if (fakeHadithId == null || fakeHadithId.isEmpty) {
    return;
  }

  router.go('/fakeHadithAlert/$fakeHadithId');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    settings: initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      final fakeHadithId = response.payload;

      if (fakeHadithId == null || fakeHadithId.isEmpty) {
        return;
      }

      router.go('/fakeHadithAlert/$fakeHadithId');
    },
  );

  final AndroidFlutterLocalNotificationsPlugin? androidNotifications =
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();

  await androidNotifications?.createNotificationChannel(notificationChannel);

  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  final NotificationSettings permission = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  debugPrint(
    'FCM PERMISSION: '
    '${permission.authorizationStatus}',
  );

  final String? fcmToken = await messaging.getToken();

  debugPrint('FCM TOKEN: $fcmToken');

  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    debugPrint('FCM TOKEN REFRESHED: $newToken');
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    debugPrint(
      'FCM FOREGROUND MESSAGE: '
      '${message.messageId}',
    );

    debugPrint('FCM FOREGROUND DATA: ${message.data}');

    final RemoteNotification? notification = message.notification;

    if (notification == null) {
      return;
    }

    debugPrint('FCM TITLE: ${notification.title}');

    debugPrint('FCM BODY: ${notification.body}');

    final fakeHadithId = message.data['fakeHadithId']?.toString();

    await flutterLocalNotificationsPlugin.show(
      id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title: notification.title,
      body: notification.body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          notificationChannel.id,
          notificationChannel.name,
          channelDescription: notificationChannel.description,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
      ),
      payload: fakeHadithId,
    );
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint(
      'FCM NOTIFICATION OPENED: '
      '${message.messageId}',
    );

    debugPrint('FCM OPENED DATA: ${message.data}');

    openFakeHadithNotification(message.data);
  });

  final RemoteMessage? initialMessage = await FirebaseMessaging.instance
      .getInitialMessage();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MainApp());

  if (initialMessage != null) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      openFakeHadithNotification(initialMessage.data);
    });
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()..loadTheme()),
        BlocProvider(create: (context) => FontSizeCubit()..loadFontSize()),
        BlocProvider(create: (context) => NavigationCubit()),
      ],
      child: ToastificationWrapper(
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: router,
            );
          },
        ),
      ),
    );
  }
}
