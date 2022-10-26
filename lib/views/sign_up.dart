import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../utils/ui.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: Ui.getLightSystemOverlay(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        // title: Text(title),
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
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Create an account so you can backup and share your photos securly',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
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
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Repeat password',
                // suffix: Icon(Icons.remove_red_eye),
              ),
            ),
            const SizedBox(height: 10),
            CheckboxListTile(
              title: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      style: Ui.bodyTextStyle,
                      text: "By creating an account you agree to the ",
                    ),
                    TextSpan(
                      style: Ui.linkStyle,
                      text: "terms of use",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          var url = "https://bitstower.com/";
                          await launchUrlString(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        },
                    ),
                    const TextSpan(
                      style: Ui.bodyTextStyle,
                      text: " and our ",
                    ),
                    TextSpan(
                      style: Ui.linkStyle,
                      text: "privacy policy",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          var url = "https://bitstower.com/";
                          await launchUrlString(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        },
                    ),
                    const TextSpan(
                      style: Ui.bodyTextStyle,
                      text: ".",
                    ),
                  ],
                ),
              ),
              value: false,
              onChanged: (bool? value) {},
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {},
              child: const Text(
                'Create account',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
