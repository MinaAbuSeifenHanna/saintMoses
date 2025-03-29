import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../../../../core/local/app_local.dart';
import '../../../../../core/widgets/customTextFormField.dart';
import '../../../data/model/family_member_model.dart';
import '../../../data/model/son_model.dart';
import '../widets/textEditingController.dart';

class OtherDetails extends StatelessWidget {
   OtherDetails({super.key , required this.memberModel ,required this.sonsData});
  final FamilyMemberModel memberModel;
  final List<SonModel> sonsData;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //report
        CustomTextFormField(
          initial:   memberModel.fatherReport,
          labelText: AppLocale.reportByThePriest.getString(context),
          hintText: AppLocale.reportByThePriest.getString(context),
          prefixIcon: Icons.add_card_rounded,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.fatherReportValidation.getString(context);
            }
            return null;
          },
          onChange: (value){
            TextEditingControllerApp.fatherReportController.text =value ;
          },
        ),
        const SizedBox(height: 16),
        // name of the father
        CustomTextFormField(
          initial:   memberModel.fatherName,
          labelText: AppLocale.responsiblePriest.getString(context),
          hintText: AppLocale.responsiblePriest.getString(context),
          prefixIcon: Icons.person,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.fatherNameValidation.getString(context);
            }
            return null;
          },
          onChange: (value){
            TextEditingControllerApp.fatherNameController.text =value ;
          },
        ),
        const SizedBox(height: 16),
        // phone  of the father
        CustomTextFormField(
          initial:   memberModel.fatherPhone,
          labelText: AppLocale.responsiblePriestMobileNumber.getString(context),
          hintText: AppLocale.responsiblePriestMobileNumber.getString(context),
          prefixIcon: Icons.numbers,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.fatherPhoneNumberValidation.getString(context);
            }
            return null;
          },
          onChange: (value){
            TextEditingControllerApp.fatherPhoneController.text =value ;
          },
        ),
        const SizedBox(height: 16),
        // name  of the server
        CustomTextFormField(
          initial:   memberModel.serverName,
          labelText: AppLocale.responsibleServant.getString(context),
          hintText: AppLocale.responsibleServant.getString(context),
          prefixIcon: Icons.person,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.serverNameValidation.getString(context);
            }
            return null;
          },
          onChange: (value){
            TextEditingControllerApp.serverNameController.text =value ;
          },
        ),
        const SizedBox(height: 16),
        // phone  of the server
        CustomTextFormField(
          initial:  memberModel.serverPhone,
          labelText:
          AppLocale.responsibleServantMobileNumber.getString(context),
          hintText: AppLocale.responsiblePriestMobileNumber.getString(context),
          prefixIcon: Icons.numbers,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.serverPhoneNumberValidation.getString(context);
            }
            return null;
          },
          onChange: (value){
            TextEditingControllerApp.serverPhoneController.text =value ;
          },
        ),
        const SizedBox(height: 16),
        // writer search
        CustomTextFormField(
          initial:   memberModel.writtenBy,
          labelText: AppLocale.writeBy.getString(context),
          hintText: AppLocale.writeBy.getString(context),
          prefixIcon: Icons.person,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.writtenByValidation.getString(context);
            }
            return null;
          },
          onChange: (value){
            TextEditingControllerApp.nameOfPersonWhoWriteSearchController.text =value ;
          },
        ),
        const SizedBox(height: 16),

      ],
    );
  }
}
