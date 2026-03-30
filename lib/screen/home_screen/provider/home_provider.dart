
import 'package:flutter/material.dart';

import '../model/home_model.dart';
import '../repo/home_repo.dart';


class HomeProvider with ChangeNotifier {
  final HomeRepository _repo = HomeRepository();
  bool loading = false;
  HomeModel? homeModel;

  Future<void> getHomeData() async {
    loading = true;
    notifyListeners();
    try {
      homeModel = await _repo.getHomeApi();
    } catch (e) {
      print("ReservedRides API ERROR: $e");
    }
    loading = false;
    notifyListeners();
  }
}