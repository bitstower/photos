import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:photos/components/vendor_card.dart';
import '../utils/ui.dart';
import '../components/vendor_dialog.dart';

class SetupAccessPage extends StatelessWidget {
  const SetupAccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Ui.darkNavigationBar(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          systemOverlayStyle: Ui.darkStatusBar(),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back',
            onPressed: () => GoRouter.of(context).go('/setup-vendor'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Access grant',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Paste your newly generated access grant',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Access grant',
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewPadding.bottom),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    GoRouter.of(context).push('/');
                  },
                  child: const Text(
                    'Done',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
