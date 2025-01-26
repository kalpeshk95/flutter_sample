// To parse this JSON data, do
//
//     final userDetails = userDetailsFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'user_details.g.dart';

List<UserDetails> userDetailsFromJson(String str) => List<UserDetails>.from(json.decode(str).map((x) => UserDetails.fromJson(x)));

String userDetailsToJson(List<UserDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class UserDetails {
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "first_name")
  String firstName;
  @JsonKey(name: "last_name")
  String lastName;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "gender")
  Gender gender;
  @JsonKey(name: "height")
  double height;
  @JsonKey(name: "weight")
  double weight;
  @JsonKey(name: "age")
  int age;
  @JsonKey(name: "education")
  Education education;
  @JsonKey(name: "job_details")
  JobDetails jobDetails;

  UserDetails({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.height,
    required this.weight,
    required this.age,
    required this.education,
    required this.jobDetails,
  });

  UserDetails copyWith({
    String? title,
    String? firstName,
    String? lastName,
    String? email,
    Gender? gender,
    double? height,
    double? weight,
    int? age,
    Education? education,
    JobDetails? jobDetails,
  }) =>
      UserDetails(
        title: title ?? this.title,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        age: age ?? this.age,
        education: education ?? this.education,
        jobDetails: jobDetails ?? this.jobDetails,
      );

  factory UserDetails.fromJson(Map<String, dynamic> json) => _$UserDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}

@JsonSerializable()
class Education {
  @JsonKey(name: "degree")
  String degree;
  @JsonKey(name: "university")
  String university;

  Education({
    required this.degree,
    required this.university,
  });

  Education copyWith({
    String? degree,
    String? university,
  }) =>
      Education(
        degree: degree ?? this.degree,
        university: university ?? this.university,
      );

  factory Education.fromJson(Map<String, dynamic> json) => _$EducationFromJson(json);

  Map<String, dynamic> toJson() => _$EducationToJson(this);
}

enum Gender {
  @JsonValue("Agender")
  AGENDER,
  @JsonValue("Female")
  FEMALE,
  @JsonValue("Male")
  MALE
}

final genderValues = EnumValues({
  "Agender": Gender.AGENDER,
  "Female": Gender.FEMALE,
  "Male": Gender.MALE
});

@JsonSerializable()
class JobDetails {
  @JsonKey(name: "job_title")
  String jobTitle;
  @JsonKey(name: "company")
  String company;
  @JsonKey(name: "country")
  String country;

  JobDetails({
    required this.jobTitle,
    required this.company,
    required this.country,
  });

  JobDetails copyWith({
    String? jobTitle,
    String? company,
    String? country,
  }) =>
      JobDetails(
        jobTitle: jobTitle ?? this.jobTitle,
        company: company ?? this.company,
        country: country ?? this.country,
      );

  factory JobDetails.fromJson(Map<String, dynamic> json) => _$JobDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$JobDetailsToJson(this);
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
