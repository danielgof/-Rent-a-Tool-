import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../auth.dart';
import '../data.dart';
import '../models/offer.dart';
import '../routing.dart';
import '../screens/sign_in.dart';
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
      String url = "http://localhost:5000/api/v1/auth/login";
      Map credits = {
        "username": login,
        "password": pass
      };
      // Map credits = {
      // 	"username": "JL",
      // 	"password": "NCC-1701-D"
      // };
      var body_data = json.encode(credits);
      final response = await http.post(Uri.parse(url), body: body_data);
      var responseData = json.decode(response.body);
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
        // When a page that is stacked on top of the scaffold is popped, display
        // the /books or /authors tab in BookstoreScaffold.
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
          // Display the sign in screen.
          FadeTransitionPage<void>(
            key: _signInKey,
            child: SignInScreen(
              onSignIn: (credentials) async {
                var signedIn = await authState.signIn(
                    credentials.username, credentials.password);
                var login = credentials.username;
                var pass = credentials.password;
                var status = await loginRequest(login, pass);
                // print(credentials.password);
                if (200 == status) {
                  // print("login");
                  await routeState.go('/books/popular');
                  // Navigator.pushNamed(context, '/user_offers');
                } else {
                  print("incorrect data");
                  await routeState.go('/settings');

                  // showDialog<String>(
                  //   context: context,
                  //   builder: (context) => AlertDialog(
                  //     title: const Text('Succes!'),
                  //     content: const Text('Offer was crated.'),
                  //     actions: [
                  //       // TextButton(
                  //       // 	onPressed: () => Navigator.pop(context, 'Cancel'),
                  //       // 	child: const Text('Cancel'),
                  //       // ),
                  //       TextButton(
                  //         onPressed: () => Navigator.pop(context, 'OK'),
                  //         child: const Text('OK'),
                  //       ),
                  //     ],
                  //   ),
                  // );
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
