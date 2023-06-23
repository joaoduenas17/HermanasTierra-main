import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hdt_flutter/firebase_options.dart';
import 'package:hdt_flutter/helpers/shared_preference_helper.dart';
import 'package:hdt_flutter/l10n/l10n.dart';
import 'package:hdt_flutter/providers/carrito_provider.dart';
import 'package:hdt_flutter/providers/data_providers.dart';
import 'package:hdt_flutter/providers/idioma_providers.dart';
import 'package:hdt_flutter/providers/menu_providers.dart';
import 'package:hdt_flutter/routers/app_route.dart';
import 'package:hdt_flutter/service/notificacion_service.dart';
import 'package:hdt_flutter/utils/const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferenceHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IdiomaProviders(), lazy: true),
        ChangeNotifierProvider(create: (_) => MenuProviders()),
        ChangeNotifierProvider(create: (_) => DataProviders(), lazy: true),
        ChangeNotifierProvider(create: (_) => CarritoProviders()),
      ],
      child: const MyMaterialApp(),
    );
  }
}

class MyMaterialApp extends StatefulWidget {
  const MyMaterialApp({
    super.key,
  });

  @override
  State<MyMaterialApp> createState() => _MyMaterialAppState();
}

class _MyMaterialAppState extends State<MyMaterialApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final idioma = Provider.of<IdiomaProviders>(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Hermanas de tierra",
      supportedLocales: L10n.all,
      locale: Locale(idioma.idioma),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      scaffoldMessengerKey: NotificacionService.messengerKey,
      theme: ThemeData(
        primarySwatch: createMaterialColor(principal),
        fontFamily: 'FutuBk',
      ),
      routerConfig: AppRouter.config(),
    );
  }
}
