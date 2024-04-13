import 'package:flutter/material.dart';
import 'package:internship_fair/constants/constants.dart';
import 'package:internship_fair/controller/get_job.dart';
import 'package:internship_fair/model/get_job_model.dart' as data;
import 'package:internship_fair/view/profile.dart';
import 'package:internship_fair/view/filter_page.dart';
import 'widgets/job_card.dart';

class JobProfile extends StatefulWidget {
  
  const JobProfile({super.key});

  @override
  State<JobProfile> createState() => _JobProfileState();
}

class _JobProfileState extends State<JobProfile> {
  List<data.Data> _getJob = [];
  int lowVal = 0;
  int highVal = 50000;
  bool isOnline = false;
  bool isOffline = false;
  String mode = "";
  bool isChanged = false;

  getJob(int low, int high, String mode) async {
    _getJob = await GetJobApi().getJobData(low, high, mode);
  }

  void callback(int low, int high, bool online, bool offline, String mode,
      bool isChanged) {
    setState(() {
      lowVal = low;
      highVal = high;
      isOnline = online;
      isOffline = offline;
      this.mode = mode;
      this.isChanged = isChanged;
      if (isChanged) {
        getJob(lowVal, highVal, mode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double sizefont = size.width * 0.04;

    return Scaffold(
        appBar: AppBar(foregroundColor: Colors.white,shadowColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Filter(
                      callback: callback,
                      low: lowVal,
                      high: highVal,
                      online: isOnline,
                      offline: isOffline,
                      mode: mode,
                      isChanged: isChanged,
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(size.width * 0.05),
                        topRight: Radius.circular(size.width * 0.05)),
                  ),
                );
              },
              icon: const Icon(Icons.filter_alt_sharp, color: Color(0xFF009688))),
          elevation: 0,
          title: const Text(
            'All Opportunities',
            style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          toolbarHeight: 50,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Profile();
                }));
              },
              icon: Icon(
                Icons.person_outlined,
                color: blackTeal,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Center(
                child: FutureBuilder(
                    future: getJob(lowVal, highVal, mode),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: textgreen,
                          ),
                        );
                      } else {
                        return _getJob.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: _getJob.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  if (_getJob[index].requirement == null) {
                                    _getJob[index].requirement = [
                                      "No specific requirements"
                                    ];
                                  }
                                  return JobCard(
                                    companyName: _getJob[index].company,
                                    duration: _getJob[index].duration,
                                    stipend: _getJob[index].stipend.toString(),
                                    location: _getJob[index].location,
                                    position: _getJob[index].role,
                                    mode: _getJob[index].mode,
                                    logo: _getJob[index].logo,
                                    requirements: _getJob[index].requirement,
                                    about: _getJob[index].about,
                                    skills: _getJob[index].description,
                                    jobid: _getJob[index].id,
                                    v: _getJob[index].v,
                                    deadline: _getJob[index].deadline,
                                  );
                                },
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.3,
                                  ),
                                  Text(
                                    "No Internships currently :(",
                                    style: TextStyle(
                                      color: blackColor,
                                      fontFamily: "poppins",
                                      fontSize: sizefont * 1.2,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Stay tuned!",
                                    style: TextStyle(
                                      color: blackColor,
                                      fontFamily: "poppins",
                                      fontSize: sizefont * 1,
                                    ),
                                  ),
                                ],
                              );
                      }
                    })),
              )
            ],
          ),
        ));
  }
}
