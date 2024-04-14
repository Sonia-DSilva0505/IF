import 'package:flutter/material.dart';
import '../jobdesc.dart';

class AppliedJobCard extends StatelessWidget {
  final String? companyName;
  final String? duration;
  final String? stipend;
  final String? location;
  final String? position;
  final String? mode;
  final String? logo;
  final List<String>? requirements;
  final String? skills;
  final String? about;
  final String? jobid;
  
  final String? link;
  final int? v;
  final String? deadline;

  const AppliedJobCard(
      {super.key,
      required this.companyName,
      required this.duration,
      required this.stipend,
      required this.location,
      required this.position,
      required this.mode,
      required this.deadline,
      required this.about,
      required this.requirements,
      
      required this.link,
      required this.skills,
      required this.jobid,
      this.logo,
      this.v});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double sizefont = size.width * 0.04;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizefont * 0.5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => JobDesc(
                        companyName: companyName ?? "",
                        duration: duration ?? "",
                        jobid: jobid ?? "",
                        jobPosition: position ?? "",
                        minStipend: stipend ?? "",
                        workfromHome: mode ?? "",
                        about: about ?? "",
                        skills: skills,
                        requirements: requirements ?? [],
                        logo: logo!,
                        location: location ?? "",
                        deadline: deadline ?? "",
                        v: v ?? 0,
                        link: link,
                        applied: true,
                      )));
        },
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: DecoratedBox(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 0.1,
                ),
                borderRadius: BorderRadius.circular(3),
                color: Colors.white),
            child: ListTile(
              leading: SizedBox(
                width: 0.15 * size.width,
                height: 0.15 * size.width,
                child: Image.network(
                  logo ?? "",
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.error_outline, color: Colors.red),
                    );
                  },
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Wrap(
                  children: [
                    Text(
                      position ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Text(
                        companyName ?? "",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
