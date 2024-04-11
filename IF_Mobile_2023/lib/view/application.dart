import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internship_fair/constants/constants.dart';
import 'package:internship_fair/controller/applied_job.dart';
import 'package:internship_fair/model/get_job_model.dart' as data;
import 'widgets/applied_job_card.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _MyCartState();
}

class Product {
  String name;
  String role;
  String image;

  Product({required this.name, required this.role, required this.image});
}

class _MyCartState extends State<Application> {
  List<data.Data> _getAppliedJobs = [];
  int? count;

  getJob() async {
    String userid = GetStorage().read("id");
    _getAppliedJobs = await AppliedJobApi().getAppliedJobs(userid) ?? [];
    count = _getAppliedJobs.length;
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
          "Applications",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: sizefont,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          textAlign: TextAlign.start,
        ),
      ),
      body: FutureBuilder(
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
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No applications yet :(",
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
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: count,
                          itemBuilder: (BuildContext context, int index) {
                            if (_getAppliedJobs[index].requirement == null) {
                              _getAppliedJobs[index].requirement = [
                                "No specific requirements"
                              ];
                            }
                            return AppliedJobCard(
                              companyName: _getAppliedJobs[index].company,
                              duration: _getAppliedJobs[index].duration,
                              stipend:
                                  _getAppliedJobs[index].stipend.toString(),
                              location: _getAppliedJobs[index].location,
                              position: _getAppliedJobs[index].role,
                              mode: _getAppliedJobs[index].mode,
                              logo: _getAppliedJobs[index].logo,
                              requirements: _getAppliedJobs[index].requirement,
                              about: _getAppliedJobs[index].about,
                              skills: _getAppliedJobs[index].description,
                              jobid: _getAppliedJobs[index].id,
                              v: _getAppliedJobs[index].v,
                              deadline: _getAppliedJobs[index].deadline,
                            );
                          },
                        ),
                      ),
                    ],
                  );
          }
        }),
      ),
    );
  }
}
