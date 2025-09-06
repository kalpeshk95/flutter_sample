import 'package:flutter/material.dart';

import '../../shared/widgets/custom_app_bar.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: CustomAppBar(title: title),
      ),
      body: const Center(child: Text('Coming Soon...')));
}
