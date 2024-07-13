import 'package:flutter/material.dart';
import 'package:todoman/services/local_auth_service.dart';

class AuthProtectionScreen extends StatefulWidget {
  const AuthProtectionScreen({super.key, required this.afterAuth});

  AuthProtectionScreen.replaceAfter({
    required BuildContext context,
    required Widget page,
    dynamic key,
  }) : this(
          afterAuth: () =>
              Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => page,
          )),
          key: key,
        );

  final void Function() afterAuth;

  static pushAuthThenReplace(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AuthProtectionScreen.replaceAfter(
        context: context,
        page: page,
      ),
    ));
  }

  @override
  State<AuthProtectionScreen> createState() => _AuthProtectionScreenState();
}

class _AuthProtectionScreenState extends State<AuthProtectionScreen> {
  final LocalAuthService _authService = LocalAuthService();

  @override
  void initState() {
    super.initState();

    _initAuthentication();
  }

  void _initAuthentication() async {
    bool isAvailable = await _authService.isBiometricAvailable();

    if (isAvailable) {
      bool authenticated = await _authService.authenticate();

      if (authenticated) {
        widget.afterAuth();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // @todo: Add content and button
      ),
    );
  }
}
