import 'package:coins/src/database/db_config.dart';
import 'package:coins/src/database/profile_db_model.dart';
import 'package:coins/src/utils/app_config.dart';
import 'package:flutter/material.dart';

class ProfileModalSheet extends StatefulWidget {
  ProfileModel profileModel;
  int profileFieldType;
  String type;
  final ValueChanged<bool> onConfirmChanged;
  ProfileModalSheet(this.profileModel, this.profileFieldType, this.type, {Key? key, required this.onConfirmChanged}) : super(key: key);

  @override
  _ProfileModalSheetState createState() => _ProfileModalSheetState();
}

class _ProfileModalSheetState extends State<ProfileModalSheet> {
  final profileController = TextEditingController();
  final _formNameKey = GlobalKey<FormState>();
  String modelTitle = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    switch(widget.profileFieldType) {
      case ProfileFieldType.NAME:
        profileController.text = widget.profileModel.name;
        setState(() {
          modelTitle = (widget.profileModel.name == "") ? "Add Name" : "Edit Name";
        });
        break;
      case ProfileFieldType.EMAILID:
        profileController.text = widget.profileModel.emailId;
        setState(() {
          modelTitle = (widget.profileModel.emailId == "") ? "Add EmailId" : "Edit Email";
        });
        break;
      case ProfileFieldType.ADDRESS:
        profileController.text = widget.profileModel.address;
        setState(() {
          modelTitle = (widget.profileModel.address == "") ? "Add Address" : "Edit Address";
        });
        break;
      default:
        break;
    }
  }

  validate(){
    if(_formNameKey.currentState!.validate()){
      try{
        DatabaseHelper databaseHelper = DatabaseHelper();
        switch(widget.profileFieldType) {
          case ProfileFieldType.NAME:
            widget.profileModel.name = profileController.text;
            break;
          case ProfileFieldType.EMAILID:
            widget.profileModel.emailId = profileController.text;
            break;
          case ProfileFieldType.ADDRESS:
            widget.profileModel.address = profileController.text;
            break;
          default:
            break;
        }
        if(widget.type == "NEW") {
          databaseHelper.insert(widget.profileModel);
        } else {
          databaseHelper.update(widget.profileModel);
        }
        widget.onConfirmChanged(true);
        Navigator.pop(context);
      }
      catch(error){
        widget.onConfirmChanged(false);
        Navigator.pop(context);
      }
    }
  }

  renderFormField(){
    switch(widget.profileFieldType){
      case ProfileFieldType.NAME:
        return TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Please Enter Name";
            }
            return null;
          },
          controller: profileController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            labelText: "Name",
          ),
        );
        break;

        case ProfileFieldType.EMAILID:
          return TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Please Enter Email Address";
            }
            else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value))
            {
              return "Please Enter Valid Email";
            }
            return null;
          },
          controller: profileController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: "Email address",
          ),
        );
        break;

        case ProfileFieldType.ADDRESS:
          return TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Please Enter Address";
            }
            return null;
          },
          controller: profileController,
          keyboardType: TextInputType.multiline,
          minLines: 2,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: "Address",
          ),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Wrap(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        widget.onConfirmChanged(true);
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close, size: 25, color: Colors.white,)
                    ),

                    const SizedBox(width: 60),
                    Text(modelTitle),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Form(
                          key: _formNameKey,
                          child: renderFormField(),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            validate();
                          },
                          child: const Text("Save", style: TextStyle(color: Colors.black, fontSize: 20),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
