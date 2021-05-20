import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: AfterSplash(),
      duration: 5000,
      text: "Hello in Clock app",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
        fontSize: 40.0,
      ),
      colors: [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.white,
    );
  }
}

class AfterSplash extends StatefulWidget {
  @override
  _AfterSplashState createState() => _AfterSplashState();
}

class _AfterSplashState extends State<AfterSplash> {
  DateTime selectedDate ;
  TimeOfDay selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        title: (Text(
          'Clock App',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        )),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Builder(
        builder: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                selectedDate== null  ?Container() : Text("${selectedDate.toLocal()}".split(' ')[0],
                  style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold) ,),
                selectedTime== null ?Container() : Text('${selectedTime.hour}:${selectedTime.minute}',
                  style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold) ,),
                SizedBox(height: 50,),

                InkWell(
                  child: Column(
                    children: [
                      Icon(Icons.access_alarm_rounded,size: 100,color: Colors.green,),
                      Text('Please Enter here',style: TextStyle(fontSize: 30,color: Colors.green),)
                    ],
                  ),
                  splashColor: Colors.blueGrey,
                  highlightColor: Colors.amberAccent,
                  onTap: () {
                    _selectDateTime(context).then((value) => snackBar());
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),);
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final TimeOfDay pickedTime = await showTimePicker(context: context, initialTime: selectedTime ?? initialTime );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = pickedTime;
      });
    
  }

  Widget snackBar(){
    
    final snackBar = SnackBar(content:
    Text("Date : ${selectedDate.day}/${selectedDate.month}/${selectedDate.year} \n "
        "Time : ${selectedTime.hour}:${selectedTime.minute}",textAlign: TextAlign.center,
    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
      ,backgroundColor: Colors.greenAccent);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
