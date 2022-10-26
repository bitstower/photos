import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/ui.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, required this.title});
  final String title;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: Ui.getLightSystemOverlay(),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => GoRouter.of(context).go('/'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {},
              child: const Text(
                'Sign in',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
