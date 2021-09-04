import 'dart:async';

import 'package:flutter_modular/src/presenter/models/route.dart';
import 'package:modular_interfaces/modular_interfaces.dart';
import 'package:flutter_modular/src/presenter/errors/errors.dart';

abstract class RouteGuard extends Middleware<ModularArguments> {
  FutureOr<bool> canActivate(String path, ParallelRoute route);

  @override
  FutureOr<ModularRoute?> pre(ModularRoute route) => route;

  @override
  FutureOr<ParallelRoute?> pos(route, args) async {
    if (await canActivate(args.uri.toString(), route as ParallelRoute)) {
      return route;
    }

    throw GuardedRouteException(route.uri.toString().trim());
  }
}