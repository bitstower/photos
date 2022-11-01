import 'package:flutter/material.dart';

enum StorageProvider { storj, backblaze, wasabi }

class VendorDialog extends StatefulWidget {
  const VendorDialog({super.key});

  @override
  State<VendorDialog> createState() => _VendorDialogState();
}

class _VendorDialogState extends State<VendorDialog> {
  StorageProvider _storageProvider = StorageProvider.storj;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Change storage provider"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Storj'),
            leading: Radio<StorageProvider>(
              value: StorageProvider.storj,
              groupValue: _storageProvider,
              onChanged: (value) {
                setState(() {
                  _storageProvider = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Backblaze B2'),
            leading: Radio<StorageProvider>(
              value: StorageProvider.backblaze,
              groupValue: _storageProvider,
              onChanged: (value) {
                setState(() {
                  _storageProvider = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Wasabi'),
            leading: Radio<StorageProvider>(
              value: StorageProvider.wasabi,
              groupValue: _storageProvider,
              onChanged: (value) {
                setState(() {
                  _storageProvider = value!;
                });
              },
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Select"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
