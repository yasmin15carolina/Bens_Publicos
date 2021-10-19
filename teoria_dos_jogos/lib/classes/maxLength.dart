import 'package:json_annotation/json_annotation.dart';
part 'maxLength.g.dart';

@JsonSerializable(nullable: false)
class MaxLength {
  @JsonKey(fromJson: _stringToInt, toJson: _stringFromInt)
  // ignore: non_constant_identifier_names
  final int character_maximum_length;

  MaxLength(this.character_maximum_length);

  factory MaxLength.fromJson(Map<String, dynamic> json) =>
      _$MaxLengthFromJson(json);
  Map<String, dynamic> toJson() => _$MaxLengthToJson(this);

  static int _stringToInt(String number) =>
      number == null ? null as int : int.parse(number);
  static String _stringFromInt(int number) => number.toString();
}
