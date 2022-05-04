import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:talent_api/talent_api.dart';

part 'photo.g.dart';

/// A single photo item.
@immutable
@JsonSerializable()
class Photo extends Equatable {
  /// {@macro talent}
  const Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  /// albumId
  final int albumId;

  /// id
  final int id;

  /// title
  final String title;

  /// url
  final String url;

  /// thumbnailUrl
  final String thumbnailUrl;

  /// copyWith
  Photo copyWith({
    int? albumId,
    int? id,
    String? title,
    String? url,
    String? thumbnailUrl,
  }) {
    return Photo(
      albumId: albumId ?? this.albumId,
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }

  /// Deserializes the given [JsonMap] into a [Photo].
  static Photo fromJson(JsonMap json) => _$PhotoFromJson(json);

  /// Converts this [Photo] into a [JsonMap].
  JsonMap toJson() => _$PhotoToJson(this);

  @override
  List<Object> get props => [
        albumId,
        id,
        title,
        url,
        thumbnailUrl,
      ];
}
