import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/presentation/views/widets/textEditingController.dart';
import '../../../../../core/local/app_local.dart';
import '../../../../../core/widgets/customTextFormField.dart';
import '../../manager/family_cubit.dart';

class DataOfAddFamilyPartOneWidget extends StatelessWidget {
  const DataOfAddFamilyPartOneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FamilyCubit, FamilyState>(
    listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Column(
      children: [
        /// name
        CustomTextFormField(
          controller: TextEditingControllerApp.fullNameController,
          labelText: AppLocale.the_full_name.getString(context),
          hintText: AppLocale.the_full_name.getString(context),
          prefixIcon: Icons.person,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.nameValidation.getString(context);
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        /// national id
        CustomTextFormField(
          controller: TextEditingControllerApp.nationalIdController,
          labelText: AppLocale.ID.getString(context),
          hintText: AppLocale.ID.getString(context),
          keyboardType: TextInputType.number,
          prefixIcon: Icons.credit_card,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.nationalIDValidation.getString(context);
            }
            if (value.length != 14 || !RegExp(r'^\d{14}$').hasMatch(value)) {
              return AppLocale.IDFourDigitValidation.getString(context);
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        /// phone number
        CustomTextFormField(
          controller: TextEditingControllerApp.phoneNumberController,
          labelText: AppLocale.phone_number.getString(context),
          hintText: AppLocale.phone_number.getString(context),
          keyboardType: TextInputType.phone,
          prefixIcon: Icons.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.phoneNumberValidation.getString(context);
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        /// address
        CustomTextFormField(
          controller: TextEditingControllerApp.addressController,
          labelText: AppLocale.the_address_detail.getString(context),
          hintText: AppLocale.the_address_detail.getString(context),
          prefixIcon: Icons.home,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.addressValidation.getString(context);
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        /// area
        CustomTextFormField(
          controller: TextEditingControllerApp.areaController,
          labelText: AppLocale.area.getString(context),
          hintText: AppLocale.area.getString(context),
          prefixIcon: Icons.home,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.areaValidation.getString(context);
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        /// diocese
        CustomTextFormField(
          controller: TextEditingControllerApp.dioceseController,
          labelText: AppLocale.diocese.getString(context),
          hintText: AppLocale.diocese.getString(context),
          prefixIcon: Icons.map,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.dioceseValidation.getString(context);
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        /// fatherBishop
        CustomTextFormField(
          controller: TextEditingControllerApp.fatherBishopController,
          labelText: AppLocale.father_Bishop.getString(context),
          hintText: AppLocale.father_Bishop.getString(context),
          prefixIcon: Icons.person,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.fatherBishopValidation.getString(context);
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        /// church
        CustomTextFormField(
          controller: TextEditingControllerApp.churchController,
          labelText: AppLocale.church.getString(context),
          hintText: AppLocale.church.getString(context),
          prefixIcon: Icons.church,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.churchValidation.getString(context);
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        ///assistanceAmount
        CustomTextFormField(
          controller: TextEditingControllerApp.assistanceAmountController,
          labelText: AppLocale.assistance_amount.getString(context),
          hintText: AppLocale.assistance_amount.getString(context),
          prefixIcon: Icons.church,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.assistanceAmountValidation.getString(context);
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        
        ///----------------------------------------- 
        Card(

          child: CheckboxListTile(
            title: Text(AppLocale.the_deceased.getString(context)),
            value: context.read<FamilyCubit>().isDeceased,// isDeceased,
            onChanged: (value) {
              context.read<FamilyCubit>().isDeceasedCheck(value!);
            },
            checkboxShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide( width: 2),
            ),
          ),
        ),
        const SizedBox(height: 16),

      ],
    );
  },
);
  }
}
