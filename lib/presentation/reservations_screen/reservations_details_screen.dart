import 'package:clinic_task/constants/strings.dart';
import 'package:clinic_task/data/model/examination.dart';
import 'package:clinic_task/data/model/patient.dart';
import 'package:clinic_task/data/model/procedures.dart';
import 'package:clinic_task/data/model/services_and_bill.dart';
import 'package:flutter/material.dart';

class ReservationsDetailsScreen extends StatelessWidget {
  final List<ServicesAndBill> patientService;
  const ReservationsDetailsScreen({Key? key, required this.patientService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservations Details'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.home),
        onPressed: () => Navigator.of(context)
            .pushNamedAndRemoveUntil(homeScreen, (route) => false),
      ),
      body: ListView.builder(
        itemCount: patientService.length,
        itemBuilder: (ctx, index) {
          var patient = patientService[index].patient;
          var doctorExamination = patientService[index].doctorExamination;

          return _buildListViewItem(patient, doctorExamination, index);
        },
      ),
    );
  }

  StatelessWidget _buildListViewItem(
      Patient patient, DoctorExamination doctorExamination, int index) {
    return Card(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTableItem('Patient Name :', patient.name),
            _buildTableItem('Patient age :', patient.age),
            _buildTableItem('Patient Address :', patient.address),
            _buildTableItem(
              'Patient Phone Number :',
              patient.phoneNumber.toString(),
            ),
            _buildTableItem('Diagnosis :', doctorExamination.diagnosis!),
            _buildTableItem('Drug Prescription :', ''),
            _buildDrugPrescriptionAndRedTestsList(
              doctorExamination.drugPrescription,
            ),
            _buildTableItem('Procedures :', ''),
            _buildProceduresList(doctorExamination.procedures),
            _buildTableItem('Red Tests :', ''),
            _buildDrugPrescriptionAndRedTestsList(
              doctorExamination.redTests,
            ),
            _buildTableItem('Bill :', patientService[index].bill),
          ],
        ),
      ),
    );
  }

  Widget _buildProceduresList(List<Procedure> procedures) {
    return Padding(
      padding: const EdgeInsets.only(left: 100),
      child: Column(
        children: [
          for (int i = 0; i < procedures.length; i++)
            Row(
              children: [
                Text(procedures[i].name),
                const SizedBox(width: 30),
                Text(
                  '${procedures[i].price.toString()}\$',
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDrugPrescriptionAndRedTestsList(
      List<String> drugPrescriptionOrRedTests) {
    return Padding(
      padding: const EdgeInsets.only(left: 100),
      child: Column(
        children: [
          for (int i = 0; i < drugPrescriptionOrRedTests.length; i++)
            Row(
              children: [
                Text(drugPrescriptionOrRedTests[i]),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildTableItem(String title, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 20),
        Text(
          content,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
