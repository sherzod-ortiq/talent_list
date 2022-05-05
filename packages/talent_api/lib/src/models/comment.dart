import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:talent_api/talent_api.dart';

part 'comment.g.dart';

/// A single comment item.
@immutable
@JsonSerializable()
class Comment extends Equatable {
  /// {@macro talent}
  const Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  /// postId
  final int postId;

  /// id
  final int id;

  /// name
  final String name;

  /// email
  final String email;

  /// body
  final String body;

  /// copyWith
  Comment copyWith({
    int? postId,
    int? id,
    String? name,
    String? email,
    String? body,
  }) {
    return Comment(
      postId: postId ?? this.postId,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      body: body ?? this.body,
    );
  }

  /// Deserializes the given [JsonMap] into a [Comment].
  static Comment fromJson(JsonMap json) => _$CommentFromJson(json);

  /// Converts this [Comment] into a [JsonMap].
  JsonMap toJson() => _$CommentToJson(this);

  @override
  List<Object> get props => [
        postId,
        id,
        name,
        email,
        body,
      ];
}
