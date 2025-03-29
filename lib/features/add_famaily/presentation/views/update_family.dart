import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/data/model/son_model.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/presentation/manager/family_cubit.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/presentation/views/homeVeiw.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/presentation/views/update_widgets/fields.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/presentation/views/widets/dataOfAddFamliyPartOneWidget.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/presentation/views/widets/deceasedWidget.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/presentation/views/widets/textEditingController.dart';
import '../../../../core/local/app_local.dart';
import '../../../../core/widgets/customTextFormField.dart';
import '../../data/model/family_member_model.dart';
import 'package:intl/intl.dart';

class UpdateFamily extends StatefulWidget {
  final FamilyMemberModel memberModel;
  final List<SonModel> sonsData;
  const UpdateFamily(
      {super.key, required this.memberModel, required this.sonsData});

  @override
  _UpdateFamilyState createState() => _UpdateFamilyState();
}

class _UpdateFamilyState extends State<UpdateFamily> {
//  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FamilyCubit, FamilyState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(

            title: Text(AppLocale.update_family.getString(context)),
            centerTitle: true,

          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FieldsUpdate(
                    memberModel: widget.memberModel,
                    sonsData: widget.sonsData ?? [],
                ),

                ElevatedButton.icon(
                  onPressed: _saveData,
                  icon: const Icon(Icons.save),
                  label: Text(AppLocale.update_family.getString(context)),

                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _saveData() {

    {
      FamilyCubit()
          .updateMember(
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
          assistanceAmount:
              TextEditingControllerApp.assistanceAmountController.text,
          dataForWidowsAndOrphans:
              TextEditingControllerApp.dataForWidowsAndOrphansController.text,
          theDeceased: TextEditingControllerApp.theDeceasedController.text,
          itWorks: TextEditingControllerApp.itWorksController.text,
          valueOfPension:
              TextEditingControllerApp.valueOfPensionController.text,
          sourcesOfIncome:
              TextEditingControllerApp.sourcesOfIncomeController.text,
          propertyOrLeases:
              TextEditingControllerApp.propertyOrLeasesController.text,
          fatherName: TextEditingControllerApp.fatherNameController.text,
          dateOfSearch: DateTime.now().toString(),
          fatherPhone: TextEditingControllerApp.fatherPhoneController.text,
          fatherReport: TextEditingControllerApp.fatherReportController.text,
          serverName: TextEditingControllerApp.serverNameController.text,
          serverPhone: TextEditingControllerApp.serverPhoneController.text,
          writtenBy: TextEditingControllerApp
              .nameOfPersonWhoWriteSearchController.text,
          numberOfSons:int.tryParse(TextEditingControllerApp.numberOfChildrenInFamilyController.text) ?? 0  ,
      )  ,
          context.read<FamilyCubit>().sonsData  ,

      )
          .then((onValue) {
            print(context.read<FamilyCubit>().sonsData);
            print(TextEditingControllerApp.fullNameController.text);
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
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
      });
    }
  }
}
