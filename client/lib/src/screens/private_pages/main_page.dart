import 'package:RT/src/models/offer.dart';
import 'package:RT/src/screens/private_pages/map_page.dart';
import 'package:RT/src/screens/private_pages/test_map_page.dart';
import 'package:RT/src/widgets/offers_list.dart';
import 'package:flutter/material.dart';
import '../../data.dart';
import '../../routing.dart';
import '../../widgets/book_list.dart';
import 'alloffers_private_page.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({
    super.key,
  });

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this)
      ..addListener(_handleTabIndexChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final newPath = _routeState.route.pathTemplate;
    if (newPath.startsWith('/books/popular')) {
      _tabController.index = 0;
    } else if (newPath.startsWith('/books/new')) {
      _tabController.index = 1;
    } else if (newPath == '/books/all') {
      _tabController.index = 2;
    } else if (newPath == '/books/map') {
      _tabController.index = 3;
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndexChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 65, 203, 83),
          // title: const Text('Rent a Tool'),
          title: TabBar(
            indicatorColor: const Color.fromARGB(255, 0, 0, 0),
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'All',
                icon: Icon(Icons.list),
              ),
              Tab(
                text: 'Messages',
                icon: Icon(Icons.people),
              ),
              Tab(
                text: 'New',
                icon: Icon(Icons.new_releases),
              ),
              Tab(
                text: 'Map',
                icon: Icon(Icons.map),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            const AllOffersPrivatePage(),
            BookList(
              books: libraryInstance.popularBooks,
              onTap: _handleBookTapped,
            ),
            OffersList(
              // offers: getOffersRequest(),
              offers: [Offer(id: 1, toolName: "test", toolDescription: "test", price: "test", dateStart: 'test', dateFinish: 'test', ownerName: 'test', phoneNumber: 'test', location: 'some location', lng: '45.8', lat: '6')],
              // offers: offers.getOffersRequest(),
              onTap: _handleOfferTapped,
            ),
            MapWithMarkers()
          ],
        ),
      );

  RouteState get _routeState => RouteStateScope.of(context);

  void _handleBookTapped(Book book) {
    _routeState.go('/book/${book.id}');
  }

  void _handleOfferTapped(Offer offer) {
    _routeState.go('/book/${offer.id}');
  }

  void _handleTabIndexChanged() {
    switch (_tabController.index) {
      case 1:
        _routeState.go('/books/new');
        break;
      case 2:
        _routeState.go('/books/all');
        break;
      case 0:
        _routeState.go('/books/map');
        break;
      default:
        _routeState.go('/books/popular');
        break;
    }
  }
}
