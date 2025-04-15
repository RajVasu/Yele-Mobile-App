import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:yele/src/core/utils/log.dart';

class NetworkService {
  bool _isInternetAvailable = false;
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _internetStream = StreamController.broadcast();

  Stream<bool> get internetStream => _internetStream.stream;

  Future<bool> get isInternetAvailable async {
    try {
      List<ConnectivityResult> result = await _connectivity.checkConnectivity();
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.ethernet)) {
        Log.d('✅ Internet Available');
        return true;
      } else {
        Log.d('❌ Internet Not Available');
        return false;
      }
    } catch (e) {
      return true;
    }
  }

  bool get isInternet {
    return _isInternetAvailable;
  }

  static final NetworkService instance = NetworkService._();

  NetworkService._();

  late StreamSubscription<List<ConnectivityResult>> streamSubscription;

  Future<void> init() async {
    try {
      List<ConnectivityResult> connectivityResult =
          await _connectivity.checkConnectivity();
      updateConnectionStatus(connectivityResult);
    } on PlatformException catch (e) {
      Log.e('Network Service File Error ${e.message}');
    }
    streamSubscription = _connectivity.onConnectivityChanged.listen(
      updateConnectionStatus,
    );
  }

  void dispose() {
    streamSubscription.cancel();
  }

  void updateConnectionStatus(List<ConnectivityResult> result) async {
    if (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.ethernet)) {
      if (_isInternetAvailable) return;
      _internetStream.sink.add(true);
      _isInternetAvailable = true;
      Log.d('✅ Internet Available');
    } else {
      _internetStream.sink.add(false);
      _isInternetAvailable = false;
      Log.d('❌ Internet Not Available');
    }
  }
}
