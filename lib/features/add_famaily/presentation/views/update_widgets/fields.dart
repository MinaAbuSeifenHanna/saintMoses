import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/presentation/views/update_widgets/the_deceased_data.dart';
import '../../../../../core/local/app_local.dart';
import '../../../../../core/widgets/customTextFormField.dart';
import '../../../data/model/family_member_model.dart';
import '../../../data/model/son_model.dart';
import '../../manager/family_cubit.dart';
import '../widets/textEditingController.dart';
import 'childrenForm.dart';
import 'other_details.dart';
import 'package:intl/intl.dart' show DateFormat;


class FieldsUpdate extends StatefulWidget {


  const FieldsUpdate(
      {super.key, required this.memberModel, required this.sonsData});

  final FamilyMemberModel memberModel;
  final List<SonModel> sonsData;

  @override
  State<FieldsUpdate> createState() => _FieldsUpdateState();



}

class _FieldsUpdateState extends State<FieldsUpdate> {
  @override
  void initState() {
    if(widget.sonsData.length>0) {
      context.read<FamilyCubit>().sonsData = widget.sonsData ;
    }
    TextEditingControllerApp.fullNameController.text = widget.memberModel.fullName ;
    TextEditingControllerApp.nationalIdController.text = widget.memberModel.nationalId ;
    TextEditingControllerApp.phoneNumberController.text = widget.memberModel.phoneNumber ;
    TextEditingControllerApp.addressController.text = widget.memberModel.address ;
    TextEditingControllerApp.assistanceController.text = widget.memberModel.assistanceAmount ;
    TextEditingControllerApp.pensionController.text = widget.memberModel.pension ;
    TextEditingControllerApp.dioceseController.text = widget.memberModel.diocese ;
    TextEditingControllerApp.fatherBishopController.text = widget.memberModel.fatherBishop ;
    TextEditingControllerApp.churchController.text = widget.memberModel.church ;
    TextEditingControllerApp.areaController.text = widget.memberModel.area ;
    TextEditingControllerApp.assistanceAmountController.text = widget.memberModel.assistanceAmount ;
    TextEditingControllerApp.dataForWidowsAndOrphansController.text = widget.memberModel.dataForWidowsAndOrphans ;
    TextEditingControllerApp.theDeceasedController.text = widget.memberModel.theDeceased ;
    TextEditingControllerApp.itWorksController.text = widget.memberModel.itWorks ;
    TextEditingControllerApp.valueOfPensionController.text = widget.memberModel.valueOfPension ;
    TextEditingControllerApp.sourcesOfIncomeController.text = widget.memberModel.sourcesOfIncome ;
    TextEditingControllerApp.propertyOrLeasesController.text = widget.memberModel.propertyOrLeases ;
    TextEditingControllerApp.fatherNameController.text = widget.memberModel.fatherName ;
    TextEditingControllerApp.fatherPhoneController.text = widget.memberModel.fatherPhone ;
    TextEditingControllerApp.fatherReportController.text = widget.memberModel.fatherReport ;
    TextEditingControllerApp.serverNameController.text = widget.memberModel.serverName ;
    TextEditingControllerApp.serverPhoneController.text = widget.memberModel.serverPhone ;
    TextEditingControllerApp.nameOfPersonWhoWriteSearchController.text = widget.memberModel.writtenBy ;
    TextEditingControllerApp.numberOfChildrenInFamilyController.text = widget.memberModel.numberOfSons.toString() ;
   

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// name
        CustomTextFormField(
          initial: widget.memberModel.fullName,
          labelText: AppLocale.the_full_name.getString(context),
          hintText: AppLocale.the_full_name.getString(context),
          prefixIcon: Icons.person,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.nameValidation.getString(context);
            }
            return null;
          },
          onChange: (value) {
            setState(() {
              TextEditingControllerApp.fullNameController.text = value;
            });
          },
        ),
        const SizedBox(height: 16),
        /// national id
        CustomTextFormField(
          initial: widget.memberModel.nationalId,
          labelText: AppLocale.ID.getString(context),
          hintText: AppLocale.ID.getString(context),
          keyboardType: TextInputType.number,
          prefixIcon: Icons.credit_card,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.nationalIDValidation.getString(context);
            }
            return null;
          },
          onChange: (value) {
            setState(() {
              TextEditingControllerApp.nationalIdController.text = value;
            });
          },
        ),
        const SizedBox(height: 16),
        /// phone number
        CustomTextFormField(
          initial: widget.memberModel.phoneNumber,
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
          onChange: (value) {
            setState(() {
              TextEditingControllerApp.phoneNumberController.text = value;
            });
          },
        ),
        const SizedBox(height: 16),
        /// address
        CustomTextFormField(
          initial: widget.memberModel.address,
          labelText: AppLocale.the_address_detail.getString(context),
          hintText: AppLocale.the_address_detail.getString(context),
          prefixIcon: Icons.home,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.addressValidation.getString(context);
            }
            return null;
          },
          onChange: (value) {
            setState(() {
              TextEditingControllerApp.addressController.text = value;
            });
          },
        ),
        const SizedBox(height: 16),
        /// area
        CustomTextFormField(
          initial: widget.memberModel.area,
          labelText: AppLocale.area.getString(context),
          hintText: AppLocale.area.getString(context),
          prefixIcon: Icons.home,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.areaValidation.getString(context);
            }
            return null;
          },
          onChange: (value) {
            setState(() {
              TextEditingControllerApp.areaController.text = value;
            });
          },
        ),
        const SizedBox(height: 16),
        /// diocese
        CustomTextFormField(
          initial: widget.memberModel.diocese,
          labelText: AppLocale.diocese.getString(context),
          hintText: AppLocale.diocese.getString(context),
          prefixIcon: Icons.map,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.dioceseValidation.getString(context);
            }
            return null;
          },
          onChange: (value) {
            setState(() {
              TextEditingControllerApp.dioceseController.text = value;
            });
          },
        ),
        const SizedBox(height: 16),
        /// fatherBishop
        CustomTextFormField(
          initial: widget.memberModel.fatherBishop,
          labelText: AppLocale.father_Bishop.getString(context),
          hintText: AppLocale.father_Bishop.getString(context),
          prefixIcon: Icons.person,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.fatherBishopValidation.getString(context);
            }
            return null;
          },
          onChange: (value) {
            TextEditingControllerApp.fatherBishopController.text = value;
          },
        ),
        const SizedBox(height: 16),
        /// church
        CustomTextFormField(
          initial: widget.memberModel.church,
          labelText: AppLocale.church.getString(context),
          hintText: AppLocale.church.getString(context),
          prefixIcon: Icons.church,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.churchValidation.getString(context);
            }
            return null;
          },
          onChange: (value) {
            TextEditingControllerApp.churchController.text = value;
          },
        ),
        const SizedBox(height: 16),
        ///assistanceAmount
        CustomTextFormField(
          initial: widget.memberModel.assistanceAmount,
          labelText: AppLocale.assistance_amount.getString(context),
          hintText: AppLocale.assistance_amount.getString(context),
          prefixIcon: Icons.church,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.assistanceAmountValidation.getString(context);
            }
            return null;
          },
          onChange: (value) {
            TextEditingControllerApp.assistanceAmountController.text = value;
          },
        ),
        const SizedBox(height: 16),
        ///-------------------------------------------------------------------------------------------
        // this run in cubit don't work with database
        Card(

          child: CheckboxListTile(
            title: Text(AppLocale.the_deceased.getString(context)),
            value: context.read<FamilyCubit>().isDeceased, // isDeceased,
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
        if (context.read<FamilyCubit>().isDeceased) ...[
          TheDeceasedData(
            memberModel: widget.memberModel,
          )
        ],
    if(widget.sonsData.length>1)...[

      CustomTextFormField(
        initial: context.read<FamilyCubit>().sonsData.length.toString(),
        keyboardType: TextInputType.number,
        labelText: AppLocale.numberOfChildrenInFamily.getString(context),
        hintText: AppLocale.numberOfChildrenInFamily.getString(context),
        prefixIcon: Icons.people,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppLocale.numberOfChildrenValidation.getString(context);
          } else if (!RegExp(r'^[0-9]$').hasMatch(value)) {
            return AppLocale.oneDigitValidation.getString(context);
          }
          return null;
        },
        onChange: (value) {
          setState(() {
            context.read<FamilyCubit>().sonsData = value;
          });
        },
      ),
      const SizedBox(height: 20),
        ChildrenForm(
          familyNationalId: widget.memberModel.nationalId,
          sonsData:context.read<FamilyCubit>().sonsData,
        ),
      ],




        ElevatedButton( onPressed: () => _showAddSonDialog(context),
            child: Text(AppLocale.addSon.getString(context))),

        const Divider(),
        OtherDetails(
          memberModel: widget.memberModel,
          sonsData: widget.sonsData,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
  void _showAddSonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocale.addSon.getString(context)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  controller: TextEditingControllerApp.personNameController,
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
                CustomTextFormField(
                  controller: TextEditingControllerApp.personNationalIDController,
                  labelText: AppLocale.ID.getString(context),
                  keyboardType: TextInputType.number,
                  hintText: AppLocale.ID.getString(context),
                  prefixIcon: Icons.insert_drive_file_rounded,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocale.nationalIDValidation.getString(context);
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    hintText: AppLocale.personType.getString(context),
                    prefixIcon: const Icon(Icons.six_ft_apart),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                  items: [
                    AppLocale.male.getString(context),
                    AppLocale.female.getString(context)
                  ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (value) {
                    TextEditingControllerApp.personTypeController.text = value!;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    hintText: AppLocale.educationalLevel.getString(context),
                    prefixIcon: const Icon(Icons.history_edu),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                  items: [
                    AppLocale.student.getString(context),
                    AppLocale.intermediateEducation.getString(context),
                    AppLocale.higherEducation.getString(context),
                    AppLocale.uneducated.getString(context)
                  ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (value) {
                    TextEditingControllerApp.personEducationalController.text = value!;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller:  TextEditingControllerApp.personBirthdayController,
                  decoration: InputDecoration(
                    hintText: AppLocale.dateOfBirth.getString(context),
                    prefixIcon: const Icon(Icons.date_range_sharp),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      TextEditingControllerApp.personBirthdayController.text = formattedDate;
                    }
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    hintText: AppLocale.healthStatus.getString(context),
                    prefixIcon: const Icon(Icons.health_and_safety),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                  items: [
                    AppLocale.goodHealth.getString(context),
                    AppLocale.sick.getString(context)
                  ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (value) {
                    TextEditingControllerApp.personStatusController.text = value!;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: TextEditingControllerApp.relationShipController,
                  labelText: AppLocale.relationShip.getString(context),
                  hintText: AppLocale.relationShip.getString(context),
                  prefixIcon: Icons.people_alt_rounded,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocale.cansel.getString(context)),
            ),
            ElevatedButton(
              onPressed: () {
                // if (_formKey.currentState!.validate()) {
                context.read<FamilyCubit>().addSonToFamily(
                  widget.memberModel.nationalId ,
                  SonModel(
                    sonName: TextEditingControllerApp.personNameController.text ??'',
                    sonNationalId: TextEditingControllerApp.personNationalIDController.text??'',
                    educationalLevel: TextEditingControllerApp.personEducationalController.text??'',
                    sonAge: '',
                    sonDateOfBirthDay: TextEditingControllerApp.personBirthdayController.text??'',
                    sonHealthyStatus: TextEditingControllerApp.personStatusController.text??'',
                    sonIllnessType: TextEditingControllerApp.personIllnessTypeController.text??'',
                    sonType: TextEditingControllerApp.personTypeController.text??'',
                    relationShip: TextEditingControllerApp.relationShipController.text??'',
                  ),
                ).then((_) {
             
                  TextEditingControllerApp.personNameController.clear();
                  TextEditingControllerApp.personNationalIDController.clear();
                  TextEditingControllerApp.personEducationalController.clear();
                  TextEditingControllerApp.personBirthdayController.clear();
                  TextEditingControllerApp.personStatusController.clear();
                  TextEditingControllerApp.personIllnessTypeController.clear();
                  TextEditingControllerApp.personTypeController.clear();
                  TextEditingControllerApp.relationShipController.clear();

                  /// إغلاق الـ Dialog بعد الحفظ
                  Navigator.pop(context);
                });

              },
              child: Icon(Icons.save),
            ),
          ],
        );
      },
    );
  }
}
