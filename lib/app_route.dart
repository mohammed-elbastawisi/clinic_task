import 'package:clinic_task/business_logic/reservations_cubit/reservation_cubit.dart';
import 'package:clinic_task/constants/strings.dart';
import 'package:clinic_task/data/model/patient.dart';
import 'package:clinic_task/data/model/services_and_bill.dart';
import 'package:clinic_task/presentation/appointment_screen/appointment_screen.dart';
import 'package:clinic_task/presentation/home_screen.dart';
import 'package:clinic_task/presentation/reservations_screen/reservations_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  final ReservationCubit reservationCubit;
  const AppRoute({required this.reservationCubit});

  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (ctx) => BlocProvider.value(
            value: reservationCubit,
            child: const HomeScreen(),
          ),
        );
      case appointmentScreen:
        var _patient = settings.arguments as Patient;
        return MaterialPageRoute(
          builder: (ctx) => BlocProvider.value(
            value: reservationCubit,
            child: AppointmentScreen(
              patient: _patient,
            ),
          ),
        );
      case reservationsScreen:
        var _patientsData =
            settings.arguments as Map<String, List<ServicesAndBill>>;
        return MaterialPageRoute(
          builder: (ctx) => BlocProvider.value(
            value: reservationCubit,
            child: ReservationsScreen(
              patientsData: _patientsData,
            ),
          ),
        );
    }
  }
}
