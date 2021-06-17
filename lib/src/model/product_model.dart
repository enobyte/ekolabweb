import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  int? code;
  String? message;
  @JsonKey(defaultValue: false)
  bool? status;
  List<Map<String, dynamic>>? data;

  ProductModel(this.code, this.message, this.status, this.data);

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  ProductModel.withError(String error)
      : message = error,
        status = false;
}
