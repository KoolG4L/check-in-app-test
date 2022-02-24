import 'dart:convert';

import 'package:equatable/equatable.dart';

class ResultModel extends Equatable {
  final String message;
  final bool valid;
  final List? data;
  const ResultModel({
    required this.message,
    required this.valid,
    this.data,
  });

  ResultModel copyWith({
    String? message,
    bool? valid,
    List? data,
  }) {
    return ResultModel(
      message: message ?? this.message,
      valid: valid ?? this.valid,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'valid': valid,
      'data': data,
    };
  }

  factory ResultModel.fromMap(Map<String, dynamic> map) {
    return ResultModel(
      message: map['message'] ?? '',
      valid: map['valid'] ?? false,
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultModel.fromJson(String source) =>
      ResultModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ResultModel(message: $message, valid: $valid, data: $data)';

  @override
  List<Object?> get props => [message, valid, data];
}
