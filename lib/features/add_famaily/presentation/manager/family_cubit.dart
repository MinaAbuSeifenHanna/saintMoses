import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/data/data%20sourse/family_member_remote_data_source.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/data/model/son_model.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/data/repository/family_member_repository_Impl.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/domain/entites/family_member.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/domain/use%20case/add_family_use_case.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/domain/use%20case/delete_family_use_case.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/domain/use%20case/get_family_use_case.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/domain/use%20case/update_family_use_case.dart';

import '../../data/model/family_member_model.dart';
import '../../domain/repository/family_member_repository.dart';

part 'family_state.dart';

class FamilyCubit extends Cubit<FamilyState> {

  FamilyCubit() : super(FamilyInitial());

  bool isDeceased = false;
  isDeceasedCheck(bool isDes){
   isDeceased = isDes ;
   emit(ChangeIsDeceasedCheckSuccess());

 }

  List<SonModel> sonsData = [];
  int numberOfChildren = 0;

   UpdateFamilyUseCase updateFamilyUseCase = UpdateFamilyUseCase(repository: FamilyMemberRepositoryImpl(
           remoteDataSource: FamilyMemberRemoteDataSourceImpl(
             FirebaseFirestore.instance,)));
   AddFamilyUseCase addFamilyUseCase =AddFamilyUseCase(repository: FamilyMemberRepositoryImpl(
      remoteDataSource: FamilyMemberRemoteDataSourceImpl(
        FirebaseFirestore.instance,)));
   GetFamilyUseCase getFamilyUseCase = GetFamilyUseCase(repository: FamilyMemberRepositoryImpl(
      remoteDataSource: FamilyMemberRemoteDataSourceImpl(
        FirebaseFirestore.instance,)));
   DeleteFamilyUseCase deleteFamilyUseCase = DeleteFamilyUseCase(repository: FamilyMemberRepositoryImpl(
       remoteDataSource: FamilyMemberRemoteDataSourceImpl(
         FirebaseFirestore.instance,)));

   // add family use case
  // Future<void> addMember(FamilyMemberModel member, List<SonModel> sons) async {
  //   try {
  //     emit(AddMemberLoadingState());
  //      await FirebaseFirestore.instance
  //         .collection('families')
  //         .doc(member.nationalId)
  //         .get().then((onValue){
  //       onValue.exists;
  //       if(onValue.exists)
  //       {
  //         emit(FamilyIsExist());
  //        // emit(AddMemberFailState(error: 'العائلة مسجلة بالفعل في النظام'));
  //
  //       }
  //       else{
  //         addFamilyUseCase.call(member, sons);
  //         emit(AddMemberSuccessState());
  //
  //       }
  //     });
  //
  //   } catch (error) {
  //     emit(AddMemberFailState(error: error.toString()));
  //     print('object');
  //   }
  // }
  //
  Future<bool> addMember(FamilyMemberModel member, List<SonModel> sons) async {
    try {
      emit(AddMemberLoadingState());

      final docSnapshot = await FirebaseFirestore.instance
          .collection('families')
          .doc(member.nationalId)
          .get();

      if (docSnapshot.exists) {
        emit(FamilyIsExist()); // العائلة موجودة بالفعل
        return false; // عودة false حتى نعرف أن العائلة مسجلة
      }

      await addFamilyUseCase.call(member, sons);

      emit(AddMemberSuccessState());
      return true; // عودة true عند النجاح
    } catch (error) {
      emit(AddMemberFailState(error: error.toString()));
      print('خطأ أثناء الإضافة: $error');
      return false; // عودة false في حالة الخطأ
    }
  }

  Future<void> updateMember(FamilyMemberModel member , List<SonModel> sons) async{
    try
    {
      emit(UpdateMemberLoadingState());
      await updateFamilyUseCase.call(member, sons);
      emit(UpdateMemberSuccessState());
      print('/////////////// success');
    }
    catch(error)
    {
      print(member.toMap());
      print('////////////////////////');
      print(sons.first.toMap());

      emit(UpdateMemberFailState(error: error.toString()));
      print('/////////////// faluer\n${error.toString()}');
    }

  }

  /// add son

  Future<void> addSonToFamily(String familyNationalId, SonModel son) async {
    try {
      emit(AddMemberLoadingState());
      DocumentReference familyDocRef = FirebaseFirestore.instance.collection("families").doc(familyNationalId);
      /// إضافة الابن داخل مجموعة `children` داخل العائلة
      await familyDocRef.collection("children").doc(son.sonNationalId).set(son.toMap());
           emit(AddMemberSuccessState());
      print("Son added successfully: ${son.sonNationalId}");
    } catch (e) {
      emit(AddMemberFailState(error: e.toString()));
      print("Error adding son: $e");
      throw Exception("Error adding son: $e");

    }
  }

/// check befor add
  Future<bool> checkNationalIdExists(String nationalId) async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('families')
        .doc(nationalId) // البحث باستخدام ID مباشرة
        .get();
         print('///////////////////////');
    return docSnapshot.exists;
  }


  Future<void> deleteMember(String memberID) async{
    try
    {
      emit(DeleteMemberLoadingState());
      await deleteFamilyUseCase.call( memberID);
      emit(DeleteMemberSuccessState());
    }
    catch(error)
    {
      emit(DeleteMemberFailState(error: error.toString()));
    }

  }
  Future<void> getMembers() async{
    try
    {
      emit(GetMembersLoadingState());
      await getFamilyUseCase.call();
      emit(GetMembersSuccessState());
    }
    catch(error)
    {
      emit(GetMembersFailState(error: error.toString()));
    }

  }
}
