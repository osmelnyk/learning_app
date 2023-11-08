import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            _buildLoginButton(
                text: 'Login with Google',
                icon: FontAwesomeIcons.google,
                color: Colors.blueAccent,
                onPressed: () {}),
            _buildLoginButton(
                text: 'Login with Facebook',
                icon: FontAwesomeIcons.facebook,
                color: Colors.indigo,
                onPressed: () {}),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton({
    required String text,
    required Color color,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ))),
        onPressed: onPressed,
        label: Text(text),
        icon: FaIcon(
          icon,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
