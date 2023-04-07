import 'package:RT/src/models/offer.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


class OffersList extends StatelessWidget {
  final ValueChanged<Offer>? onTap;
  final List<Offer> offers;

  const OffersList({
    required this.offers,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
    ListView.builder(
      itemCount: offers.length,
      itemBuilder: (context, index) =>
          ListTile(
            title: Text(
              offers[index].toolName,
            ),
            subtitle: Text(
              offers[index].toolDescription,
            ),
            onTap: onTap != null ? () => onTap!(offers[index]) : null,
          ),
    );
}
