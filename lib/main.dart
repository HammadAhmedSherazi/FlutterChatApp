import 'export_all.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAppService.initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Chat App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: '/SplashScreen',
          routes: {
            '/SplashScreen': (context) => const SplashScreen(),
            '/LoginScreen': (context) => const LoginScreen(),
            '/SignupScreen': (context) => const SignupScreen(),
            '/HomeScreen': (context) => const HomeScreen(),
            
          },
          // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}
