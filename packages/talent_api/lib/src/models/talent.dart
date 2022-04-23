import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:talent_api/talent_api.dart';

part 'talent.g.dart';

/// A single talent item.
@immutable
@JsonSerializable()
class Talent extends Equatable {
  /// {@macro talent}
  const Talent({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  /// id
  final int id;

  /// username
  final String username;

  /// name
  final String name;

  /// email
  final String email;

  /// address
  final Map<String, dynamic> address;

  /// phone
  final String phone;

  /// website
  final String website;

  /// company
  final Map<String, dynamic> company;

  /// copyWith
  Talent copyWith({
    int? id,
    String? username,
    String? name,
    String? email,
    Map<String, dynamic>? address,
    String? phone,
    String? website,
    Map<String, dynamic>? company,
  }) {
    return Talent(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      company: company ?? this.company,
    );
  }

  /// Deserializes the given [JsonMap] into a [Talent].
  static Talent fromJson(JsonMap json) => _$TalentFromJson(json);

  /// Converts this [Talent] into a [JsonMap].
  JsonMap toJson() => _$TalentToJson(this);

  @override
  List<Object> get props => [
        id,
        username,
        name,
        email,
        address,
        phone,
        website,
        company,
      ];
}
