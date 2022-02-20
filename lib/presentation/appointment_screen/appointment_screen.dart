import 'package:clinic_task/business_logic/reservations_cubit/reservation_cubit.dart';
import 'package:clinic_task/constants/strings.dart';
import 'package:clinic_task/data/model/examination.dart';
import 'package:clinic_task/data/model/patient.dart';
import 'package:clinic_task/data/model/services_and_bill.dart';
import 'package:clinic_task/presentation/appointment_screen/widget/available_time_widget.dart';
import 'package:clinic_task/presentation/shared/upload_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentScreen extends StatefulWidget {
  final Patient patient;
  const AppointmentScreen({
    Key? key,
    required this.patient,
  }) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  late ReservationCubit reservationCubit;
  late ServicesAndBill servicesAndBill;
  int chosenHour = 0;
  DateTime? _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    servicesAndBill = ServicesAndBill(
      patient: widget.patient,
      doctorExamination: DoctorExamination(
        diagnosis: '',
        diagnosisPrice: 0,
        drugPrescription: [],
        procedures: [],
        redTests: [],
      ),
      bill: '',
    );

    reservationCubit = BlocProvider.of<ReservationCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Appointment'),
      ),
      body: _buildBody(),
    );
  }

  StatelessWidget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCalendar(),
          const SizedBox(height: 30),
          _buildChooseAppointmentText(),
          const SizedBox(height: 20),
          _buildAppointmentTime(),
          const SizedBox(height: 40),
          BlocConsumer<ReservationCubit, ReservationState>(
            listener: (context, state) {
              if (state is ReservationCheckedState) {
                Navigator.of(context).pushReplacementNamed(
                  reservationsScreen,
                  arguments: state.allPatientsData,
                );
              }
            },
            builder: (context, state) {
              return UploadButton(
                title: 'Upload',
                onPressed: _onUploading,
              );
            },
          ),
        ],
      ),
    );
  }

  TableCalendar<dynamic> _buildCalendar() {
    return TableCalendar(
      currentDay: _selectedDay,
      focusedDay: _focusedDay,
      firstDay: DateTime.now(),
      lastDay: DateTime.utc(2030, 3, 14),
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: _onDaySelected,
      onFormatChanged: _onFormateChanges,
    );
  }

  StatelessWidget _buildChooseAppointmentText() {
    return const Text(
      'Choose Appointment Time',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildAppointmentTime() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      children: [
        for (int i = 1; i <= 5; i++)
          AvailableTimeWidget(
            availableTime: '$i pm',
            onTap: () {
              chosenHour = i;
            },
          ),
      ],
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      widget.patient.visitTime = selectedDay;
    }
  }

  void _onFormateChanges(CalendarFormat format) {
    if (_calendarFormat != format) {
      setState(() {
        _calendarFormat = format;
      });
    }
  }

  void _chooseDateAndTime() {
    var _chosenDateAndTime = DateTime(
      _selectedDay!.year,
      _selectedDay!.month,
      _selectedDay!.day,
      chosenHour,
    );
    widget.patient.visitTime = _chosenDateAndTime;
  }

  void _viewErrorDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Error',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text('Please choose the appointment hour'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  void _onUploading() {
    if (chosenHour == 0) {
      _viewErrorDialog();
    } else {
      _chooseDateAndTime();
      reservationCubit.checkIfPatientVisitedBefore(widget.patient);
    }
  }
}
