import 'package:dio_api_calling/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_user_response.g.dart';

@JsonSerializable()
class ListUserResponse {

  @JsonKey(name : "page")
  int? page;

  @JsonKey(name : "per_page")
  int? perPage;

  @JsonKey(name : "total")
  int? total;

  @JsonKey(name : "total_pages")
  int? totalPages;

  @JsonKey(name : "data")
  List<User>? users;

  ListUserResponse();

  factory ListUserResponse.fromJson(Map<String, dynamic> json) => _$ListUserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ListUserResponseToJson(this);
}