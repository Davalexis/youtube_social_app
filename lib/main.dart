import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_project/core/routes/router.dart';
import 'package:gemini_project/core/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize flutter_dotenv
  await dotenv.load(fileName: ".env");
  runApp(
    // Wrap the app in a ProviderScope
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'YouTube Social App',
      debugShowCheckedModeBanner: false,
      // Configure router to use GoRouter and the custom theme
      routerConfig: router,
      theme: AppTheme.themeData,
    );
  }
}


