import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../utils/ui.dart';
import 'package:url_launcher/url_launcher.dart';

class VendorsPage extends StatefulWidget {
  const VendorsPage({super.key});
  final String title = 'Vendors';

  @override
  State<VendorsPage> createState() => _VendorsPageState();
}

class _VendorsPageState extends State<VendorsPage> {
  double _storageInGB = 400.0; // GB
  double _downloadInGB = 5; // GB
  String _total = ''; // $
  String _selectedProvider = 'storj';

  _VendorsPageState() {
    _updateTotal();
  }

  void _updateTotal() {
    var _storageInTB = (_storageInGB / 1000).ceil();

    var storageFeePerGB;
    var storageFeePerTB;
    var downloadFeePerGB;
    var discount;

    switch (_selectedProvider) {
      case 'storj':
        storageFeePerGB = 0.004;
        storageFeePerTB = 0;
        downloadFeePerGB = 0.007;
        discount = 1.65;
        break;
      case 'backblaze':
        storageFeePerGB = 0;
        storageFeePerTB = 5;
        downloadFeePerGB = 0.01;
        discount = 0;
        break;
      case 'wasabi':
        storageFeePerGB = 0;
        storageFeePerTB = 5.99;
        downloadFeePerGB = 0;
        discount = 0;
        break;
      default:
        throw 'Unknown provider';
    }

    var amount = (_storageInGB * storageFeePerGB) +
        (_storageInTB * storageFeePerTB) +
        (_downloadInGB * downloadFeePerGB) -
        discount;

    if (amount < 0) {
      amount = 0;
    }

    _total = amount.toStringAsPrecision(2);
  }

  _launchURL(String url) async {
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  }

  Widget buildCard(String provider, String title, String subtitle, String uri) {
    var selected = _selectedProvider == provider;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          trailing: IconButton(
            icon: const Icon(Icons.open_in_new),
            onPressed: () {
              _launchURL(uri);
            },
          ),
          leading: Icon(selected
              ? Icons.radio_button_checked_rounded
              : Icons.radio_button_unchecked_rounded),
          title: Text(title),
          subtitle: Text(subtitle),
          selected: selected,
          onTap: () {
            setState(() {
              _selectedProvider = provider;
              _updateTotal();
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // systemOverlayStyle: Ui.getLightSystemOverlay(),
        // backgroundColor: Colors.white,
        // foregroundColor: Colors.black,
        title: const Text('Estimate costs'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.help_outline_outlined),
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          tooltip: 'Back',
          onPressed: () => GoRouter.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
              child: Text(
                'Usage',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Storage',
                      ),
                      Text('${_storageInGB.round()} GB')
                    ],
                  ),
                ),
                Slider(
                  min: 0.0,
                  max: 1000.0,
                  divisions: 20,
                  value: _storageInGB,
                  label: '${_storageInGB.round()} GB',
                  onChanged: (value) {
                    setState(() {
                      _storageInGB = value;
                      _updateTotal();
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Download'),
                      Text('${_downloadInGB.round()} GB'),
                    ],
                  ),
                ),
                Slider(
                  min: 0.0,
                  max: 10.0,
                  divisions: 10,
                  value: _downloadInGB,
                  label: '${_downloadInGB.round()} GB',
                  onChanged: (value) {
                    setState(() {
                      _downloadInGB = value;
                      _updateTotal();
                    });
                  },
                ),
              ],
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 0, 15),
              child: Text(
                'Vendor',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
            buildCard(
              'storj',
              'Storj',
              '\$0.004/GB/month, \$1.65 off',
              'https://www.storj.io/pricing',
            ),
            buildCard(
              'backblaze',
              'BackBlaze B2',
              '\$5/TB/month, 10 GB free',
              'https://www.backblaze.com/b2/cloud-storage-pricing.html',
            ),
            buildCard(
              'wasabi',
              'Wasabi',
              '\$5.99/TB/month',
              'https://wasabi.com/cloud-storage-pricing/',
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 48, 15, 0),
                  child: Text(
                    'Total: \$$_total/month',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
