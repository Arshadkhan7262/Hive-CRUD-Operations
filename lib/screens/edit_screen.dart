import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_db/Models/DataModel.dart';

class EditScreen extends StatefulWidget {
  var name,father_name,university,degree;
  int? age;
  double? cgpa;


  EditScreen({required this.name, required this.father_name, required this.university, required this.degree,
    required this.age, required this.cgpa});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController nameController=TextEditingController();
  TextEditingController fatherController=TextEditingController();
  TextEditingController ageController=TextEditingController();
  TextEditingController univeristyController=TextEditingController();
  TextEditingController degreeController=TextEditingController();
  TextEditingController cgpaController=TextEditingController();
  void updateData(String name,String father_name,int age,String university,String degree,double cgpa)async{
    var box=await Hive.openBox('student_info');
    nameController.text=name;
    fatherController.text=father_name;
    ageController.text=age.toString();
    univeristyController.text=university;
    degreeController.text=degree;
    cgpaController.text=cgpa.toString();
    var data=box.values.toList().whereType<DataModel>().toList();
    int index=data.indexWhere((element) => element.name==widget.name);
    data[index].name=name;
    data[index].father_name=father_name;
    data[index].age=age as int?;
    data[index].university=university;
    data[index].degree=degree;
    data[index].cgpa=cgpa as double?;
    await box.putAt(index, data[index]).then((value) {
      Fluttertoast.showToast(msg: 'Data Added Successfullly',
      backgroundColor: Colors.green,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT);

    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString(),
          backgroundColor: Colors.red,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);

    });
  }

  @override
  void initState() {
    nameController=TextEditingController(text: widget.name);
    fatherController=TextEditingController(text: widget.father_name);
    ageController=TextEditingController(text: widget.age.toString());
    univeristyController=TextEditingController(text: widget.university);
    degreeController=TextEditingController(text: widget.degree) ;
    cgpaController=TextEditingController(text: widget.cgpa.toString()) ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Update Data'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
            Container(
                width: MediaQuery.of(context).size.width * 1,
                margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                child: Center(
                    child: TextField(
                      controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      hintText: 'Enter Name',
                      label: Text('Name'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      floatingLabelBehavior: FloatingLabelBehavior.always),
                ))),
            Container(
                width: MediaQuery.of(context).size.width * 1,
                margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                child: Center(
                    child: TextField(
                      controller: fatherController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          hintText: 'Enter Father Name',
                          label: Text('Father Name'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          floatingLabelBehavior: FloatingLabelBehavior.always),
                    ))),
            Container(
                width: MediaQuery.of(context).size.width * 1,
                margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                child: Center(
                    child: TextField(
                      controller: ageController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          hintText: 'Enter Age',
                          label: Text('Age'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          floatingLabelBehavior: FloatingLabelBehavior.always),
                    ))),
            Container(
                width: MediaQuery.of(context).size.width * 1,
                margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                child: Center(
                    child: TextField(
                      controller: univeristyController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          hintText: 'Enter University',
                          label: Text('University'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          floatingLabelBehavior: FloatingLabelBehavior.always),
                    ))),
            Container(
                width: MediaQuery.of(context).size.width * 1,
                margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                child: Center(
                    child: TextField(
                      controller: degreeController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          hintText: 'Enter Degree',
                          label: Text('Degree'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          floatingLabelBehavior: FloatingLabelBehavior.always),
                    ))),
            Container(
                width: MediaQuery.of(context).size.width * 1,
                margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                child: Center(
                    child: TextField(
                      controller: cgpaController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          hintText: 'Enter CGPA',
                          label: Text('CGPA'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          floatingLabelBehavior: FloatingLabelBehavior.always),
                    ))),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: (){
                int age=int.parse(ageController.text.toString());
                double cgpa=double.parse(cgpaController.text.toString());
                updateData(nameController.text, fatherController.text, int.parse(ageController.text), univeristyController.text, degreeController.text, double.parse(cgpaController.text));
                }, child: Text('Update Data',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,fontStyle: FontStyle.italic),)),
          ],
        ),
      ),
    );
  }
}
