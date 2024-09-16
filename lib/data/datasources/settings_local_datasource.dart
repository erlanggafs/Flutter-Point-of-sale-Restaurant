import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/setting/models/tax_model.dart';

class SettingsLocalDatasource {
  // save tax to shared preferences
  Future<bool> saveTax(TaxModel taxModel) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('tax', taxModel.toJson());
  }

  // get tax from shared preferences
  Future<TaxModel> getTax() async {
    final prefs = await SharedPreferences.getInstance();
    final tax = prefs.getString('tax');
    if (tax != null) {
      return TaxModel.fromJson(tax);
    } else {
      return TaxModel(
        name: 'Tax',
        type: TaxType.pajak,
        value: 11,
      );
    }
  }

  // save service charge to shared preferences
  Future<bool> saveServiceCharge(int serviceCharge) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt('serviceCharge', serviceCharge);
  }

  // get service charge from shared preferences
  Future<int> getServiceCharge() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('serviceCharge') ?? 0;
  }
}
