// import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../api/url.dart';
import '../auth.dart';
import '../data.dart';
// import '../models/offer.dart';
import '../routing.dart';
import 'public_pages/sign_in.dart';
import '../widgets/fade_transition_page.dart';
import 'author_details.dart';
import 'book_details.dart';
import 'scaffold.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// Builds the top-level navigator for the app. The pages to display are based
/// on the `routeState` that was parsed by the TemplateRouteParser.
class BookstoreNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const BookstoreNavigator({
    required this.navigatorKey,
    super.key,
  });

  @override
  State<BookstoreNavigator> createState() => _BookstoreNavigatorState();
}

class _BookstoreNavigatorState extends State<BookstoreNavigator> {
  final _signInKey = const ValueKey('Sign in');
  final _scaffoldKey = const ValueKey('App scaffold');
  final _bookDetailsKey = const ValueKey('Book details screen');
  final _authorDetailsKey = const ValueKey('Author details screen');

  @override
  Widget build(BuildContext context) {
    Future<int> loginRequest(login, pass) async {
      String url = "$URL/api/v1/auth/login";
      Map credits = {
        "username": login,
        "password": pass
      };
      var bodyData = json.encode(credits);
      final response = await http.post(Uri.parse(url), body: bodyData);
      var data = response.statusCode;
      return data;
    }

    final routeState = RouteStateScope.of(context);
    final authState = BookstoreAuthScope.of(context);
    final pathTemplate = routeState.route.pathTemplate;

    Book? selectedBook;
    if (pathTemplate == '/book/:bookId') {
      selectedBook = libraryInstance.allBooks.firstWhereOrNull(
          (b) => b.id.toString() == routeState.route.parameters['bookId']);
    }

    Author? selectedAuthor;
    if (pathTemplate == '/author/:authorId') {
      selectedAuthor = libraryInstance.allAuthors.firstWhereOrNull(
          (b) => b.id.toString() == routeState.route.parameters['authorId']);
    }

    return Navigator(
      key: widget.navigatorKey,
      onPopPage: (route, dynamic result) {
        if (route.settings is Page &&
            (route.settings as Page).key == _bookDetailsKey) {
          routeState.go('/books/popular');
        }
        if (route.settings is Page &&
            (route.settings as Page).key == _authorDetailsKey) {
          routeState.go('/authors');
        }
        return route.didPop(result);
      },
      pages: [
        if (routeState.route.pathTemplate == '/signin')
          FadeTransitionPage<void>(
            key: _signInKey,
            child: SignInScreen(
              onSignIn: (credentials) async {
                // await authState.signIn(
                //     credentials.username, credentials.password);
                // await routeState.go('/books/popular');
                var login = credentials.username;
                var pass = credentials.password;
                var status = await loginRequest(login, pass);
                print(status);
                if (200 == status) {
                  // var signedIn =
                  await authState.signIn(
                  credentials.username, credentials.password);
                  await routeState.go('/books/popular');
                  // Navigator.pushNamed(context, '/user_offers');
                }
              },
            ),
          )
        else ...[
          // Display the app
          FadeTransitionPage<void>(
            key: _scaffoldKey,
            child: const BookstoreScaffold(),
          ),
          // Add an additional page to the stack if the user is viewing a book
          // or an author
          if (selectedBook != null)
            MaterialPage<void>(
              key: _bookDetailsKey,
              child: BookDetailsScreen(
                book: selectedBook,
              ),
            )
          else if (selectedAuthor != null)
            MaterialPage<void>(
              key: _authorDetailsKey,
              child: AuthorDetailsScreen(
                author: selectedAuthor,
              ),
            ),
        ],
      ],
    );
  }
}
