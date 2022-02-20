import 'package:clinic_task/data/model/examination.dart';
import 'package:clinic_task/data/model/patient.dart';

class ServicesAndBill {
  Patient patient;
  DoctorExamination doctorExamination;
  String bill;

  ServicesAndBill({
    required this.patient,
    required this.doctorExamination,
    required this.bill,
  });
}
