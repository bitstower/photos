import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../utils/ui.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: Ui.getLightSystemOverlay(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => GoRouter.of(context).go('/'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Sign up',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Create an account so you can backup and share your photos securly',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                GoRouter.of(context).push('/vendors');
              },
              child: Card(
                color: Colors.transparent,
                elevation: 0,
                // shadowColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: Text(
                        '400 GB',
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                      child: RichText(
                        textAlign: TextAlign.center,
                        textScaleFactor: MediaQuery.textScaleFactorOf(context),
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                              text: "from \$0/month | ",
                            ),
                            TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                              ),
                              text: "Details",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
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
            // const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                GoRouter.of(context).push('/connect-vendor');
              },
              child: const Text(
                'Create account',
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: RichText(
                textAlign: TextAlign.center,
                // textScaleFactor: MediaQuery.textScaleFactorOf(context),
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
            ),
            const SizedBox(height: 40),
            RichText(
              textAlign: TextAlign.center,
              textScaleFactor: MediaQuery.textScaleFactorOf(context),
              text: TextSpan(
                children: [
                  const TextSpan(
                    style: Ui.bodyTextStyle,
                    text: "Already have an account? ",
                  ),
                  TextSpan(
                    style: Ui.linkStyle,
                    text: "Sign in",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => GoRouter.of(context).push('/sign-in'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
