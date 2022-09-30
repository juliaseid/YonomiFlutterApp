import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_flutter_app/models/request.dart';
import 'package:yonomi_platform_sdk/yonomi-sdk.dart';

class Lock {
  String? lockId;
  String? lockName;
  bool? lockedState;
  bool? jammedState;
  int? batteryLevel;

  Lock._create(Device lock) {
    lockId = lock.id;
    lockName = lock.displayName;

    Trait isLocked =
        (lock.traits.singleWhere((element) => (element.name == "isLocked")));
    isLocked.properties.first.value ? lockedState = true : lockedState = false;

    Trait supportsIsJammed = (lock.traits
        .singleWhere((element) => (element.name) == "supportsIsJammed"));
    Trait? isJammed =
        (lock.traits.singleWhere((element) => (element.name) == "isJammed"));
    supportsIsJammed.properties.first.value
        ? jammedState = isJammed.properties.first.value
        : jammedState = null;

    batteryLevel = lock.traits
        .singleWhere(((element) => (element.name == "batteryLevel")))
        .properties
        .first
        .value;
  }

  static Future<Lock> create(String lockId) async {
    Device lockDevice = await DevicesRepository.getLockDetails(request, lockId);
    var lock = Lock._create(lockDevice);
    return lock;
  }
}
