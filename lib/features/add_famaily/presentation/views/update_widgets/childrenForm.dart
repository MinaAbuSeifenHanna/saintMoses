import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:saint_moses_the_black_system/features/add_famaily/presentation/manager/family_cubit.dart';
import '../../../../../core/local/app_local.dart';
import '../../../../../core/widgets/customTextFormField.dart';
import '../../../data/model/son_model.dart';
import '../../manager/family_cubit.dart';
import '../../manager/family_cubit.dart';
import '../../manager/family_cubit.dart';
import '../widets/textEditingController.dart';

class ChildrenForm extends StatefulWidget {
  ChildrenForm({super.key, required this.sonsData , required this.familyNationalId});
  final String familyNationalId ;
  bool areAdding = false;
  bool isSick = false;
  final List<SonModel> sonsData;

  @override
  State<ChildrenForm> createState() => _ChildrenFormState();
}

class _ChildrenFormState extends State<ChildrenForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    print('${widget.sonsData[1].toMap()}\n${widget.sonsData[1].toMap()}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 
              widget
              .sonsData
              .length, //context.read<FamilyCubit>().sonsData.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${AppLocale.sonData.getString(context)}${index + 1}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    // name
                    CustomTextFormField(
                      initial: widget.sonsData[index].sonName,
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
                        context.read<FamilyCubit>().sonsData[index] =
                            widget.sonsData[index].copyWith(sonName: value);
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 16),
                    // id
                    CustomTextFormField(
                      initial: widget.sonsData[index].sonNationalId,
                      labelText: AppLocale.ID.getString(context),
                      keyboardType: TextInputType.number,
                      hintText: AppLocale.ID.getString(context),
                      prefixIcon: Icons.insert_drive_file_rounded,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocale.nationalIDValidation
                              .getString(context);
                        }
                        return null;
                      },
                      onChange: (value) {
                        context.read<FamilyCubit>().sonsData[index] = widget
                            .sonsData[index]
                            .copyWith(sonNationalId: value);
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 16),
                    // type
                    DropdownButtonFormField(
                      value: widget.sonsData[index].sonType,
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
                      ]
                          .map((e) =>
                              DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocale.typeValidation.getString(context);
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context.read<FamilyCubit>().sonsData[index] =
                            widget.sonsData[index].copyWith(sonType: value);
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 16),
                    // edu level
                    DropdownButtonFormField(
                      value: widget.sonsData[index].educationalLevel,
                      decoration: InputDecoration(
                          hintText:
                              AppLocale.educationalLevel.getString(context),
                          prefixIcon: const Icon(Icons.history_edu),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                          labelText:
                              AppLocale.educationalLevel.getString(context)),
                      items: [
                        AppLocale.student.getString(context),
                        AppLocale.intermediateEducation.getString(context),
                        AppLocale.higherEducation.getString(context),
                        AppLocale.uneducated.getString(context)
                      ]
                          .map((e) =>
                              DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        context.read<FamilyCubit>().sonsData[index] = widget
                            .sonsData[index]
                            .copyWith(educationalLevel: value);
                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocale.eduLevelValidation
                              .getString(context);
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    //  birthDay
                    TextFormField(
                      initialValue: widget.sonsData[index].sonDateOfBirthDay,
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
                            context.read<FamilyCubit>().sonsData[index] =
                                widget.sonsData[index].copyWith(
                                    sonDateOfBirthDay: formattedDate);
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocale.birthdayValidation
                              .getString(context);
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    //  status
                    DropdownButtonFormField(
                        value: widget.sonsData[index].sonHealthyStatus,
                        decoration: InputDecoration(
                            hintText:
                                AppLocale.healthStatus.getString(context),
                            prefixIcon: const Icon(Icons.health_and_safety),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide:
                                  const BorderSide(color: Colors.blue),
                            ),
                            labelText:
                                AppLocale.healthStatus.getString(context)),
                        items: [
                          AppLocale.goodHealth.getString(context),
                          AppLocale.sick.getString(context)
                        ]
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            context.read<FamilyCubit>().sonsData[index] =
                                widget.sonsData[index]
                                    .copyWith(sonHealthyStatus: value);
      
                            /// error
                            // childrenData[widget.index]['isSick'] =
                            //     value == AppLocale.sick.getString(context);
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocale.healthStatusValidation
                                .getString(context);
                          }
                          return null;
                        }),
                    const SizedBox(height: 16),
                    if (widget.sonsData[index].sonHealthyStatus == 'مريض')
                      CustomTextFormField(
                        initial: widget.sonsData[index].sonIllnessType,
                        labelText: AppLocale.typeOfIllness.getString(context),
                        hintText: AppLocale.typeOfIllness.getString(context),
                        prefixIcon: Icons.disabled_by_default,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocale.typeValidation
                                .getString(context);
                          }
                          return null;
                        },
                        onChange: (value) {
                          context.read<FamilyCubit>().sonsData[index] = widget
                              .sonsData[index]
                              .copyWith(sonIllnessType: value);
                          setState(() {});
                        },
                      ),
      
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      initial: widget.sonsData[index].relationShip,
                      labelText: AppLocale.relationShip.getString(context),
                      hintText: AppLocale.relationShip.getString(context),
                      prefixIcon: Icons.people_alt_rounded,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocale.relationShip.getString(context);
                        }
                        return null;
                      },
                      onChange: (value) {
                        context.read<FamilyCubit>().sonsData[index] = widget
                            .sonsData[index]
                            .copyWith(relationShip: value);
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            );
          }),

      // if (widget.areAdding)
      //   Expanded(
      //     child: Column(
      //       children: [
      //         const SizedBox(height: 16),
      //         // name
      //         CustomTextFormField(
      //           controller: TextEditingControllerApp.personNameController,
      //           labelText: AppLocale.the_full_name.getString(context),
      //           hintText: AppLocale.the_full_name.getString(context),
      //           prefixIcon: Icons.person,
      //           validator: (value) {
      //             if (value == null || value.isEmpty) {
      //               return AppLocale.nameValidation.getString(context);
      //             }
      //             return null;
      //           },
      //         ),
      //         const SizedBox(height: 16),
      //         // id
      //         CustomTextFormField(
      //           controller: TextEditingControllerApp.personNationalIDController,
      //           labelText: AppLocale.ID.getString(context),
      //           keyboardType: TextInputType.number,
      //           hintText: AppLocale.ID.getString(context),
      //           prefixIcon: Icons.insert_drive_file_rounded,
      //           validator: (value) {
      //             if (value == null || value.isEmpty) {
      //               return AppLocale.nationalIDValidation.getString(context);
      //             }
      //             return null;
      //           },
      //         ),
      //         const SizedBox(height: 16),
      //         // type
      //         DropdownButtonFormField(
      //           decoration: InputDecoration(
      //               hintText: AppLocale.personType.getString(context),
      //               prefixIcon: const Icon(Icons.six_ft_apart),
      //               border: OutlineInputBorder(
      //                   borderRadius: BorderRadius.circular(8.0)),
      //               focusedBorder: OutlineInputBorder(
      //                 borderRadius: BorderRadius.circular(8.0),
      //                 borderSide: const BorderSide(color: Colors.blue),
      //               ),
      //               labelText: AppLocale.personType.getString(context)),
      //           items: [
      //             AppLocale.male.getString(context),
      //             AppLocale.female.getString(context)
      //           ]
      //               .map((e) => DropdownMenuItem(value: e, child: Text(e)))
      //               .toList(),
      //           validator: (value) {
      //             if (value == null || value.isEmpty) {
      //               return AppLocale.typeValidation.getString(context);
      //             }
      //             return null;
      //           },
      //           onChanged: (value) {
      //             TextEditingControllerApp.personTypeController.text = value!;
      //             setState(() {});
      //           },
      //         ),
      //         const SizedBox(height: 16),
      //         // edu level
      //         DropdownButtonFormField(
      //           decoration: InputDecoration(
      //               hintText: AppLocale.educationalLevel.getString(context),
      //               prefixIcon: const Icon(Icons.history_edu),
      //               border: OutlineInputBorder(
      //                   borderRadius: BorderRadius.circular(8.0)),
      //               focusedBorder: OutlineInputBorder(
      //                 borderRadius: BorderRadius.circular(8.0),
      //                 borderSide: const BorderSide(color: Colors.blue),
      //               ),
      //               labelText: AppLocale.educationalLevel.getString(context)),
      //           items: [
      //             AppLocale.student.getString(context),
      //             AppLocale.intermediateEducation.getString(context),
      //             AppLocale.higherEducation.getString(context),
      //             AppLocale.uneducated.getString(context)
      //           ]
      //               .map((e) => DropdownMenuItem(value: e, child: Text(e)))
      //               .toList(),
      //           onChanged: (value) {
      //             TextEditingControllerApp.personEducationalController.text =
      //                 value!;
      //             setState(() {});
      //           },
      //           validator: (value) {
      //             if (value == null || value.isEmpty) {
      //               return AppLocale.eduLevelValidation.getString(context);
      //             }
      //             return null;
      //           },
      //         ),
      //         const SizedBox(height: 16),
      //         //  birthDay
      //         TextFormField(
      //           decoration: InputDecoration(
      //             hintText: AppLocale.dateOfBirth.getString(context),
      //             prefixIcon: const Icon(Icons.date_range_sharp),
      //             border: OutlineInputBorder(
      //                 borderRadius: BorderRadius.circular(8.0)),
      //             focusedBorder: OutlineInputBorder(
      //               borderRadius: BorderRadius.circular(8.0),
      //               borderSide: const BorderSide(color: Colors.blue),
      //             ),
      //             labelText: AppLocale.dateOfBirth.getString(context),
      //           ),
      //           readOnly: true,
      //           onTap: () async {
      //             DateTime? pickedDate = await showDatePicker(
      //               context: context,
      //               initialDate: DateTime.now(),
      //               firstDate: DateTime(1900),
      //               lastDate: DateTime.now(),
      //             );
      //
      //             if (pickedDate != null) {
      //               String formattedDate =
      //                   DateFormat('yyyy-MM-dd').format(pickedDate);
      //               setState(() {
      //                 TextEditingControllerApp.personBirthdayController.text =
      //                     formattedDate;
      //               });
      //             }
      //           },
      //           validator: (value) {
      //             if (value == null || value.isEmpty) {
      //               return AppLocale.birthdayValidation.getString(context);
      //             }
      //             return null;
      //           },
      //         ),
      //         const SizedBox(height: 16),
      //         //  status
      //         DropdownButtonFormField(
      //             decoration: InputDecoration(
      //                 hintText: AppLocale.healthStatus.getString(context),
      //                 prefixIcon: const Icon(Icons.health_and_safety),
      //                 border: OutlineInputBorder(
      //                     borderRadius: BorderRadius.circular(8.0)),
      //                 focusedBorder: OutlineInputBorder(
      //                   borderRadius: BorderRadius.circular(8.0),
      //                   borderSide: const BorderSide(color: Colors.blue),
      //                 ),
      //                 labelText: AppLocale.healthStatus.getString(context)),
      //             items: [
      //               AppLocale.goodHealth.getString(context),
      //               AppLocale.sick.getString(context)
      //             ]
      //                 .map((e) => DropdownMenuItem(value: e, child: Text(e)))
      //                 .toList(),
      //             onChanged: (value) {
      //               setState(() {
      //                 TextEditingControllerApp.personStatusController.text =
      //                     value!;
      //                 if (value == AppLocale.sick.getString(context)) {
      //                   widget.isSick = true;
      //                 }
      //               });
      //             },
      //             validator: (value) {
      //               if (value == null || value.isEmpty) {
      //                 return AppLocale.healthStatusValidation
      //                     .getString(context);
      //               }
      //               return null;
      //             }),
      //         const SizedBox(height: 16),
      //         if (widget.isSick)
      //           CustomTextFormField(
      //             controller:
      //                 TextEditingControllerApp.personIllnessTypeController,
      //             labelText: AppLocale.typeOfIllness.getString(context),
      //             hintText: AppLocale.typeOfIllness.getString(context),
      //             prefixIcon: Icons.disabled_by_default,
      //             validator: (value) {
      //               if (value == null || value.isEmpty) {
      //                 return AppLocale.typeValidation.getString(context);
      //               }
      //               return null;
      //             },
      //           ),
      //
      //         const SizedBox(height: 16),
      //         CustomTextFormField(
      //           controller: TextEditingControllerApp.relationShipController,
      //           labelText: AppLocale.relationShip.getString(context),
      //           hintText: AppLocale.relationShip.getString(context),
      //           prefixIcon: Icons.people_alt_rounded,
      //           validator: (value) {
      //             if (value == null || value.isEmpty) {
      //               return AppLocale.relationShip.getString(context);
      //             }
      //             return null;
      //           },
      //         ),
      //         IconButton(onPressed: (){
      //       if (_formKey.currentState!.validate()) {
      //     context.read<FamilyCubit>().addSonToFamily(
      //         widget.familyNationalId,
      //     SonModel(
      //         sonName: TextEditingControllerApp.personNameController.text,
      //         sonNationalId: TextEditingControllerApp.personNationalIDController.text,
      //         educationalLevel: TextEditingControllerApp.personEducationalController.text,
      //         sonAge: '',
      //         sonDateOfBirthDay: TextEditingControllerApp.personBirthdayController.text,
      //         sonHealthyStatus: TextEditingControllerApp.personStatusController.text,
      //         sonIllnessType: TextEditingControllerApp.personIllnessTypeController.text,
      //         sonType: TextEditingControllerApp.personTypeController.text,
      //         relationShip: TextEditingControllerApp.relationShipController.text
      //     )
      //     ).then((onValue){
      //       TextEditingControllerApp.personNameController.clear();
      //       TextEditingControllerApp.personNationalIDController.clear();
      //       TextEditingControllerApp.personEducationalController.clear();
      //
      //       TextEditingControllerApp.personBirthdayController.clear();
      //       TextEditingControllerApp.personStatusController.clear();
      //       TextEditingControllerApp.personIllnessTypeController.clear();
      //
      //       TextEditingControllerApp.personTypeController.clear();
      //       TextEditingControllerApp.relationShipController.clear();
      //       widget.areAdding = false ;
      //
      //     });
      //       }
      //         }, icon: Icon(Icons.save))
      //       ],
      //     ),
      //   )
    ]);
  }


}
