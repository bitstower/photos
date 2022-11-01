import 'package:flutter/material.dart';

class VendorCard extends StatelessWidget {
  final String name;

  const VendorCard({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const itemStyle = TextStyle(color: Colors.blueGrey);
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                textScaleFactor: 1.25,
                style: TextStyle(
                  // fontWeight: FontWeight.w400,
                  color: Colors.blue,
                ),
              ),
              IconButton(
                onPressed: () {},
                // icon: Icon(Icons.circle_outlined),
                icon: Icon(
                  Icons.check_circle_outline,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Storage 0.004/GB/month,',
            style: itemStyle,
          ),
          const SizedBox(height: 5),
          Text(
            'Download 0.007/GB/month,',
            style: itemStyle,
          ),
          const SizedBox(height: 5),
          Text(
            '\$1.65 off/month;',
            style: itemStyle,
          ),
        ],
      ),
    );
  }
}
