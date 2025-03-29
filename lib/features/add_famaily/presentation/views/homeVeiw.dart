import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/data/model/son_model.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/presentation/manager/family_cubit.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/presentation/views/add_famaily.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/presentation/views/update_family.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/presentation/views/widets/textEditingController.dart';
import '../../../../core/local/app_local.dart';
import '../../../../core/theme/provider_theme.dart';
import '../../data/model/family_member_model.dart';
import 'package:intl/intl.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///------------------------------ start localization ----------------------
  final FlutterLocalization localization = FlutterLocalization.instance;

  void toggleLanguage() {
    setState(() {
      final currentLang = localization.currentLocale.localeIdentifier;
      final newLang = currentLang == 'en' ? 'ar' : 'en';
      localization.translate(newLang);
    });
  }

  ///---------------------------- end localization -----------------------------

  bool isDarkMode = false;
  String? id;
  List<SonModel> childrenList = [];

  // void toggleTheme() {
  //   setState(() {
  //     isDarkMode = !isDarkMode;
  //   });
  // }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.service_title.getString(context)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: toggleLanguage,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOvhPxK46PvOPXLAQDQ8WAmYjSoE9s3wg_wg&s',
                  width: 200,
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocale.service_title.getString(context),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocale.quote.getString(context),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 30),

                /// search field
                TextFormField(
                  controller: TextEditingControllerApp.searchController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: AppLocale.search_family.getString(context),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  maxLength: 14,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocale.IDValidation.getString(context);
                    } else if (!RegExp(r'^\d{14}$').hasMatch(value)) {
                      return AppLocale.IDFourDigitValidation.getString(context);
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          id = TextEditingControllerApp.searchController.text;
                        });
                      }
                    },
                    icon: const Icon(Icons.search),
                    label: Text(AppLocale.search.getString(context)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                if (id != null)

                  /// data of search
                  StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("families")
                          .doc(id
                              // TextEditingControllerApp.searchController.text
                              )
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox(
                            height: 10,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        if (!snapshot.data!.exists) {
                          return SizedBox(
                            height: 10,
                            child: Center(
                                child: Text(AppLocale.doNotExistData
                                    .getString(context))),
                          );
                        }
                        var familyData = FamilyMemberModel.fromMap(
                            snapshot.data!.data() as Map<String, dynamic>);
                        return SingleChildScrollView(
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateFamily(
                                                      memberModel: familyData,
                                                      sonsData: childrenList,
                                                    ),
                                                  ));
                                            },
                                            icon: const Icon(Icons.edit)),
                                        IconButton(
                                            onPressed: () {
                                              id = null;
                                              setState(() {});
                                              TextEditingControllerApp
                                                  .searchController
                                                  .clear();
                                            },
                                            icon: Icon(Icons.close)),
                                        IconButton(
                                          onPressed: () {
                                           context.read<FamilyCubit>().deleteMember(familyData.nationalId);
                                          },
                                          icon: const Icon(Icons.delete, color: Colors.red),
                                        ),
                                      ]),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Table(
                                          border: TableBorder.all(
                                           width: 1),

                                          columnWidths: {
                                            0: FlexColumnWidth(3),
                                            1: FlexColumnWidth(5),
                                          },
                                          children: [
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      familyData.fullName ?? '',
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      AppLocale.the_full_name
                                                          .getString(context),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                       const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      familyData.nationalId ??
                                                          '',
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                       const  EdgeInsets.all(8.0),
                                                    child: Text(
                                                      AppLocale.ID
                                                          .getString(context),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                    const  EdgeInsets.all(8.0),
                                                    child: Text(
                                                      familyData.phoneNumber,
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                    const      EdgeInsets.all(8.0),
                                                    child: Text(
                                                      AppLocale.phone_number
                                                          .getString(context),
                                                      style:const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      familyData.address,
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                    const  EdgeInsets.all(8.0),
                                                    child: Text(
                                                      AppLocale
                                                          .the_address_detail
                                                          .getString(context),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // TableRow(
                                            //   children: [
                                            //     TableCell(
                                            //       child: Padding(
                                            //         padding:
                                            //         const   EdgeInsets.all(8.0),
                                            //         child: Text(
                                            //           familyData.pension,
                                            //           textAlign:
                                            //               TextAlign.right,
                                            //         ),
                                            //       ),
                                            //     ),
                                            //     TableCell(
                                            //       child: Padding(
                                            //         padding:
                                            //             EdgeInsets.all(8.0),
                                            //         child: Text(
                                            //           AppLocale.value_of_pension
                                            //               .getString(context),
                                            //           style: TextStyle(
                                            //               fontWeight:
                                            //                   FontWeight.bold),
                                            //           textAlign:
                                            //               TextAlign.right,
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      familyData.diocese,
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      AppLocale.diocese
                                                          .getString(context),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      familyData.fatherBishop,
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      AppLocale.father_Bishop
                                                          .getString(context),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      familyData.church,
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      AppLocale.church
                                                          .getString(context),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      familyData.area,
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      AppLocale.area
                                                          .getString(context),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      familyData
                                                              .assistanceAmount ??
                                                          '',
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      AppLocale
                                                          .assistance_amount
                                                          .getString(context),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      familyData.theDeceased ??
                                                          '',
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      AppLocale.the_deceased
                                                          .getString(context),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      familyData.itWorks,
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      AppLocale.it_works
                                                          .getString(context),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      familyData.valueOfPension,
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      AppLocale.value_of_pension
                                                          .getString(context),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      familyData
                                                          .sourcesOfIncome,
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      AppLocale
                                                          .sources_of_income
                                                          .getString(context),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      familyData
                                                          .propertyOrLeases,
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      AppLocale
                                                          .property_or_Leases
                                                          .getString(context),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      DateFormat('yyyy-MM-dd').format(DateTime.parse(familyData.dateOfSearch)),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      AppLocale.researchDate
                                                          .getString(context),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      familyData.fatherName,
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      AppLocale
                                                          .responsiblePriest
                                                          .getString(context),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      familyData.fatherPhone,
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      AppLocale
                                                          .responsiblePriestMobileNumber
                                                          .getString(context),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      familyData.fatherReport,
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      AppLocale
                                                          .reportByThePriest
                                                          .getString(context),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      familyData.serverName,
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      AppLocale.responsibleServant
                                                          .getString(context),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      familyData.serverPhone,
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      AppLocale
                                                          .responsibleServantMobileNumber
                                                          .getString(context),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      familyData.writtenBy,
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      AppLocale.writeBy
                                                          .getString(context),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      familyData.area,
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      AppLocale.area
                                                          .getString(context),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("families")
                                            .doc(id)
                                            .collection('children')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const SizedBox(
                                              height: 10,
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                            );
                                          }

                                          if (!snapshot.hasData ||
                                              snapshot.data!.docs.isEmpty) {
                                            return Center(
                                                child: Text(
                                              AppLocale.doNotExistData
                                                  .getString(context),
                                            ));
                                          }
                                          childrenList =
                                              snapshot.data!.docs.map((doc) {
                                            return SonModel.fromMap(doc.data()
                                                as Map<String, dynamic>);
                                          }).toList();
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: childrenList.length,
                                            itemBuilder: (context, index) {
                                              SonModel child = childrenList[index];

                                              return Card(
                                                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                                elevation: 3,
                                                child: ListTile(
                                                  leading: const Icon(Icons.person, color: Colors.blue),
                                                  title: Text(
                                                    child.sonName,
                                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                  subtitle: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("${AppLocale.ID.getString(context)} : ${child.sonNationalId}"),
                                                      Text("${AppLocale.dateOfBirth.getString(context)} : ${child.sonDateOfBirthDay}"),
                                                      Text("${AppLocale.age.getString(context)} : ${calculateAge(child.sonDateOfBirthDay)}"),
                                                      Text("${AppLocale.relationShip.getString(context)} : ${child.relationShip}"),
                                                      Text("${AppLocale.healthStatus.getString(context)} : ${child.sonHealthyStatus}"),
                                                      Text("${AppLocale.educationalLevel.getString(context)} : ${child.educationalLevel}"),
                                                      Text("${AppLocale.personType.getString(context)} : ${child.sonType}"),
                                                    ],
                                                  ),
                                                  trailing: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      // زر تعديل البيانات
                                                      IconButton(
                                                        icon: const Icon(Icons.edit, color: Colors.orange),
                                                        onPressed: () {
                                                          _showEditDialog(context, child, id!);
                                                        },
                                                      ),
                                                      // زر حذف الفرد
                                                      IconButton(
                                                        icon: const Icon(Icons.delete, color: Colors.red),
                                                        onPressed: () {
                                                          _deleteChild(id!, child.sonNationalId);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );

                                        },
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      )
                                    ])));
                      }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddFamilyPage()));
        },
        label: Text(AppLocale.add_family.getString(context)),
        icon: const Icon(Icons.add),

      ),
    );
  }
}

int calculateAge(String birthDateString) {
  DateTime birthDate = DateTime.parse(birthDateString); // تحويل النص إلى تاريخ
  DateTime today = DateTime.now(); // الحصول على التاريخ الحالي

  int age = today.year - birthDate.year;
  if (today.month < birthDate.month ||
      (today.month == birthDate.month && today.day < birthDate.day)) {
    age--;
  }

  return age;
}
void _showEditDialog(BuildContext context, SonModel child, String familyId) {
  TextEditingController nameController = TextEditingController(text: child.sonName);
  TextEditingController idController = TextEditingController(text: child.sonNationalId);
  TextEditingController birthDateController = TextEditingController(text: child.sonDateOfBirthDay);
  TextEditingController relationController = TextEditingController(text: child.relationShip);
  TextEditingController healthController = TextEditingController(text: child.sonHealthyStatus);
  TextEditingController educationController = TextEditingController(text: child.educationalLevel);
  TextEditingController typeController = TextEditingController(text: child.sonType);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("${child.sonName}"),
        content: SingleChildScrollView(
          child: Column(

            children: [
              TextField(controller: nameController, decoration: InputDecoration(labelText: AppLocale.the_full_name.getString(context))),
              const SizedBox(height: 5,),
              TextField(controller: idController, decoration: InputDecoration(labelText:AppLocale.ID.getString(context))),
              const SizedBox(height: 5,),
              TextField(controller: birthDateController, decoration: InputDecoration(labelText: AppLocale.dateOfBirth.getString(context))),
              const SizedBox(height: 5,),
              TextField(controller: relationController, decoration: InputDecoration(labelText: AppLocale.relationShip.getString(context))),
              const SizedBox(height: 5,),
              TextField(controller: healthController, decoration: InputDecoration(labelText: AppLocale.healthStatus.getString(context))),
              const SizedBox(height: 5,),
              TextField(controller: educationController, decoration: InputDecoration(labelText: AppLocale.educationalLevel.getString(context))),
              const SizedBox(height: 5,),
              TextField(controller: typeController, decoration: InputDecoration(labelText: AppLocale.personType.getString(context))),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:  Text(AppLocale.cansel.getString(context)),
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection("families")
                  .doc(familyId)
                  .collection("children")
                  .doc(child.sonNationalId)
                  .update({
                "sonName": nameController.text,
                "sonNationalId": idController.text,
                "sonDateOfBirthDay": birthDateController.text,
                "relationShip": relationController.text,
                "sonHealthyStatus": healthController.text,
                "educationalLevel": educationController.text,
                "sonType": typeController.text,
              });

              Navigator.pop(context);
            },
            child:  Text(AppLocale.update_family.getString(context)),
          ),
        ],
      );
    },
  );
}
void _deleteChild(String familyId, String childId) async {
  await FirebaseFirestore.instance
      .collection("families")
      .doc(familyId)
      .collection("children")
      .doc(childId)
      .delete();
}
