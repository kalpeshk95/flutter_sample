import 'package:flutter/material.dart';

class Destination {
  const Destination({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

const destinations = [
  Destination(label: 'Watchlist', icon: Icons.checklist),
  Destination(label: 'Orders', icon: Icons.receipt_long),
  Destination(label: 'Portfolio', icon: Icons.analytics),
  Destination(label: 'Funds', icon: Icons.account_balance_wallet),
  Destination(label: 'User', icon: Icons.account_circle),
];