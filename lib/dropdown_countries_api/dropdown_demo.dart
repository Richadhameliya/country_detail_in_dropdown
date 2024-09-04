import 'package:flutter/material.dart';

import 'dropdown_api.dart';
import 'dropdown_model.dart';

class DropDownDemo extends StatefulWidget {
  const DropDownDemo({Key? key}) : super(key: key);

  @override
  _DropDownDemoState createState() => _DropDownDemoState();
}

class _DropDownDemoState extends State<DropDownDemo> {
  List<String> countries = [];
  List<String> departments = [];
  List<String> provinces = [];
  List<String> districts = [];

  String? selectedCountry;
  String? selectedDepartment;
  String? selectedProvince;
  String? selectedDistrict;

  int? selectedCountryId;
  int? selectedDepartmentId;
  int? selectedProvinceId;
  int? selectedDistrictId;

  Map<String, Datum> dataMap = {};

  @override
  void initState() {
    super.initState();
    fetchCountryData();
  }

  Future<void> fetchCountryData() async {
    try {
      final countryApi = await ProductApi.fetchCountryData();
      setState(() {
        countries = countryApi.data.map((datum) => datum.name).toList();
        dataMap = {for (var datum in countryApi.data) datum.name: datum};
      });
    } catch (e) {
      print('Error fetching country data: $e');
    }
  }

  void updateDepartments(String? country) {
    if (country != null) {
      setState(() {
        selectedCountry = country;
        final selectedCountryData = dataMap[country];
        departments = selectedCountryData?.departments
                .map((dept) => dept.name)
                .toList() ??
            [];
        selectedCountryId = selectedCountryData?.id;
        if (departments.contains(selectedDepartment)) {
          selectedDepartment = selectedDepartment;
        } else {
          selectedDepartment = null;
          selectedDepartmentId = null;
        }
        provinces = [];
        districts = [];
      });
    }
  }

  void updateProvinces(String? department) {
    if (selectedCountry != null && department != null) {
      final departmentData = dataMap[selectedCountry]?.departments.firstWhere(
            (dept) => dept.name == department,
            orElse: () => Departmentt(
              id: 0,
              countryId: 0,
              name: '',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              provinces: [],
            ),
          );
      setState(() {
        selectedDepartment = department;
        provinces =
            departmentData?.provinces.map((prov) => prov.name).toList() ?? [];
        selectedDepartmentId = departmentData?.countryId;
        if (provinces.contains(selectedProvince)) {
          selectedProvince = selectedProvince;
        } else {
          selectedProvince = null;
          selectedProvinceId = null;
        }
        districts = [];
      });
    }
  }

  void updateDistricts(String? province) {
    if (selectedCountry != null &&
        selectedDepartment != null &&
        province != null) {
      final departmentData = dataMap[selectedCountry]?.departments.firstWhere(
            (dept) => dept.name == selectedDepartment,
            orElse: () => Departmentt(
              id: 0,
              countryId: 0,
              name: '',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              provinces: [],
            ),
          );
      final provinceData = departmentData?.provinces.firstWhere(
        (prov) => prov.name == province,
        orElse: () => Province(
          id: 0,
          departmentId: 0,
          name: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          districts: [],
        ),
      );
      setState(() {
        selectedProvince = province;
        districts =
            provinceData?.districts.map((dist) => dist.name).toList() ?? [];
        selectedProvinceId = provinceData?.departmentId;
        if (districts.contains(selectedDistrict)) {
          selectedDistrict = selectedDistrict;
        } else {
          selectedDistrict = null;
          selectedDistrictId = null;
        }
      });
    }
  }

  void Submit() {
    print('Selected Country ID: $selectedCountryId');
    print('Selected Department ID: $selectedDepartmentId');
    print('Selected Province ID: $selectedProvinceId');
    print('Selected District ID: $selectedDistrictId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Location")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              isExpanded: true,
              hint: Text("Select Country"),
              value: selectedCountry,
              items: countries.map((country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
              onChanged: updateDepartments,
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              isExpanded: true,
              hint: Text("Select Department"),
              value: selectedDepartment,
              items: departments.map((department) {
                return DropdownMenuItem<String>(
                  value: department,
                  child: Text(department),
                );
              }).toList(),
              onChanged: updateProvinces,
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              isExpanded: true,
              hint: Text("Select Province"),
              value: selectedProvince,
              items: provinces.map((province) {
                return DropdownMenuItem<String>(
                  value: province,
                  child: Text(province),
                );
              }).toList(),
              onChanged: updateDistricts,
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              isExpanded: true,
              hint: Text("Select District"),
              value: selectedDistrict,
              items: districts.map((district) {
                return DropdownMenuItem<String>(
                  value: district,
                  child: Text(district),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDistrict = value;
                  // Find and set selectedDistrictId
                  selectedDistrictId = dataMap[selectedCountry]
                      ?.departments
                      .firstWhere((dept) => dept.name == selectedDepartment)
                      .provinces
                      .firstWhere((prov) => prov.name == selectedProvince)
                      .districts
                      .firstWhere((dist) => dist.name == value)
                      .provinceId;
                });
              },
            ),
            SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                onPressed: Submit,
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
