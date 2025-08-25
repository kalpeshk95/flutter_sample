import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.isBack = false,
  });

  final String title;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Row(
        spacing: 10,
        children: [
          if (isBack)
            InkWell(
                onTap: () => context.pop(),
                child: const Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.white,
                ))
          else
            const Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
            ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
