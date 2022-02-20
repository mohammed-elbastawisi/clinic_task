import 'package:clinic_task/app_route.dart';
import 'package:clinic_task/business_logic/reservations_cubit/reservation_cubit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(
      appRoute: AppRoute(
        reservationCubit: ReservationCubit(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRoute appRoute;
  const MyApp({Key? key, required this.appRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dental Clinic',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        secondaryHeaderColor: Colors.purple,
      ),
      onGenerateRoute: appRoute.generateRoutes,
    );
  }
}
