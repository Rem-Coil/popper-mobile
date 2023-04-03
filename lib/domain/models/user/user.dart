class User {
  const User({
    required this.id,
    required this.firstName,
    required this.surname,
    required this.secondName,
  });

  final int id;
  final String firstName;
  final String surname;
  final String secondName;

  String get fullName => '$secondName $firstName';
}
