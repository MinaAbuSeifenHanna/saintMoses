 import 'package:dartz/dartz.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/domain/entites/family_member.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/domain/repository/family_member_repository.dart';

class GetFamilyUseCase {
  final FamilyMemberRepository repository ;
  GetFamilyUseCase({
    required this.repository,
});
  Future<Either<String , List<FamilyMember>>> call()
  async{
    return await repository.getFamilyData();
  }
 }