// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loginform/Models/employee.dart';
import 'package:loginform/Models/jobs.dart';
import 'package:loginform/RemoteService.dart';
import 'package:loginform/welcome.dart';

class jobs extends StatefulWidget {
  employee emp;
  List<EmpJobs>? empjobs;
  jobs(this.emp, this.empjobs) {
    emp = emp;
    empjobs = empjobs;
  }

  @override
  State<jobs> createState() => _jobsState(emp, empjobs);
}

class _jobsState extends State<jobs> {
  late employee emp;
  late List<EmpJobs>? empjobs;
  _jobsState(employee emp, List<EmpJobs>? empjobs) {
    this.emp = emp;
    this.empjobs = empjobs;
  }
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> _trySubmit(
      String jobLatitude, String jobLongitude, String radius) async {
    var position = await _getGeoLocationPosition();
    var response = remoteService.checkIn(jobLatitude, jobLongitude,
        position.latitude.toString(), position.longitude.toString(), radius);
  }

  Widget _buildPopupDialog(BuildContext context, EmpJobs job) {
    return new AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleChildScrollView(
              child: Column(children: [
            Text("Address: " +
                job.newJobLocation.newAddress +
                "\nCity: " +
                job.newJobLocation.newCity +
                "\nRadius: " +
                job.newJobLocation.newRadius +
                "\nStatus: " +
                job.newJobLocation.statuscode.toString()),
            SizedBox(
              height: 12,
            ),
            Center(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: SizedBox(
                      height: 12,
                    )),
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () async => _trySubmit(
                      job.newJobLocation.newLatitude,
                      job.newJobLocation.newLongitude,
                      job.newJobLocation.newRadius),
                  child: Text('CheckIn', style: TextStyle(color: Colors.white)),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: SizedBox(
                      height: 12,
                    )),
              ],
            ))
          ])),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Jobs',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                // <-- SEE HERE
                decoration: BoxDecoration(color: Colors.blue),
                accountName: Text(
                  "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  emp.email,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                currentAccountPicture: Icon(
                  Icons.person,
                  size: 70,
                  color: Colors.white,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                ),
                title: const Text('SignOut'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Welcome()));
                },
              ),
              AboutListTile(
                // <-- SEE HERE
                icon: Icon(
                  Icons.info,
                ),
                child: Text('About app'),
                applicationIcon: Icon(
                  Icons.local_play,
                ),
                applicationName: 'WorkerApp',
                applicationVersion: '1.0.25',
                applicationLegalese: '© 2022 Impulztech',
                aboutBoxChildren: [
                  ///Content goes here...
                ],
              ),
            ],
          ),
        ),
        body: ListView.builder(
          itemCount: empjobs!.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListTile(
                  leading: Icon(
                    Icons.task,
                    color: Colors.blue,
                  ),
                  title: Text(empjobs![index].newJobLocation.newLocationname),
                  trailing: MaterialButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context, empjobs![index]),
                      );
                    },
                    child: Icon(Icons.arrow_drop_down_circle_rounded),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
