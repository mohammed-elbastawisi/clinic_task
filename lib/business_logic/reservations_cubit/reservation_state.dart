part of 'reservation_cubit.dart';

@immutable
abstract class ReservationState {
  const ReservationState();
}

class ReservationInitialState extends ReservationState {}

class ReservationCheckedState extends ReservationState {
  final Map<String, List<ServicesAndBill>> allPatientsData;
  const ReservationCheckedState({required this.allPatientsData});
}
