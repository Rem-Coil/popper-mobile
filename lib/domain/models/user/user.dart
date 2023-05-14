class User {
  const User({
    required this.id,
    required this.firstName,
    required this.secondName,
  });

  const User.unknown()
      : id = -1,
        firstName = '',
        secondName = 'Неизвестен';

  final int id;
  final String firstName;
  final String secondName;

  String get fullName => '$secondName $firstName';
}
