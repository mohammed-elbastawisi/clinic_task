import 'package:clinic_task/data/model/examination.dart';
import 'package:clinic_task/data/model/patient.dart';
import 'package:clinic_task/data/model/procedures.dart';
import 'package:clinic_task/data/model/services_and_bill.dart';

class ReservationsServices {
  ReservationsServices();

  ServicesAndBill addNewPatientDataToDatabase(Patient patientData) {
    var servicesAndBill = ServicesAndBill(
      patient: patientData,
      doctorExamination: DoctorExamination(
        diagnosis: '',
        diagnosisPrice: 0,
        drugPrescription: [],
        procedures: [],
        redTests: [],
      ),
      bill: '',
    );

    _doctorDecision(servicesAndBill);
    _calculateProceduresPrice(servicesAndBill);
    _calculateBill(servicesAndBill);

    return servicesAndBill;
  }

  void _doctorDecision(ServicesAndBill servicesAndBill) {
    var _doctorExamination = servicesAndBill.doctorExamination;
    _doctorExamination.diagnosis = 'Diagnosis';
    _doctorExamination.diagnosisPrice = 30;
    _doctorExamination.drugPrescription = ['Drug 1', 'Drug 2'];
    _doctorExamination.procedures = [
      Procedure(name: 'procedure 1', price: 25),
      Procedure(name: 'procedure 2', price: 25),
    ];

    _doctorExamination.redTests = ['test 1', 'test 2'];
  }

  int _calculateProceduresPrice(ServicesAndBill servicesAndBill) {
    var procedurePrice = 0;
    var _doctorExamination = servicesAndBill.doctorExamination;

    for (var element in _doctorExamination.procedures) {
      procedurePrice = procedurePrice + element.price;
    }

    return procedurePrice;
  }

  void _calculateBill(ServicesAndBill servicesAndBill) {
    var _doctorExamination = servicesAndBill.doctorExamination;
    var examinationPrice = _doctorExamination.diagnosisPrice;
    var proceduresPrice = _calculateProceduresPrice(servicesAndBill);
    var sum = examinationPrice! + proceduresPrice;
    servicesAndBill.bill = sum.toString();
  }
}
