import 'package:clinic_task/business_logic/reservations_cubit/reservation_cubit.dart';
import 'package:clinic_task/constants/strings.dart';
import 'package:clinic_task/data/model/patient.dart';
import 'package:clinic_task/presentation/shared/upload_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ReservationCubit reservationCubit;
  final _formKey = GlobalKey<FormState>();

  late Patient _patient;

  @override
  void initState() {
    super.initState();
    reservationCubit = BlocProvider.of<ReservationCubit>(context);
    _patient = Patient(
      name: '',
      age: '',
      address: '',
      phoneNumber: 0,
      visitTime: DateTime.now(),
      visitType: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dental Clinic'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPatientForm(),
            UploadButton(
              onPressed: () {
                var valid = _formKey.currentState!.validate();
                if (!valid) {
                  return;
                } else {
                  _formKey.currentState!.save();
                  Navigator.of(context).pushNamed(
                    appointmentScreen,
                    arguments: _patient,
                  );
                }
              },
              title: 'Apply',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientForm() {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        width: kIsWeb ? 400 : double.infinity,
        child: _buildFormTextFields(),
      ),
    );
  }

  Widget _buildFormTextFields() {
    return Column(
      children: [
        _buildTextFormField(
          hintText: 'Patient Name',
          icon: Icons.person_outline,
          onSaved: (value) => _patient.name = value!,
        ),
        const SizedBox(height: 15),
        _buildTextFormField(
          hintText: 'Age',
          icon: Icons.calendar_today,
          onSaved: (value) => _patient.age = value!,
        ),
        const SizedBox(height: 15),
        _buildTextFormField(
          hintText: 'Address',
          icon: Icons.location_city_rounded,
          onSaved: (value) => _patient.address = value!,
        ),
        const SizedBox(height: 15),
        _buildTextFormField(
          hintText: 'Phone Number',
          icon: Icons.phone_android,
          onSaved: (value) => _patient.phoneNumber = int.parse(
            value!,
          ),
        ),
      ],
    );
  }

  TextFormField _buildTextFormField({
    required IconData icon,
    required String hintText,
    required void Function(String?)? onSaved,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(icon),
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.red,
          ),
        ),
        hintText: hintText,
      ),
      validator: (value) {
        if (value! == '') {
          return 'You must enter this field';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
}
