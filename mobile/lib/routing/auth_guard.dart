import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:immich_mobile/shared/services/network.service.dart';

class AuthGuard extends AutoRouteGuard {
  final NetworkService _networkService = NetworkService();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    try {
      var res = await _networkService.postRequest(url: 'auth/validateToken');
      var jsonReponse = jsonDecode(res.toString());
      if (jsonReponse['authStatus']) {
        resolver.next(true);
      }
    } catch (e) {
      router.removeUntil((route) => route.name == "LoginRoute");
    }
  }
}
