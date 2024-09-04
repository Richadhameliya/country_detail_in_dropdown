import 'dart:convert';

CountryApiModel countryApiFromJson(String str) =>
    CountryApiModel.fromJson(json.decode(str));

String countryApiToJson(CountryApiModel data) => json.encode(data.toJson());

class CountryApiModel {
  bool success;
  List<Datum> data;
  String message;

  CountryApiModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory CountryApiModel.fromJson(Map<String, dynamic> json) =>
      CountryApiModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  int id;
  String name;
  dynamic department;
  dynamic province;
  dynamic district;
  String countryCode;
  DateTime createdAt;
  DateTime updatedAt;
  List<Departmentt> departments;

  Datum({
    required this.id,
    required this.name,
    required this.department,
    required this.province,
    required this.district,
    required this.countryCode,
    required this.createdAt,
    required this.updatedAt,
    required this.departments,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        department: json["department"],
        province: json["province"],
        district: json["district"],
        countryCode: json["countryCode"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        departments: List<Departmentt>.from(
            json["departments"].map((x) => Departmentt.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "department": department,
        "province": province,
        "district": district,
        "countryCode": countryCode,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "departments": List<dynamic>.from(departments.map((x) => x.toJson())),
      };
}

class Departmentt {
  int id;
  int countryId;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  List<Province> provinces;

  Departmentt({
    required this.id,
    required this.countryId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.provinces,
  });

  factory Departmentt.fromJson(Map<String, dynamic> json) => Departmentt(
        id: json["id"],
        countryId: json["country_id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        provinces: List<Province>.from(
            json["provinces"].map((x) => Province.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country_id": countryId,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "provinces": List<dynamic>.from(provinces.map((x) => x.toJson())),
      };
}

class Province {
  int id;
  int departmentId;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  List<District> districts;

  Province({
    required this.id,
    required this.departmentId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.districts,
  });

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json["id"],
        departmentId: json["department_id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        districts: List<District>.from(
            json["districts"].map((x) => District.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "department_id": departmentId,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "districts": List<dynamic>.from(districts.map((x) => x.toJson())),
      };
}

class District {
  int id;
  int provinceId;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  District({
    required this.id,
    required this.provinceId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["id"],
        provinceId: json["province_id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "province_id": provinceId,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
