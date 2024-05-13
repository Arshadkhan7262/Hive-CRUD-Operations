import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_db/Models/DataModel.dart';
import 'package:hive_db/screens/edit_screen.dart';
import 'package:hive_flutter/adapters.dart';

class FetchDataScreen extends StatefulWidget {
  const FetchDataScreen({super.key});

  @override
  State<FetchDataScreen> createState() => _FetchDataScreenState();
}

class _FetchDataScreenState extends State<FetchDataScreen> {
  Future<void> deleteDataAtIndex(int index) async {
    var box = await Hive.openBox('student_info');
    await box.deleteAt(index);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Data Screen'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('student_info').listenable(),
        builder: (context,box,_){
          var data=box.values.toList().whereType<DataModel>().toList();
          return ListView.builder(
            itemCount: data.length,
              itemBuilder: (context,index){
            return Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.3,
                          margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                          child: Text('Name ${data[index].name.toString()}' ,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)),
                      Spacer(),
                      Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                          child: Text('F.N ${data[index].father_name.toString()}' ,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                          child: Text('Age\t ${data[index].age.toString()}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)),
                      Spacer(),
                      Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                          child: Text('Uni\t${data[index].university}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                          child: Text('qual\t${data[index].degree.toString()}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)),
                      Spacer(),
                      Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                          child: Text('CGPA\t${data[index].cgpa.toString()}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                          child: IconButton(onPressed: (){
                            var name=data[index].name;
                            var father_name=data[index].father_name;
                            int? age=data[index].age;
                            var university=data[index].university;
                            var degree=data[index].degree;
                            double?  cgpa=data[index].cgpa;
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> EditScreen(name: name, father_name: father_name, age: age, university: university, degree: degree, cgpa: cgpa)));
                          }, icon: Icon(Icons.edit,size: 30,color: Colors.green,))),
                      Spacer(),
                      Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                          child: IconButton(onPressed: (){
                            deleteDataAtIndex(index).then((value) {
                              Fluttertoast.showToast(msg: 'Data Deleted Successfully',
                              gravity: ToastGravity.BOTTOM,
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.green);

                            }).onError((error, stackTrace) {
                              Fluttertoast.showToast(msg: error.toString(),
                                  gravity: ToastGravity.BOTTOM,
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.red);

                            });


                          }, icon: Icon(Icons.delete,size: 30,color: Colors.red,))),
                    ],
                  )

                ],
              ),
            );

          });
        },
      ),
    );
  }
}
