part of 'family_cubit.dart';

@immutable
sealed class FamilyState {}

final class FamilyInitial extends FamilyState {}

/// add states
 final class AddMemberLoadingState extends FamilyState {}
final class AddMemberSuccessState extends FamilyState {}
final class AddMemberFailState extends FamilyState {
  final String error ;
  AddMemberFailState({required this.error});
}
/// get
final class GetMembersLoadingState extends FamilyState {}
final class GetMembersSuccessState extends FamilyState {}
final class GetMembersFailState extends FamilyState {
  final String error ;
  GetMembersFailState({required this.error});
}
/// update
final class UpdateMemberLoadingState extends FamilyState {}
final class UpdateMemberSuccessState extends FamilyState {}
final class UpdateMemberFailState extends FamilyState {
  final String error ;
  UpdateMemberFailState({required this.error});
}
/// delete
final class DeleteMemberLoadingState extends FamilyState {}
final class DeleteMemberSuccessState extends FamilyState {}
final class DeleteMemberFailState extends FamilyState {
  final String error ;
  DeleteMemberFailState({required this.error});
}


final class ChangeIsDeceasedCheckSuccess extends FamilyState {}

final class FamilyIsExist extends FamilyState {}
/// add son status
