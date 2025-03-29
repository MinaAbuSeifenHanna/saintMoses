import 'package:dartz/dartz.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/domain/repository/family_member_repository.dart';

class DeleteFamilyUseCase {
  final FamilyMemberRepository repository ;
  DeleteFamilyUseCase({
    required this.repository ,
}) ;

  Future<Either<String , void>> call(String memberID) async{
    return await repository.deleteFamilyMember(memberID);
  }
}