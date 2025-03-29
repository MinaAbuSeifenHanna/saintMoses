import '../../domain/entites/son_entity.dart';

class SonModel extends SonEntity {
  SonModel(
      {required super.sonName,
      required super.sonNationalId,
      required super.educationalLevel,
      required super.sonAge,
      required super.sonDateOfBirthDay,
      required super.sonHealthyStatus,
      required super.sonIllnessType,
      required super.sonType,
      required super.relationShip});

  factory SonModel.fromMap(Map<String, dynamic> map) {
    return SonModel(
      sonName: map['sonName'],
      sonNationalId: map['sonNationalId'],
      educationalLevel: map['educationalLevel'],
      sonAge: map['sonAge'],
      sonDateOfBirthDay: map['sonDateOfBirthDay'],
      sonHealthyStatus: map['sonHealthyStatus'],
      sonIllnessType: map['sonIllnessType'],
      sonType: map['sonType'],
      relationShip: map['relationShip'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sonName': sonName,
      'sonNationalId': sonNationalId,
      'educationalLevel': educationalLevel,
      'sonAge': sonAge,
      'sonDateOfBirthDay': sonDateOfBirthDay,
      'sonHealthyStatus': sonHealthyStatus,
      'sonIllnessType': sonIllnessType,
      'sonType': sonType,
      'relationShip': relationShip,
    };
  }

  SonModel copyWith({
    String? sonName,
    String? sonNationalId,
    String? sonType,
    String? educationalLevel,
    String? sonDateOfBirthDay,
    String? sonAge,
    String? sonHealthyStatus,
    String? sonIllnessType,
    String? relationShip,
  }) {
    return SonModel(
      sonName: sonName ?? this.sonName,
      sonNationalId: sonNationalId ?? this.sonNationalId,
      educationalLevel: educationalLevel ?? this.educationalLevel,
      sonAge: sonAge ?? this.sonAge,
      sonDateOfBirthDay: sonDateOfBirthDay ?? this.sonDateOfBirthDay,
      sonHealthyStatus: sonHealthyStatus ?? this.sonHealthyStatus,
      sonIllnessType: sonIllnessType ?? this.sonIllnessType,
      sonType: sonType ?? this.sonType,
      relationShip: relationShip ?? this.relationShip,
    );
  }
}
