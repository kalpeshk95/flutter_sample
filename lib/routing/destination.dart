import 'package:flutter/material.dart';

class Destination {
  const Destination({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

const destinations = [
  Destination(label: 'Remote', icon: Icons.network_wifi),
  Destination(label: 'DB', icon: Icons.dataset),
  Destination(label: 'Profile', icon: Icons.person),
];