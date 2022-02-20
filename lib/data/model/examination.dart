import 'package:clinic_task/data/model/procedures.dart';

class DoctorExamination {
  String? diagnosis;
  int? diagnosisPrice;
  List<String> drugPrescription;
  List<String> redTests;
  List<Procedure> procedures;

  DoctorExamination({
    required this.diagnosis,
    required this.drugPrescription,
    required this.procedures,
    required this.redTests,
    required this.diagnosisPrice,
  });
}
