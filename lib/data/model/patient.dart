class Patient {
  String name;
  String age;
  String address;
  int phoneNumber;
  DateTime visitTime;
  String? visitType;

  Patient({
    required this.name,
    required this.age,
    required this.address,
    required this.phoneNumber,
    required this.visitTime,
    required this.visitType,
  });
}
