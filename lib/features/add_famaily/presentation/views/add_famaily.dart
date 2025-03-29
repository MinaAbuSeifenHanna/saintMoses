import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/data/model/son_model.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/presentation/manager/family_cubit.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/presentation/views/homeVeiw.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/presentation/views/widets/dataOfAddFamliyPartOneWidget.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/presentation/views/widets/deceasedWidget.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/presentation/views/widets/textEditingController.dart';
import '../../../../core/local/app_local.dart';
import '../../../../core/widgets/customTextFormField.dart';
import '../../data/model/family_member_model.dart';
import 'package:intl/intl.dart' show DateFormat;
class AddFamilyPage extends StatefulWidget {
  const AddFamilyPage({super.key});
  @override
  _AddFamilyPageState createState() => _AddFamilyPageState();
}
class _AddFamilyPageState extends State<AddFamilyPage> {
  int numberOfChildren = 0;
  List<Map<String, dynamic>> childrenData = [];
  List<SonModel> sonsData = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FamilyCubit, FamilyState>(
      listener: (context, state) {

      },
      builder: (context, state) {

        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocale.add_family.getString(context)),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const DataOfAddFamilyPartOneWidget(),
                  if (context.read<FamilyCubit>().isDeceased) ...[
                    const DeceasedWidget()
                  ],

                  ///-----------------------------------------new----------------------------------
                  CustomTextFormField(
                    keyboardType: TextInputType.number,
                    controller: TextEditingControllerApp
                        .numberOfChildrenInFamilyController,
                    labelText:
                        AppLocale.numberOfChildrenInFamily.getString(context),
                    hintText:
                        AppLocale.numberOfChildrenInFamily.getString(context),
                    prefixIcon: Icons.people,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocale.numberOfChildrenInFamily
                            .getString(context);
                      }
                      return null;
                    },
                    onChange: (value) {
                      setState(() {
                        numberOfChildren = int.tryParse(value) ?? 0;
                        childrenData =
                            List.generate(numberOfChildren, (index) => {});
                        sonsData = List.generate(
                            numberOfChildren,
                            (index) => SonModel(
                                sonName: '',
                                sonNationalId: '',
                                educationalLevel: '',
                                sonAge: '',
                                sonDateOfBirthDay: '',
                                sonHealthyStatus: '',
                                sonIllnessType: '',
                                sonType: '',
                                relationShip: '',
                            ));
                      });
                    },
                  ),

                  const SizedBox(height: 20),
                  // numberOfChildrenInFamily
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: numberOfChildren,
                    itemBuilder: (context, index) {
                      return _buildChildForm(index);
                    },
                  ),
                  const Divider(),
                  _buildOtherDetails(),
                  const SizedBox(height: 20),

                  ElevatedButton.icon(
                    onPressed: _saveData,
                    icon: const Icon(Icons.save),
                    label: Text(AppLocale.add_family.getString(context)),

                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _saveData() async {
    if (_formKey.currentState!.validate()) {
      bool isAdded = await FamilyCubit().addMember(
        FamilyMemberModel(
          fullName: TextEditingControllerApp.fullNameController.text,
          nationalId: TextEditingControllerApp.nationalIdController.text,
          phoneNumber: TextEditingControllerApp.phoneNumberController.text,
          address: TextEditingControllerApp.addressController.text,
          assistance: TextEditingControllerApp.assistanceController.text,
          pension: TextEditingControllerApp.pensionController.text,
          diocese: TextEditingControllerApp.dioceseController.text,
          fatherBishop: TextEditingControllerApp.fatherBishopController.text,
          church: TextEditingControllerApp.churchController.text,
          area: TextEditingControllerApp.areaController.text,
          assistanceAmount: TextEditingControllerApp.assistanceAmountController.text,
          dataForWidowsAndOrphans: TextEditingControllerApp.dataForWidowsAndOrphansController.text,
          theDeceased: TextEditingControllerApp.theDeceasedController.text,
          itWorks: TextEditingControllerApp.itWorksController.text,
          valueOfPension: TextEditingControllerApp.valueOfPensionController.text,
          sourcesOfIncome: TextEditingControllerApp.sourcesOfIncomeController.text,
          propertyOrLeases: TextEditingControllerApp.propertyOrLeasesController.text,
          fatherName: TextEditingControllerApp.fatherNameController.text,
          dateOfSearch: DateTime.now().toString(),
          fatherPhone: TextEditingControllerApp.fatherPhoneController.text,
          fatherReport: TextEditingControllerApp.fatherReportController.text,
          serverName: TextEditingControllerApp.serverNameController.text,
          serverPhone: TextEditingControllerApp.serverPhoneController.text,
          writtenBy: TextEditingControllerApp.nameOfPersonWhoWriteSearchController.text,
          numberOfSons: int.parse(TextEditingControllerApp.numberOfChildrenInFamilyController.text),
        ),
        sonsData,
      );

      if (!isAdded) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Center(child: Text(AppLocale.familyAdded.getString(context)))),
        );
        return;
      }


      _clearFields();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }


  void _clearFields() {
    TextEditingControllerApp.fullNameController.clear();
    TextEditingControllerApp.nationalIdController.clear();
    TextEditingControllerApp.phoneNumberController.clear();
    TextEditingControllerApp.addressController.clear();
    TextEditingControllerApp.assistanceController.clear();
    TextEditingControllerApp.pensionController.clear();
    TextEditingControllerApp.dioceseController.clear();
    TextEditingControllerApp.fatherBishopController.clear();
    TextEditingControllerApp.churchController.clear();
    TextEditingControllerApp.areaController.clear();
    TextEditingControllerApp.assistanceAmountController.clear();
    TextEditingControllerApp.dataForWidowsAndOrphansController.clear();
    TextEditingControllerApp.theDeceasedController.clear();
    TextEditingControllerApp.itWorksController.clear();
    TextEditingControllerApp.valueOfPensionController.clear();
    TextEditingControllerApp.sourcesOfIncomeController.clear();
    TextEditingControllerApp.propertyOrLeasesController.clear();
    TextEditingControllerApp.fatherNameController.clear();
    TextEditingControllerApp.fatherPhoneController.clear();
    TextEditingControllerApp.fatherReportController.clear();
    TextEditingControllerApp.serverNameController.clear();
    TextEditingControllerApp.serverPhoneController.clear();
    TextEditingControllerApp.nameOfPersonWhoWriteSearchController.clear();
    TextEditingControllerApp.numberOfChildrenInFamilyController.clear();
    TextEditingControllerApp.relationShipController.clear();
  }


  Widget _buildChildForm(int index) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${AppLocale.sonData.getString(context)}${index + 1}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            // name
            CustomTextFormField(
              //  controller: TextEditingControllerApp.personNameController,
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
                sonsData[index] = sonsData[index].copyWith(sonName: value);

                setState(() {});
              },
            ),
            const SizedBox(height: 16),
            // id
            CustomTextFormField(
              //  controller: TextEditingControllerApp.personNationalIDController,
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
              onChange: (value) {
                sonsData[index] =
                    sonsData[index].copyWith(sonNationalId: value);
                setState(() {});
              },
            ),
            const SizedBox(height: 16),
            // type
            DropdownButtonFormField(
              decoration: InputDecoration(
                  hintText: AppLocale.personType.getString(context),
                  prefixIcon: const Icon(Icons.six_ft_apart),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  labelText: AppLocale.personType.getString(context)),
              items: [
                AppLocale.male.getString(context),
                AppLocale.female.getString(context)
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocale.typeValidation.getString(context);
                }
                return null;
              },
              onChanged: (value) {
                sonsData[index] = sonsData[index].copyWith(sonType: value);
                setState(() {});
              },
            ),
            const SizedBox(height: 16),
            // edu level
            DropdownButtonFormField(
              decoration: InputDecoration(
                  hintText: AppLocale.educationalLevel.getString(context),
                  prefixIcon: const Icon(Icons.history_edu),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  labelText: AppLocale.educationalLevel.getString(context)),
              items: [
                AppLocale.student.getString(context),
                AppLocale.intermediateEducation.getString(context),
                AppLocale.higherEducation.getString(context),
                AppLocale.uneducated.getString(context)
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (value) {
                sonsData[index] =
                    sonsData[index].copyWith(educationalLevel: value);
                setState(() {});
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocale.eduLevelValidation.getString(context);
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            //  birthDay
            TextFormField(
              controller: TextEditingController(
                text: sonsData[index].sonDateOfBirthDay ?? "",
              ),
              decoration: InputDecoration(
                hintText: AppLocale.dateOfBirth.getString(context),
                prefixIcon: const Icon(Icons.date_range_sharp),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                labelText: AppLocale.dateOfBirth.getString(context),
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
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  setState(() {
                    sonsData[index] = sonsData[index]
                        .copyWith(sonDateOfBirthDay: formattedDate);
                  });
                }
              },

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocale.birthdayValidation.getString(context);
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            //  status
            DropdownButtonFormField(
                decoration: InputDecoration(
                    hintText: AppLocale.healthStatus.getString(context),
                    prefixIcon: const Icon(Icons.health_and_safety),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    labelText: AppLocale.healthStatus.getString(context)),
                items: [
                  AppLocale.goodHealth.getString(context),
                  AppLocale.sick.getString(context)
                ]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    sonsData[index] =
                        sonsData[index].copyWith(sonHealthyStatus: value);

                    childrenData[index]['isSick'] =
                        value == AppLocale.sick.getString(context);
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocale.healthStatusValidation.getString(context);
                  }
                  return null;
                }),
            const SizedBox(height: 16),
            if (childrenData[index]['isSick'] == true)
              CustomTextFormField(
                controller:
                    TextEditingControllerApp.personIllnessTypeController,
                labelText: AppLocale.typeOfIllness.getString(context),
                hintText: AppLocale.typeOfIllness.getString(context),
                prefixIcon: Icons.disabled_by_default,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocale.typeValidation.getString(context);
                  }
                  return null;
                },
                onChange: (value) {
                  sonsData[index] =
                      sonsData[index].copyWith(sonIllnessType: value);
                  setState(() {});
                },
              ),
            const SizedBox(height: 16),

            CustomTextFormField(
              labelText: AppLocale.relationShip.getString(context),
              hintText: AppLocale.relationShip.getString(context),
              prefixIcon: Icons.people_alt_rounded,

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocale.relationShip.getString(context);
                }
                return null;
              },
              onChange: (value){

                sonsData[index] = sonsData[index].copyWith(relationShip: value);
                setState(() {

                });


              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtherDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //report
        CustomTextFormField(
          controller: TextEditingControllerApp.fatherReportController,
          labelText: AppLocale.reportByThePriest.getString(context),
          hintText: AppLocale.reportByThePriest.getString(context),
          prefixIcon: Icons.add_card_rounded,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.fatherReportValidation.getString(context);
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        // name of the father
        CustomTextFormField(
          controller: TextEditingControllerApp.fatherNameController,
          labelText: AppLocale.responsiblePriest.getString(context),
          hintText: AppLocale.responsiblePriest.getString(context),
          prefixIcon: Icons.person,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.fatherNameValidation.getString(context);
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        // phone  of the father
        CustomTextFormField(
          controller: TextEditingControllerApp.fatherPhoneController,
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
        ),
        const SizedBox(height: 16),
        // name  of the server
        CustomTextFormField(
          controller: TextEditingControllerApp.serverNameController,
          labelText: AppLocale.responsibleServant.getString(context),
          hintText: AppLocale.responsibleServant.getString(context),
          prefixIcon: Icons.person,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.serverNameValidation.getString(context);
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        // phone  of the server
        CustomTextFormField(
          controller: TextEditingControllerApp.serverPhoneController,
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
        ),
        const SizedBox(height: 16),
        // writer search
        CustomTextFormField(
          controller:
              TextEditingControllerApp.nameOfPersonWhoWriteSearchController,
          labelText: AppLocale.writeBy.getString(context),
          hintText: AppLocale.writeBy.getString(context),
          prefixIcon: Icons.person,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.writtenByValidation.getString(context);
            }
            return null;
          },
        ),

        const SizedBox(height: 16),


      ],
    );
  }
}
