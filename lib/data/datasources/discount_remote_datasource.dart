import 'package:dartz/dartz.dart';
import 'package:flutter_posresto_app_v2/core/constants/variables.dart';
import 'package:flutter_posresto_app_v2/data/datasources/auth_local_datasource.dart';
import 'package:flutter_posresto_app_v2/data/models/response/discount_response_model.dart';
import 'package:http/http.dart' as http;

class DiscountRemoteDatasource {
  Future<Either<String, DiscountResponseModel>> getDiscounts() async {
    final url = Uri.parse('${Variables.baseUrl}/api/api-discounts');
    final authData = await AuthLocalDataSource().getAuthData();
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${authData.token}',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      return Right(DiscountResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get discounts');
    }
  }

  Future<Either<String, bool>> addDiscount(
    String name,
    String description,
    int value,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/api-discounts');
    final authData = await AuthLocalDataSource().getAuthData();
    final response = await http.post(url, headers: {
      'Authorization': 'Bearer ${authData.token}',
      'Accept': 'application/json',
    }, body: {
      'name': name,
      'description': description,
      'value': value.toString(),
      'type': 'percentage',
    });

    if (response.statusCode == 201) {
      return const Right(true);
    } else {
      return const Left('Failed to add discount');
    }
  }
}
