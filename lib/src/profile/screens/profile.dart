import 'package:coins/src/profile/widgets/profile_modalsheet.dart';
import 'package:flutter/material.dart';
import 'package:coins/src/database/db_config.dart';
import 'package:coins/src/database/profile_db_model.dart';
import 'package:coins/src/utils/app_config.dart';
import 'package:coins/src/widgets/bottomnavigation.dart';

class Profile extends StatefulWidget {
  static const routeName = '/profile';
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<ProfileModel>? _profileData = null;
  ProfileModel profileData = ProfileModel("", "", "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(_profileData == null){
      _profileData = [];
      getUpdateProfileData();
    }
  }

  getUpdateProfileData() async{
    _profileData = await databaseHelper.getModelFromProfileData();

    if(_profileData!.isNotEmpty){
      profileData = _profileData![0];
    }
    else{
      profileData = ProfileModel("","","");
    }

    setState(() {
      _profileData = _profileData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset : false,
      body: Container(
        margin: const EdgeInsets.all(10.0),
        height: 440,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Name"),
                        TextButton(
                          onPressed: (){
                            showModalBottomSheet<dynamic>(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return ProfileModalSheet(
                                    profileData,
                                    ProfileFieldType.NAME,
                                    (_profileData!.isNotEmpty) ? "EDIT": "NEW",
                                    onConfirmChanged: (result) async {
                                      if(result){
                                        getUpdateProfileData();
                                      }
                                    },
                                  );
                                }
                            );
                          },
                          child: (profileData.name == "") ? const Text("Add") : const Text("Edit"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    (_profileData!.isNotEmpty) ?  Text(_profileData![0].name, style: Theme.of(context).textTheme.caption) : const Text(""),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Email Id"),
                        TextButton(
                            onPressed: (){
                              showModalBottomSheet<dynamic>(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return ProfileModalSheet(
                                      profileData,
                                      ProfileFieldType.EMAILID,
                                      (_profileData!.isNotEmpty) ? "EDIT": "NEW",
                                      onConfirmChanged: (result) async {
                                        if(result){
                                          getUpdateProfileData();
                                        }
                                      },
                                    );
                                  }
                              );
                            },
                          child: (profileData.emailId == "") ? const Text("Add") : const Text("Edit"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    (_profileData!.isNotEmpty) ?  Text(_profileData![0].emailId, style: Theme.of(context).textTheme.caption) : const Text(""),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Address"),
                        TextButton(
                            onPressed: (){
                              showModalBottomSheet<dynamic>(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return ProfileModalSheet(
                                      profileData,
                                      ProfileFieldType.ADDRESS,
                                      (_profileData!.isNotEmpty) ? "EDIT": "NEW",
                                      onConfirmChanged: (result) async {
                                        if(result){
                                          getUpdateProfileData();
                                        }
                                      },
                                    );
                                  }
                              );
                            },
                            child: (profileData.address == "") ? const Text("Add") : const Text("Edit"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    (_profileData!.isNotEmpty) ?  Text(_profileData![0].address, style: Theme.of(context).textTheme.caption) : const Text(""),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(Tabs.PROFILE),
    );
  }
}
