import 'package:dartz/dartz.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/domain/entites/family_member.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/domain/repository/family_member_repository.dart';

import '../../data/model/family_member_model.dart';
import '../../data/model/son_model.dart';

class UpdateFamilyUseCase{
  final FamilyMemberRepository repository ;
  UpdateFamilyUseCase ({ required this.repository});
  Future<Either<String,void>> call (FamilyMemberModel member , List<SonModel> sons) async {
    return await repository.updateFamilyMember(member , sons);
  }
}