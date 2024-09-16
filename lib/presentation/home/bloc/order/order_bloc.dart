import 'package:bloc/bloc.dart';
import 'package:flutter_posresto_app_v2/core/extensions/string_ext.dart';
import 'package:flutter_posresto_app_v2/data/datasources/auth_local_datasource.dart';
import 'package:flutter_posresto_app_v2/data/datasources/product_local_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/order_model.dart';
import '../../models/product_quantity.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const _Initial()) {
    on<_Order>((event, emit) async {
      emit(const _Loading());

      //save to local storage
      //  this.id,
      // required this.subTotal,
      // required this.paymentAmount,
      // required this.tax,
      // required this.discount,
      // required this.serviceCharge,
      // required this.total,
      // required this.paymentMethod,
      // required this.totalItem,
      // required this.idKasir,
      // required this.namaKasir,
      // required this.transactionTime,
      // required this.isSync,
      // required this.orderItems,

      final subTotal = event.items.fold<int>(
          0,
          (previousValue, element) =>
              previousValue +
              (element.product.price!.toIntegerFromText * element.quantity));
      final total = subTotal + event.tax + event.serviceCharge - event.discount;

      final totalItem = event.items.fold<int>(
          0, (previousValue, element) => previousValue + element.quantity);

      final userData = await AuthLocalDataSource().getAuthData();

      final dataInput = OrderModel(
        subTotal: subTotal,
        paymentAmount: event.paymentAmount,
        tax: event.tax,
        discount: event.discount,
        serviceCharge: event.serviceCharge,
        total: total,
        paymentMethod: 'Cash',
        totalItem: totalItem,
        idKasir: userData.user!.id!,
        namaKasir: userData.user!.name!,
        transactionTime: DateTime.now().toIso8601String(),
        isSync: 0,
        orderItems: event.items,
      );

      await ProductLocalDatasource.instance.saveOrder(dataInput);

      emit(_Loaded(
        dataInput,
      ));
    });
  }
}
