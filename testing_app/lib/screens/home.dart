// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/models/favorites.dart';
import 'package:testing_app/screens/favorites.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  const HomePage({super.key});

  static Future<void> _firebaseUser() async {
    await analytics.setUserId(id: 'some-user111');
    await analytics.setUserProperty(name: 'regular', value: 'indeed');
    await analytics.setDefaultEventParameters(<String, dynamic>{
        'string': 'string',
        'int': 42,
        'long': 12345678910,
        'double': 42.0,
        'bool': true.toString(),
      });
  }

  static AnalyticsEventItem itemCreator() {
    return AnalyticsEventItem(
      affiliation: 'affil',
      coupon: 'coup',
      creativeName: 'creativeName',
      creativeSlot: 'creativeSlot',
      discount: 2.22,
      index: 3,
      itemBrand: 'itemBrand',
      itemCategory: 'itemCategory',
      itemCategory2: 'itemCategory2',
      itemCategory3: 'itemCategory3',
      itemCategory4: 'itemCategory4',
      itemCategory5: 'itemCategory5',
      itemId: 'itemId',
      itemListId: 'itemListId',
      itemListName: 'itemListName',
      itemName: 'itemName',
      itemVariant: 'itemVariant',
      locationId: 'locationId',
      price: 9.99,
      currency: 'USD',
      promotionId: 'promotionId',
      promotionName: 'promotionName',
      quantity: 1,
    );
  }

  static Future<void> _firebaseEvent() async {
    await analytics.logAddPaymentInfo();
    await analytics.logAddToCart(
      currency: 'USD',
      value: 123,
      items: [itemCreator(), itemCreator()],
    );
    await analytics.logAddToWishlist();
    await analytics.logAppOpen();
    await analytics.logBeginCheckout(
      value: 123,
      currency: 'USD',
      items: [itemCreator(), itemCreator()],
    );
    await analytics.logCampaignDetails(
      source: 'source',
      medium: 'medium',
      campaign: 'campaign',
      term: 'term',
      content: 'content',
      aclid: 'aclid',
      cp1: 'cp1',
    );
    await analytics.logSearch(
      searchTerm: 'hotel',
      numberOfNights: 2,
      numberOfRooms: 1,
      numberOfPassengers: 3,
      origin: 'test origin',
      destination: 'test destination',
      startDate: '2015-09-14',
      endDate: '2015-09-16',
      travelClass: 'test travel class',
    );
    await analytics.logViewPromotion(
      creativeName: 'promotion name',
      creativeSlot: 'promotion slot',
      items: [itemCreator()],
      locationId: 'United States',
      promotionId: '1234',
      promotionName: 'big sale',
    );
    await analytics.logRefund(
      currency: 'USD',
      value: 123,
      items: [itemCreator(), itemCreator()],
    );
    await analytics.logViewItem(
      currency: 'usd',
      value: 1000,
      items: [itemCreator()],
    );

    await analytics.setUserId(id: 'some-user222');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing Sample'),
        actions: [
          TextButton.icon(
            onPressed: () {
              HomePage._firebaseEvent();
              context.go(FavoritesPage.fullPath);
            },
            icon: const Icon(Icons.favorite_border),
            label: const Text('Favorites'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 100,
        cacheExtent: 20.0,
        controller: ScrollController(),
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) => ItemTile(index),
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  final int itemNo;

  const ItemTile(this.itemNo, {super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesList = context.watch<Favorites>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[itemNo % Colors.primaries.length],
        ),
        title: Text(
          'Item $itemNo',
          key: Key('text_$itemNo'),
        ),
        trailing: IconButton(
          key: Key('icon_$itemNo'),
          icon: favoritesList.items.contains(itemNo)
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border),
          onPressed: () {
            HomePage._firebaseUser();
            !favoritesList.items.contains(itemNo)
                ? favoritesList.add(itemNo)
                : favoritesList.remove(itemNo);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(favoritesList.items.contains(itemNo)
                    ? 'Added to favorites.'
                    : 'Removed from favorites.'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }
}
