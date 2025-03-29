import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/presentation/manager/family_cubit.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/presentation/views/widets/textEditingController.dart';

import '../../../../../core/local/app_local.dart';
import '../../../../../core/widgets/customTextFormField.dart';

class DeceasedWidget extends StatelessWidget {
  const DeceasedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<FamilyCubit, FamilyState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Column(
      children: [
        /// theDeceased
        CustomTextFormField(
          controller: TextEditingControllerApp.theDeceasedController,
          labelText: AppLocale.the_deceased.getString(context),
          hintText: AppLocale.the_deceased.getString(context),
          prefixIcon: Icons.person_off,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.deceasedValidation.getString(context);
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        /// itWorks
        CustomTextFormField(
          controller: TextEditingControllerApp.itWorksController,
          labelText: AppLocale.it_works.getString(context),
          hintText: AppLocale.it_works.getString(context),
          prefixIcon: Icons.work_history,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.workedValidation.getString(context);
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        ///valueOfPension
        CustomTextFormField(
          controller: TextEditingControllerApp.valueOfPensionController,
          labelText: AppLocale.value_of_pension.getString(context),
          hintText: AppLocale.value_of_pension.getString(context),
          prefixIcon: Icons.monetization_on,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.valueOfPensionValidation.getString(context);
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        /// sourcesOfIncome
        CustomTextFormField(
          controller: TextEditingControllerApp.sourcesOfIncomeController,
          labelText: AppLocale.sources_of_income.getString(context),
          hintText: AppLocale.sources_of_income.getString(context),
          prefixIcon: Icons.source_outlined,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.sourcesOfIncomeValidation.getString(context);
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        /// propertyOrLeases
        CustomTextFormField(
          controller: TextEditingControllerApp.propertyOrLeasesController,
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
        ),
        const SizedBox(height: 16),

      ],
    );
  },
);
  }
}
