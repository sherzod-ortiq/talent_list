import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:talent_api/talent_api.dart';

part 'post.g.dart';

/// A single post item.
@immutable
@JsonSerializable()
class Post extends Equatable {
  /// {@macro talent}
  const Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  /// userId
  final int userId;

  /// id
  final int id;

  /// title
  final String title;

  /// body
  final String body;

  /// copyWith
  Post copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) {
    return Post(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  /// Deserializes the given [JsonMap] into a [Post].
  static Post fromJson(JsonMap json) => _$PostFromJson(json);

  /// Converts this [Post] into a [JsonMap].
  JsonMap toJson() => _$PostToJson(this);

  @override
  List<Object> get props => [
        userId,
        id,
        title,
        body,
      ];
}
