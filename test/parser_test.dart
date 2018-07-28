/*
 * fluro
 * A Posse Production
 * http://goposse.com
 * Copyright (c) 2018 Posse Productions LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:fluro/fluro.dart';

void main() {
  testWidgets("Router correctly parses named parameters",
      (WidgetTester tester) async {
    String path = "/users/1234";
    String route = "/users/:id";
    Router router = new Router();
    router.define(route, handler: null);
    AppRouteMatch match = router.match(path);
    expect(
        match?.parameters,
        equals(<String, List<String>>{
          "id": ["1234"],
        }));
  });

  testWidgets("Router correctly parses named parameters with query",
      (WidgetTester tester) async {
    String path = "/users/1234?name=luke";
    String route = "/users/:id";
    Router router = new Router();
    router.define(route, handler: null);
    AppRouteMatch match = router.match(path);
    expect(
        match?.parameters,
        equals(<String, List<String>>{
          "id": ["1234"],
          "name": ["luke"],
        }));
  });

  testWidgets("Router correctly parses query parameters",
      (WidgetTester tester) async {
    String path = "/users/create?name=luke&phrase=hello%20world&number=7";
    String route = "/users/create";
    Router router = new Router();
    router.define(route, handler: null);
    AppRouteMatch match = router.match(path);
    expect(
        match?.parameters,
        equals(<String, List<String>>{
          "name": ["luke"],
          "phrase": ["hello world"],
          "number": ["7"],
        }));
  });

  testWidgets("Router correctly parses array parameters",
      (WidgetTester tester) async {
    String path =
        "/users/create?name=luke&phrase=hello%20world&number=7&number=10&number=13";
    String route = "/users/create";
    Router router = new Router();
    router.define(route, handler: null);
    AppRouteMatch match = router.match(path);
    expect(
        match?.parameters,
        equals(<String, List<String>>{
          "name": ["luke"],
          "phrase": ["hello world"],
          "number": ["7", "10", "13"],
        }));
  });
}
