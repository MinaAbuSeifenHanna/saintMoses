import 'package:dartz/dartz.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/data/data%20sourse/family_member_remote_data_source.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/data/model/family_member_model.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/data/model/son_model.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/domain/entites/family_member.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/domain/repository/family_member_repository.dart';

class FamilyMemberRepositoryImpl implements FamilyMemberRepository{
  final FamilyMemberRemoteDataSource remoteDataSource ;
  FamilyMemberRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, void>> addFamilyMember(FamilyMemberModel member , List<SonModel> sons) async {
     return  Right(await remoteDataSource.addFamilyMember(member  , sons ));

  }

  @override
  Future<Either<String, void>> deleteFamilyMember(String memberID) async{
    return  Right(await remoteDataSource.deleteFamilyMember(memberID));
  }

  @override
  Future<Either<String, List<FamilyMember>>> getFamilyData()async {
    return  Right(await remoteDataSource.getFamilyData());
  }

  @override
  Future<Either<String, void>> updateFamilyMember(FamilyMemberModel member, List<SonModel> sons) async{
    return  Right(await remoteDataSource.updateFamilyMember(member as FamilyMemberModel ,sons));
  }

}