import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'app/core/navigation/logic/navigation_cubit.dart';
import 'app/core/font_size/logic/font_size_cubit.dart';
import 'app/core/routing/app_route.dart';
import 'app/core/theme/logic/theme_cubit.dart';
import 'app/core/theme/logic/theme_state.dart';

import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  debugPrint('FCM BACKGROUND MESSAGE: ${message.messageId}');
  debugPrint('FCM BACKGROUND DATA: ${message.data}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(
    firebaseMessagingBackgroundHandler,
  );

  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  final NotificationSettings permission =
      await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  debugPrint(
    'FCM PERMISSION: ${permission.authorizationStatus}',
  );

  final String? fcmToken = await messaging.getToken();

  debugPrint('FCM TOKEN: $fcmToken');

  FirebaseMessaging.instance.onTokenRefresh.listen(
    (newToken) {
      debugPrint('FCM TOKEN REFRESHED: $newToken');
    },
  );

  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) {
      debugPrint('FCM FOREGROUND MESSAGE: ${message.messageId}');
      debugPrint('FCM FOREGROUND DATA: ${message.data}');

      if (message.notification != null) {
        debugPrint(
          'FCM TITLE: ${message.notification?.title}',
        );
        debugPrint(
          'FCM BODY: ${message.notification?.body}',
        );
      }
    },
  );

  FirebaseMessaging.onMessageOpenedApp.listen(
    (RemoteMessage message) {
      debugPrint(
        'FCM NOTIFICATION OPENED: ${message.messageId}',
      );
      debugPrint(
        'FCM OPENED DATA: ${message.data}',
      );
    },
  );

  final RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    debugPrint(
      'FCM INITIAL MESSAGE: ${initialMessage.messageId}',
    );
    debugPrint(
      'FCM INITIAL DATA: ${initialMessage.data}',
    );
  }

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit()..loadTheme(),
        ),
        BlocProvider(
          create: (context) => FontSizeCubit()..loadFontSize(),
        ),
        BlocProvider(
          create: (context) => NavigationCubit(),
        ),
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