import 'package:flutter/material.dart';
import 'package:flutter_posresto_app_v2/data/datasources/auth_local_datasource.dart';
import 'package:flutter_posresto_app_v2/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_posresto_app_v2/data/datasources/discount_remote_datasource.dart';
import 'package:flutter_posresto_app_v2/data/datasources/order_remote_datasource.dart';
import 'package:flutter_posresto_app_v2/data/datasources/product_local_datasource.dart';
import 'package:flutter_posresto_app_v2/data/datasources/product_remote_datasource.dart';
import 'package:flutter_posresto_app_v2/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:flutter_posresto_app_v2/presentation/auth/login_page.dart';
import 'package:flutter_posresto_app_v2/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_posresto_app_v2/presentation/home/bloc/local_product/local_product_bloc.dart';
import 'package:flutter_posresto_app_v2/presentation/home/bloc/order/order_bloc.dart';
import 'package:flutter_posresto_app_v2/presentation/setting/bloc/add_discount/add_discount_bloc.dart';
import 'package:flutter_posresto_app_v2/presentation/setting/bloc/discount/discount_bloc.dart';
import 'package:flutter_posresto_app_v2/presentation/setting/bloc/sync_order/sync_order_bloc.dart';
import 'package:flutter_posresto_app_v2/presentation/setting/bloc/sync_product/sync_product_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/constants/colors.dart';
import 'presentation/auth/bloc/login/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/home/pages/dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => SyncProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              LocalProductBloc(ProductLocalDatasource.instance),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
        BlocProvider(
          create: (context) => SyncOrderBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => DiscountBloc(DiscountRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => AddDiscountBloc(DiscountRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          textTheme: GoogleFonts.quicksandTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: AppColors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.quicksand(
              color: AppColors.primary,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            iconTheme: const IconThemeData(
              color: AppColors.primary,
            ),
          ),
        ),
        home: FutureBuilder<bool>(
            future: AuthLocalDataSource().isAuthDataExists(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.hasData) {
                if (snapshot.data!) {
                  return const DashboardPage();
                } else {
                  return const LoginPage();
                }
              }
              return const Scaffold(
                body: Center(
                  child: Text('Error'),
                ),
              );
            }),
      ),
    );
  }
}
