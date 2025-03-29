import 'package:saint_moses_the_black_system/features/add_famaily/data/model/son_model.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/domain/entites/family_member.dart';
import 'package:dartz/dartz.dart';

import '../../data/model/family_member_model.dart';

abstract class  FamilyMemberRepository {

  Future<Either<String, List<FamilyMember>>> getFamilyData();
  Future<Either<String, void>> addFamilyMember(FamilyMemberModel member , List<SonModel> sons);
  Future<Either<String, void>> updateFamilyMember(FamilyMemberModel member , List<SonModel> sons);
  Future<Either<String, void>> deleteFamilyMember(String memberID);

}