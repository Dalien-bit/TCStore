import 'dart:ui';

import 'package:flutter/material.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://drive.google.com/uc?export=view&id=1NwkKuqTxDXcFasSdbJX0VsL97-1GJOBh',
      fit: BoxFit.contain,
    );
  }
}
