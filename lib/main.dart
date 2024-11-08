import 'package:flutter/material.dart';
import 'views/login.dart';
import 'views/register.dart';
import 'views/home.dart';
import 'views/patient_list.dart';  // Import các màn hình khác
import 'views/doctor_list.dart';
import 'views/nurse_list.dart';
import 'views/medical_record_list.dart';
import 'views/medicine_list.dart';
import 'views/leave_list.dart';
import 'views/account_management.dart';
import 'screen/adddoctor.dart';
import 'screen/add_patient.dart';
import 'screen/addnurse.dart';
import 'screen/add_medicalrecord.dart';
import 'screen/add_medicine.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/patient_list': (context) => const PatientListScreen(), 
        '/doctor_list': (context) => const DoctorListScreen(),
        '/nurse_list': (context) => const NurseListScreen(),
        '/medical_record_list': (context) => const MedicalRecordListScreen(),
        '/medicine_list': (context) => const MedicineListScreen(),
        '/leave_list': (context) => const LeaveListScreen(),
        '/account_management': (context) => const AccountManagementScreen(),
        '/adddoctor': (context) => const AddDoctorScreen(),
        '/add_patient': (context) => const AddPatientScreen(),
        '/addnurse': (context) => const AddNurseScreen(),
        '/add_medicalrecord': (context) => const AddMedicalRecordScreen(),
        '/add_medicine': (context) => const AddMedicineScreen(),
        
        
      },
    );
  }
}
