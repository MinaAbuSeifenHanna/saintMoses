import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../../../../core/local/app_local.dart';
import '../../../../../core/widgets/customTextFormField.dart';
import '../../../data/model/family_member_model.dart';
import '../widets/textEditingController.dart';

class TheDeceasedData extends StatefulWidget {
  const TheDeceasedData({super.key , required this.memberModel});
  final FamilyMemberModel memberModel;
  @override
  State<TheDeceasedData> createState() => _TheDeceasedDataState();
}

class _TheDeceasedDataState extends State<TheDeceasedData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// theDeceased
        CustomTextFormField(
          initial: widget.memberModel.theDeceased,
          labelText: AppLocale.the_deceased.getString(context),
          hintText: AppLocale.the_deceased.getString(context),
          prefixIcon: Icons.person_off,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.deceasedValidation.getString(context);
            }
            return null;
          },
          onChange: (value){
            TextEditingControllerApp.theDeceasedController.text = value;
          },

        ),
        const SizedBox(height: 16),
        /// itWorks
        CustomTextFormField(
          initial: widget.memberModel.itWorks,
          labelText: AppLocale.it_works.getString(context),
          hintText: AppLocale.it_works.getString(context),
          prefixIcon: Icons.work_history,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.workedValidation.getString(context);
            }
            return null;
          },
          onChange: (value){
            TextEditingControllerApp.itWorksController.text = value;
          },
        ),
        const SizedBox(height: 16),
        ///valueOfPension
        CustomTextFormField(
          initial: widget.memberModel.valueOfPension,
          labelText: AppLocale.value_of_pension.getString(context),
          hintText: AppLocale.value_of_pension.getString(context),
          prefixIcon: Icons.monetization_on,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.valueOfPensionValidation.getString(context);
            }
            return null;
          },
          onChange: (value){
            TextEditingControllerApp.valueOfPensionController.text = value;
          },
        ),
        const SizedBox(height: 16),
        /// sourcesOfIncome
        CustomTextFormField(
          initial: widget.memberModel.sourcesOfIncome,
          labelText: AppLocale.sources_of_income.getString(context),
          hintText: AppLocale.sources_of_income.getString(context),
          prefixIcon: Icons.source_outlined,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.sourcesOfIncomeValidation.getString(context);
            }
            return null;
          },
          onChange: (value){
            TextEditingControllerApp.sourcesOfIncomeController.text = value;
          },
        ),
        const SizedBox(height: 16),
        /// propertyOrLeases
        CustomTextFormField(
          initial: widget.memberModel.propertyOrLeases,
          labelText:
          AppLocale.property_or_Leases.getString(context),
          hintText: AppLocale.property_or_Leases.getString(context),
          prefixIcon: Icons.home_work_outlined,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.propertyOrLeasesValidation.getString(context);
            }
            return null;
          },
          onChange: (value){
            TextEditingControllerApp.propertyOrLeasesController.text = value;
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
