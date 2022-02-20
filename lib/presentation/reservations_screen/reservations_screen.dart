import 'package:clinic_task/constants/strings.dart';
import 'package:clinic_task/data/model/services_and_bill.dart';
import 'package:clinic_task/presentation/reservations_screen/reservations_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        padding: const EdgeInsets.all(20),
        itemCount: patientsData.length,
        itemBuilder: (ctx, index) {
          List<List<ServicesAndBill>> patients = [];
          patientsData.forEach(
            (key, value) => patients.add(value),
          );
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              textColor: Theme.of(context).primaryColor,
              tileColor: Colors.grey[100],
              contentPadding: const EdgeInsets.all(10),
              leading: const Icon(Icons.person),
              title: Text(patients[index].first.patient.name),
              trailing: Text(
                DateFormat('dd - MMM - yyy').format(
                  patients[index].first.patient.visitTime,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => ReservationsDetailsScreen(
                    patientService: patients[index],
                  ),
                ));
              },
            ),
          );
        },
      ),
    );
  }
}
