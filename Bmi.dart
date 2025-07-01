import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Bmi extends StatefulWidget {
  const Bmi({super.key});

  @override
  State<Bmi> createState() => _BmiState();
}
class _BmiState extends State<Bmi> {
  TextEditingController ctrlH = TextEditingController();
  TextEditingController ctrlW = TextEditingController();

  double _Bmi = 0.0;
  String _bmiStatus = "";

  _calulateBmi (){
    final weight = double.tryParse(ctrlW.text) ?? 0.0 ;
    final height = double.tryParse(ctrlH.text) ?? 0.0;

    if(weight > 0 && height > 0){
      setState(() {
        _Bmi = weight / ((height/100) * (height/100));
        _bmiStatus = _viewStatus(_Bmi);
      });
    }
    return (
    showDialog<String>(
        context: context,
        builder: (BuildContext context)=> AlertDialog(
          backgroundColor:_getColor(_bmiStatus) ,
          title:Text( "BMI Calculate",),
          content: Container(
            height: 60,
            width: 200,
            child: Column(
              children: [
                Text("BMI: ${_Bmi.toStringAsFixed(2)}",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18),),
                Text("Category: $_bmiStatus",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18),),
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(onPressed: () => Navigator.pop(context, 'OK'),
                  child: Text("Ok")),
            )
          ],

        )
        ),
    );
  }

  String _viewStatus(double Bmi) {
    if (Bmi < 18.5)
      return "Underweight";
    else if (Bmi < 24.9)
      return "Normal";
    else if (Bmi < 29.9)
      return "Overweight";

    else return "Obese";
  }

  Color _getColor(String status) {
    switch (status) {
      case "Underweight":
        return Colors.orange;
      case "Normal":
        return Colors.green;
      case "Overweight":
        return Colors.deepOrange;
      case "Obese":
        return Colors.red;
      default:
        return Colors.white;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back_ios),
        title: Text("BMI Calculator",style: TextStyle(color: Colors.black),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.settings_outlined,color: Colors.black,),
          )
        ],

      ),
      body: Form(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black,
            child: Column(
              children: [
                SizedBox(height: 150,),
                Center(
                  child: Container(
                    height: 230,
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: ctrlH,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.deny(RegExp('[a-z,A_Z,[@#!%^&*();:/*-+]')),
                            ],
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("cm",style: TextStyle(color: Colors.grey),),
                              ),
                              hintText: "Enter the Height",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:  TextFormField(
                            controller: ctrlW,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.deny(RegExp('[a-z,A_Z,[@#!%^&*();:/*-+]')),
                            ],
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("KG",style: TextStyle(color: Colors.grey),),
                              ),
                              hintText: "Enter the weight",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        ElevatedButton(onPressed: _calulateBmi,
                                child: Text("BMI")),




                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),

    );
  }
}
