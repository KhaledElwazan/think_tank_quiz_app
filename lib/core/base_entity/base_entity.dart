import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'base_entity.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class BaseEntity extends Equatable {
  late DateTime createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  late String id;
  BaseEntity({
    this.updatedAt,
    this.deletedAt,
  }) {
    createdAt = DateTime.now();
    id = const Uuid().v4();
  }

  factory BaseEntity.fromJson(Map<String, dynamic> json) =>
      _$BaseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BaseEntityToJson(this);

  @override
  String toString() {
    return 'BaseModel(createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, id: $id)';
  }

  void delete() {
    deletedAt = DateTime.now();
  }

  void restore() {
    deletedAt = null;
  }

  void update() {
    updatedAt = DateTime.now();
  }

  @override
  List<Object?> get props => [createdAt, updatedAt, deletedAt, id];
}
