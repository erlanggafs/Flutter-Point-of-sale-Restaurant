part of 'checkout_bloc.dart';

@freezed
class CheckoutEvent with _$CheckoutEvent {
  const factory CheckoutEvent.started() = _Started;
  //add item
  const factory CheckoutEvent.addItem(Product product) = _AddItem;
  //remove item
  const factory CheckoutEvent.removeItem(Product product) = _RemoveItem;

  //add discount
  const factory CheckoutEvent.addDiscount(Discount discount) = _AddDiscount;
  //remove discount
  const factory CheckoutEvent.removeDiscount() = _RemoveDiscount;
  //add tax
  const factory CheckoutEvent.addTax(int tax) = _AddTax;
  //add service charge
  const factory CheckoutEvent.addServiceCharge(int serviceCharge) =
      _AddServiceCharge;
}
