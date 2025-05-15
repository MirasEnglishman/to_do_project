
import 'package:asyl_project/presentation/auth/login_screen.dart';
import 'package:asyl_project/presentation/home/home_screen.dart';
import 'package:asyl_project/utlis/shared_preference.dart';
import 'package:flutter/material.dart';


class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final SharedPreferenceHelper _sharedPreferenceHelper = sharedPreference;

  @override
  void initState() {
    super.initState();
    _startInitialization();
  }

  Future<void> _startInitialization() async {
    await initialize();
  }

  Future<void> initialize() async {
    await _sharedPreferenceHelper.init();

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
      sharedPreference.getUser() != null
          ?
           const HomeScreen()
          : const LoginScreen()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Начальный экран'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Добро пожаловать!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            const LinearProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
