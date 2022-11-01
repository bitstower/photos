import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:photos/components/vendor_card.dart';
import '../utils/ui.dart';
import '../components/vendor_dialog.dart';

class SetupVendorPage extends StatelessWidget {
  const SetupVendorPage({super.key});

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
            icon: const Icon(Icons.close_rounded),
            tooltip: 'Back',
            onPressed: () => GoRouter.of(context).go('/'),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return VendorDialog();
                    },
                  );
                },
                child: Text('Change provider'),
              ),
            ),
          ],
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
                    'Connect to your Storj account',
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
                      'Don\'t have Storj account? Create one. Then create and import access grant.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 450.0,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                    ),
                    items: [1, 2, 3].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.blue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Image(
                              image: AssetImage('assets/step${i}.png'),
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                      );
                    }).toList(),
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
                    GoRouter.of(context).push('/setup-access');
                  },
                  child: const Text(
                    'Next',
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
