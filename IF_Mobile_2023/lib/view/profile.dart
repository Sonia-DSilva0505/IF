// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internship_fair/constants/constants.dart';
import 'package:internship_fair/controller/applied_job.dart';
import 'package:internship_fair/controller/auth.dart';
import 'package:internship_fair/model/get_job_model.dart' as data;
import 'package:motion_toast/motion_toast.dart';
import 'login.dart';
import 'widgets/applied_job_card.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class Product {
  String name;
  String role;
  String image;

  Product({required this.name, required this.role, required this.image});
}

class _ProfileState extends State<Profile> {
  List<data.Data> _getAppliedJobs = [];
  int? count;

  getJob() async {
    String userid = GetStorage().read("id");
    _getAppliedJobs = await AppliedJobApi().getAppliedJobs(userid) ?? [];
    count = _getAppliedJobs.length;
  }

  AuthController authController = AuthController();
  String resume = "";
  PlatformFile? pickedfile;
  File? pdf;
  String? fileName;

  Future selectPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );
      if (result != null) {
        pickedfile = result.files.first;
        resume = result.files.first.path!;
        File selectedFile = File(result.files.single.path!);

        setState(() {
          pdf = File(result.files.single.path!);
          var lastSeperator =
              selectedFile.path.lastIndexOf(Platform.pathSeparator);
          fileName = selectedFile.path.substring(lastSeperator + 1);
        });
        if (pdf == null) {
          MotionToast.error(
              toastDuration: const Duration(milliseconds: 2000),
              height: 65,
              borderRadius: 10,
              width: 400,
              padding: EdgeInsets.zero,
              title: Text(
                "Error",
                style: TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              description: Text(
                "Upload your resume",
                style: TextStyle(
                  color: whiteColor,
                ),
              )).show(context);
        } else {
          updateResume(pdf!, context);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void updateResume(File pdf, BuildContext context) async {
    String status = '';

    String userid = GetStorage().read("id");
    status = await authController.updateResume(userid, pdf);

    if (status == "Success") {
      MotionToast.success(
        toastDuration: const Duration(milliseconds: 2000),
        height: 65,
        borderRadius: 10,
        padding: EdgeInsets.zero,
        width: 400,
        title: Text(
          "Resume Updated",
          style: TextStyle(
              color: whiteColor, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        description: const Text(
          "File uploaded successfully",
          style: TextStyle(
            color: Colors.white,
            fontSize: 11,
          ),
        ),
      ).show(context);
    } else {
      MotionToast.error(
              toastDuration: const Duration(milliseconds: 2000),
              height: 65,
              borderRadius: 10,
              width: 400,
              padding: EdgeInsets.zero,
              title: Text(
                "Error",
                style: TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              description: Text(status))
          .show(context);
    }
  }

  @override
  void initState() {
    super.initState();
    getJob();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double sizefont = size.width * 0.06;
    String? name = GetStorage().read("name");
    String? sap = GetStorage().read("sapid");
    String? email = GetStorage().read("email");
    String? contact = GetStorage().read("contact");
    String? dept = GetStorage().read("department");
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "My Profile",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: sizefont,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          textAlign: TextAlign.start,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all( 15.0),
                child: SizedBox(
                  width: size.width*0.9,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all( 15.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name ?? "",
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: textgreen,
                                fontWeight: FontWeight.w700,
                                fontSize: 28),
                          ),
                          Text(
                            email ?? "",
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: textgreen,
                                fontSize: 16),
                          ),
                          Text(
                            sap ?? "",
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: textgreen,
                                fontSize: 16),
                          ),
                          Text(
                            contact ?? "",
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: textgreen,
                                fontSize: 16),
                          ),
                          Text(
                            dept ?? "",
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: textgreen,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: fileName == null
                    ? SizedBox(
                      width: size.width * 0.9,
                      child: Material(
                        borderRadius: BorderRadius.circular(5),
                        color: whiteColor,
                        child: MaterialButton(
                          onPressed: () {
                            selectPDF();
                          },
                          child: Text.rich(
                            TextSpan(
                              children: [
                                WidgetSpan(
                                    child: Icon(
                                  Icons.file_upload_outlined,
                                  color: textgreen,
                                  size: sizefont * 0.9,
                                )),
                                WidgetSpan(
                                    child: SizedBox(
                                  width: size.width * 0.01,
                                )),
                                TextSpan(
                                  text: "Update Resume",
                                  style: TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 16,
                                      color:textgreen),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    : Text(
                        fileName ?? "",
                        style: TextStyle(
                          color: blackTeal,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              FutureBuilder(
                future: getJob(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: blackTeal,
                      ),
                    );
                  } else {
                    return count == 0
                        ? Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "No Applications yet :(",
                                    style: TextStyle(
                                      color: blackColor,
                                      fontFamily: "poppins",
                                      fontSize: sizefont * 0.8,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Apply to internships",
                                    style: TextStyle(
                                      color: blackColor,
                                      fontFamily: "poppins",
                                      fontSize: sizefont * 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Text(
                                  "My Applications",
                                  style: TextStyle(
                                      fontFamily: 'poppins',
                                      color: blackColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: count,
                                itemBuilder: (BuildContext context, int index) {
                                  if (_getAppliedJobs[index].requirement ==
                                      null) {
                                    _getAppliedJobs[index].requirement = [
                                      "No specific requirements"
                                    ];
                                  }
                                  return AppliedJobCard(
                                    companyName: _getAppliedJobs[index].company,
                                    duration: _getAppliedJobs[index].duration,
                                    stipend: _getAppliedJobs[index]
                                        .stipend
                                        .toString(),
                                    location: _getAppliedJobs[index].location,
                                    position: _getAppliedJobs[index].role,
                                    mode: _getAppliedJobs[index].mode,
                                    logo: _getAppliedJobs[index].logo,
                                    requirements:
                                        _getAppliedJobs[index].requirement,
                                    about: _getAppliedJobs[index].about,
                                    skills: _getAppliedJobs[index].description,
                                    jobid: _getAppliedJobs[index].id,
                                    v: _getAppliedJobs[index].v,
                                    deadline: _getAppliedJobs[index].deadline,
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                            ],
                          );
                  }
                }),
              ),
                                            Center(
                                child: Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(5),
                                    color: blackTeal,
                                    child: Container(
                                      height: sizefont * 2.5,
                                      padding: EdgeInsets.symmetric(
                                          vertical: sizefont * 0.5),
                                      child: MaterialButton(
                                          onPressed: () {
                                            GetStorage().erase();
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginScreen()));
                                          },
                                          child: SizedBox(
                                            width: size.width * 0.8,
                                            child: Text(
                                              "Logout",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontSize: sizefont,
                                                  color: whiteColor),
                                            ),
                                          )),
                                    )),
                              )
            ],
          ),
        ),
      ),
    );
  }
}
