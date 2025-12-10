import 'package:flutter/material.dart';

class ItemDetailPage extends StatelessWidget {
  final String id;

  const ItemDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Item Detail $id')),
      body: Center(child: Text('Details for Item $id')),
    );
  }
}
