import 'package:bloc/bloc.dart';
import 'package:clinic_task/business_logic/reservations_cubit/reservation_services_class.dart';
import 'package:clinic_task/data/model/patient.dart';
import 'package:clinic_task/data/model/services_and_bill.dart';
import 'package:meta/meta.dart';

part 'reservation_state.dart';

class ReservationCubit extends Cubit<ReservationState> {
  final reservationsServices = ReservationsServices();
  Map<String, List<ServicesAndBill>> allPatientsData = {};

  ReservationCubit() : super(ReservationInitialState());

  void checkIfPatientVisitedBefore(Patient patientData) {
    var addNewUser = false;

    if (allPatientsData.isEmpty) {
      allPatientsData.putIfAbsent(
        patientData.phoneNumber.toString(),
        () => [
          reservationsServices.addNewPatientDataToDatabase(patientData),
        ],
      );
    } else {
      allPatientsData.forEach((key, value) {
        if (key == patientData.phoneNumber.toString()) {
          value.add(
            reservationsServices.addNewPatientDataToDatabase(patientData),
          );
        } else {
          addNewUser = true;
        }
      });

      if (addNewUser) {
        allPatientsData.putIfAbsent(
          patientData.phoneNumber.toString(),
          () => [
            reservationsServices.addNewPatientDataToDatabase(patientData),
          ],
        );
        addNewUser = false;
      }
    }

    emit(ReservationCheckedState(allPatientsData: allPatientsData));
  }
}
