import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/data/model/family_member_model.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/data/model/son_model.dart';


abstract class FamilyMemberRemoteDataSource {

  Future<List<FamilyMemberModel>> getFamilyData();
  /// up tp data
  Future<void> addFamilyMember(FamilyMemberModel member , List<SonModel> sons);
  Future<void> updateFamilyMember(FamilyMemberModel member, List<SonModel> sons);

  Future<void> deleteFamilyMember(String memberID);

 // Future<List<FamilyMemberModel>> fetchFamily(String nationalId);
}

class FamilyMemberRemoteDataSourceImpl implements FamilyMemberRemoteDataSource {

  final FirebaseFirestore firestore;
  FamilyMemberRemoteDataSourceImpl(this.firestore);



  @override
  Future<List<FamilyMemberModel>> getFamilyData() async {
    try {
      QuerySnapshot snapshot = await firestore.collection("families").get();
      return snapshot.docs
          .map((doc) => FamilyMemberModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    }
    catch (e) {
      throw Exception("Error fetching families: $e");
    }
  }
/// up to date
  @override
  Future<void> addFamilyMember(FamilyMemberModel member , List<SonModel> sons) async {
    try {
      DocumentReference familyDocRef =
      firestore.collection("families").doc(member.nationalId);
      await familyDocRef.set(member.toMap());
      for (var son in sons)
      {
        await familyDocRef.collection("children").doc(son.sonNationalId).set(
            son.toMap());
      }} catch (e) {
      throw Exception("Error adding family: $e");
    }}
  @override
  Future<void> updateFamilyMember(FamilyMemberModel member, List<SonModel> sons) async {
    try {
      DocumentReference familyDocRef =
      firestore.collection("families").doc(member.nationalId);

      await familyDocRef.update(member.toMap());


      for (var son in sons) {
        DocumentReference sonDocRef = familyDocRef.collection("children").doc(son.sonNationalId);
        await sonDocRef.update(son.toMap());
      }
    } catch (e) {
      throw Exception("Error updating family: $e");
    }
  }

  @override
  Future<void> deleteFamilyMember(String memberID) async {
    try {
      await firestore.collection("families").doc(memberID).delete();
    } catch (e) {
      throw Exception("Error deleting family: $e");
    }
  }
}
