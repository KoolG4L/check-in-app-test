import 'dart:convert';

import 'package:equatable/equatable.dart';

class CheckHistoryModel extends Equatable {
  final int id;
  final double latitude;
  final double longitude;
  final String datetime;
  final String imageurl;
  const CheckHistoryModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.datetime,
    required this.imageurl,
  });

  CheckHistoryModel copyWith({
    int? id,
    double? latitude,
    double? longitude,
    String? datetime,
    String? imageurl,
  }) {
    return CheckHistoryModel(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      datetime: datetime ?? this.datetime,
      imageurl: imageurl ?? this.imageurl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'datetime': datetime,
      'imageurl': imageurl,
    };
  }

  factory CheckHistoryModel.fromMap(Map<String, dynamic> map) {
    return CheckHistoryModel(
      id: map['id']?.toInt() ?? 0,
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      datetime: map['datetime'] ?? '',
      imageurl: map['imageurl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckHistoryModel.fromJson(String source) =>
      CheckHistoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CheckHistoryModel(id: $id, latitude: $latitude, longitude: $longitude, datetime: $datetime, imageurl: $imageurl)';
  }

  @override
  List<Object> get props {
    return [
      id,
      latitude,
      longitude,
      datetime,
      imageurl,
    ];
  }
}
