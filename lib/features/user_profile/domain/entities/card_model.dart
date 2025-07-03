import 'package:flutter/material.dart';

class CardModel {
  final Widget image;
  final String title;
  final String subtitle;
  final String duration;
  final String? badge;
  final bool? isLink;
  const CardModel({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.duration,
    this.badge,
    this.isLink,
  });
}
