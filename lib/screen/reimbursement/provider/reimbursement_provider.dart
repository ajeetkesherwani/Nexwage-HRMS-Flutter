import 'dart:io';
import 'package:flutter/material.dart';
import '../model/categories_model.dart';
import '../model/get_reimbursement_model.dart' hide Data;
import '../repo/reimbursement_repo.dart';

class ReimbursementProvider with ChangeNotifier {
  final ReimbursementRepository _repo = ReimbursementRepository();

  bool loading = false;
  CategoriesModel? categoriesModel;

  String? selectedCategoryName;
  int? selectedCategoryId;

  Future<void> getCategoriesData() async {
    loading = true;
    notifyListeners();

    try {
      categoriesModel = await _repo.getCategoriesApi();
    } catch (e) {
      print("Categories API ERROR: $e");
    }

    loading = false;
    notifyListeners();
  }

  void setSelectedCategory(Data category) {
    selectedCategoryName = category.name;
    selectedCategoryId = category.id;
    notifyListeners();
  }


  String reimbursementMessage = '';
  bool isLoading = false;

  Future<bool> postReimbursementDetails({
    required String category_id,
    required String amount,
    required String description,
    required String start_date,
    required String end_date,
    File? receipt_file,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _repo.postReimbursementDetails(
        category_id: category_id,
        amount: amount,
        description: description,
        start_date: start_date,
        end_date: end_date,
        receipt_file: receipt_file,
      );

      reimbursementMessage = response.message ?? "Something went wrong";

      print("API Response Status: ${response.status}");
      print("API Response Message: ${response.message}");

      return response.status == true;
    } catch (e) {
      reimbursementMessage = "Something went wrong. Please try again.";
      print("Reimbursement Post Error: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  GetReimbursementModel? getReimbursementModel;

  Future<void> getReimbursementData({bool isRefresh = false}) async {
    loading = true;
    notifyListeners();
    try {
      getReimbursementModel = await _repo.getReimbursementApi();
    } catch (e) {
      print("ReservedRides API ERROR: $e");
    }
    loading = false;
    notifyListeners();
  }

}