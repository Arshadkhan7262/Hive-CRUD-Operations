import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_db/Models/DataModel.dart';
import 'package:hive_db/screens/fetch_screeen.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController=TextEditingController();
  TextEditingController fatherController=TextEditingController();
  TextEditingController ageController=TextEditingController();
  TextEditingController universityController=TextEditingController();
  TextEditingController degreeController=TextEditingController();
  TextEditingController cgpaController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Hive Database'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
                Container(
                  width: MediaQuery.of(context).size.width*1,
                    margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                    child: Center(child: Text('Hive Database',textAlign:TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,fontStyle: FontStyle.italic),))),
              Container(
                  width: MediaQuery.of(context).size.width*1,
                  margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                  child: Center(child: TextField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(hintText: 'Enter Name',label: Text('Name'),border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),floatingLabelBehavior: FloatingLabelBehavior.always),))),
              Container(
                  width: MediaQuery.of(context).size.width*1,
                  margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                  child: Center(child: TextField(
                    controller: fatherController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(hintText: 'Enter Father  Name',label: Text('Father Name'),border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),floatingLabelBehavior: FloatingLabelBehavior.always),))),
              Container(
                  width: MediaQuery.of(context).size.width*1,
                  margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                  child: Center(child: TextField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'Enter Age',label: Text('Age'),border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),floatingLabelBehavior: FloatingLabelBehavior.always),))),
              Container(
                  width: MediaQuery.of(context).size.width*1,
                  margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                  child: Center(child: TextField(
                    controller: universityController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(hintText: 'Enter University',label: Text('University'),border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),floatingLabelBehavior: FloatingLabelBehavior.always),))),
              Container(
                  width: MediaQuery.of(context).size.width*1,
                  margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
        
                  child: Center(child: TextField(
                    controller: degreeController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(hintText: 'Enter Degree',label: Text('Degree'),border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),floatingLabelBehavior: FloatingLabelBehavior.always),))),
              Container(
                  width: MediaQuery.of(context).size.width*1,
                  margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
        
                  child: Center(child: TextField(
                    controller: cgpaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'Enter CGPA',label: Text('CGPA'),border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),floatingLabelBehavior: FloatingLabelBehavior.always),))),

              Container(
                width: MediaQuery.of(context).size.width*0.4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    onPressed: (){
                    int age=int.parse(ageController.text.toString());
                    double cgpa=double.parse(cgpaController.text.toString());
                    final DataValue=DataModel(name: nameController.text.toString(), father_name: fatherController.text.toString(), age: age, university: universityController.text.toString(), degree: degreeController.text.toString(), cgpa: cgpa);
                    Hive.box('student_info').add(DataValue).then((value){
                      Fluttertoast.showToast(msg: 'Data Added Successfully',
                      backgroundColor: Colors.green,
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_SHORT);

                    }).onError((error, stackTrace) {
                      Fluttertoast.showToast(msg: error.toString(),
                          backgroundColor: Colors.red,
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_SHORT);

                    });
                    DataValue.save();
                    print(DataValue.name);
                    print(DataValue.father_name);
                    print(DataValue.age);
                    print(DataValue.university);
                    print(DataValue.degree);
                    print(DataValue.cgpa);


                    }, child: Text('Add Data',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
              )
            ],
          ),
        
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> FetchDataScreen()));
        },child: Icon(Icons.arrow_forward,size: 20,color: Colors.black,),),
    );
  }
}
