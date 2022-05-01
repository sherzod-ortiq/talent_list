import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:talent_api/talent_api.dart';

part 'album.g.dart';

/// A single album item.
@immutable
@JsonSerializable()
class Album extends Equatable {
  /// {@macro talent}
  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  /// userId
  final int userId;

  /// id
  final int id;

  /// title
  final String title;

  /// copyWith
  Album copyWith({
    int? userId,
    int? id,
    String? title,
  }) {
    return Album(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  /// Deserializes the given [JsonMap] into a [Album].
  static Album fromJson(JsonMap json) => _$AlbumFromJson(json);

  /// Converts this [Album] into a [JsonMap].
  JsonMap toJson() => _$AlbumToJson(this);

  @override
  List<Object> get props => [
        userId,
        id,
        title,
      ];
}
