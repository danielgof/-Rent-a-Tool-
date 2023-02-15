import 'package:client/src/models/offer.dart';
// import 'package:client/src/models/offers.dart';
import 'package:flutter/material.dart';


class OffersList extends StatelessWidget {
  final List<Offer> offers;
  final ValueChanged<Offer>? onTap;

  const OffersList({
    required this.offers,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ListView.builder(
    itemCount: offers.length,
    itemBuilder: (context, index) => ListTile(
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
