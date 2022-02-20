import 'package:clinic_task/constants/strings.dart';
import 'package:clinic_task/data/model/services_and_bill.dart';
import 'package:clinic_task/presentation/reservations_screen/reservations_details_screen.dart';
import 'package:flutter/material.dart';

class ReservationsScreen extends StatelessWidget {
  final Map<String, List<ServicesAndBill>> patientsData;
  const ReservationsScreen({Key? key, required this.patientsData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservations'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.home),
        onPressed: () => Navigator.of(context)
            .pushNamedAndRemoveUntil(homeScreen, (route) => false),
      ),
      body: ListView.builder(
        itemCount: patientsData.length,
        itemBuilder: (ctx, index) {
          List<List<ServicesAndBill>> patients = [];
          patientsData.forEach(
            (key, value) => patients.add(value),
          );
          return ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: const Icon(Icons.person),
            title: Text(patients[index].first.patient.name),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => ReservationsDetailsScreen(
                  patientService: patients[index],
                ),
              ));
            },
          );
        },
      ),
    );
  }
}
