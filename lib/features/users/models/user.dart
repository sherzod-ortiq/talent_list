import './models.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
  });

  final String id;
  final String username;
  final String name;
  final String email;
  final String phone;
  final String website;
  final String address;

  @override
  List<Object> get props => [
        id,
        username,
        name,
        email,
        phone,
        website,
        address,
      ];
}
