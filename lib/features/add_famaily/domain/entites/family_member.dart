class FamilyMember {
  final String fullName;
  final String nationalId;
  final String phoneNumber;
  final String address;
  final String assistance;
  final String pension;
  final String diocese;
  final String fatherBishop;
  final String church;
  final String area;
  final String assistanceAmount;
  final String dataForWidowsAndOrphans;
  final String theDeceased;
  final String itWorks;
  final String valueOfPension;
  final String sourcesOfIncome;
  final String propertyOrLeases;
  ///-------------new----------------
  final String fatherReport ;
  final String fatherName ;
  final String fatherPhone;
  final String serverName ;
  final String serverPhone ;
  final String dateOfSearch ;
  final String writtenBy ;
  final int numberOfSons ;

  const FamilyMember({
    required this.fullName,
    required this.nationalId,
    required this.phoneNumber,
    required this.address,
    required this.assistance,
    required this.pension,
    required this.diocese,
    required this.fatherBishop,
    required this.church,
    required this.area,
    required this.assistanceAmount,
    required this.dataForWidowsAndOrphans,
    required this.theDeceased,
    required this.itWorks,
    required this.valueOfPension,
    required this.sourcesOfIncome,
    required this.propertyOrLeases,
    required this.dateOfSearch,
    required this.fatherName ,
    required this.fatherPhone,
    required this.fatherReport,
    required this.serverName ,
    required this.serverPhone ,
    required this.writtenBy ,
    required this.numberOfSons,
  });
}
