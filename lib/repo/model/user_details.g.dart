// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetails(
      title: json['title'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      age: (json['age'] as num).toInt(),
      education: Education.fromJson(json['education'] as Map<String, dynamic>),
      jobDetails:
          JobDetails.fromJson(json['job_details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'title': instance.title,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'gender': _$GenderEnumMap[instance.gender]!,
      'height': instance.height,
      'weight': instance.weight,
      'age': instance.age,
      'education': instance.education,
      'job_details': instance.jobDetails,
    };

const _$GenderEnumMap = {
  Gender.AGENDER: 'Agender',
  Gender.FEMALE: 'Female',
  Gender.MALE: 'Male',
};

Education _$EducationFromJson(Map<String, dynamic> json) => Education(
      degree: json['degree'] as String,
      university: json['university'] as String,
    );

Map<String, dynamic> _$EducationToJson(Education instance) => <String, dynamic>{
      'degree': instance.degree,
      'university': instance.university,
    };

JobDetails _$JobDetailsFromJson(Map<String, dynamic> json) => JobDetails(
      jobTitle: json['job_title'] as String,
      company: json['company'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$JobDetailsToJson(JobDetails instance) =>
    <String, dynamic>{
      'job_title': instance.jobTitle,
      'company': instance.company,
      'country': instance.country,
    };
