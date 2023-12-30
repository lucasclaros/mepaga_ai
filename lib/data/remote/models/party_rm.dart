import 'package:json_annotation/json_annotation.dart';

part 'party_rm.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PartyRM {
  PartyRM({
    this.name,
    this.date,
    this.description,
    this.picture,
  });

  factory PartyRM.fromJson(Map<String, dynamic> json) =>
      _$PartyRMFromJson(json);

  Map<String, dynamic> toJson() => _$PartyRMToJson(this);

  final String? name;
  final String? date;
  final String? description;
  final String? picture;
}
