import 'package:calculater/Commponents/my_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {


  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override


  var userInput='';
  var answer='';
  bool  showAnswer= false;

  Widget build(BuildContext context) {
    return  MaterialApp(
debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.black,
        body: SafeArea(child: Padding(padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(

          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: [
                   const  Align(alignment: Alignment.bottomRight,),
                    Text(
                      showAnswer ? answer.toString() : userInput.toString(),
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

           Expanded(
             flex: 2,
             child: Column(

               children: [
                 Row(
                   children: [

                     MyButton(title: 'AC',color: Color(0xffa5a5a5),onpress: () {
                      userInput='';
                      answer='';
                      showAnswer=false;
                      setState(() {

                      });
                     },),
                     MyButton(
                       title: '+/-',
                       color: Color(0xffa5a5a5),
                       onpress: () {
                         setState(() {
                           if (userInput.isNotEmpty) {
                             // If the last number is negative, remove the negative sign
                             if (userInput.startsWith('-')) {
                               userInput = userInput.substring(1);
                             } else {
                               // Otherwise, add the negative sign
                               userInput = '-$userInput';
                             }
                           }
                         });
                       },
                     ),
                     MyButton(title: '%',color: Color(0xffa5a5a5),onpress: (){
                       userInput +='%';
                       setState(() {

                       });
                     }),
                     MyButton(title: '/',color: const Color(0xffffa00a),onpress: (){
                       userInput +='/';
                       setState(() {

                       });
                     }),


                   ],
                 ),
                 Row(
                   children: [

                     MyButton(title: '7',onpress: () {
                       userInput +='7';
                       setState(() {

                       });
                     },),
                     MyButton(title: '8',onpress: (){
                       userInput +='8';
                       setState(() {

                       });
                     },),
                     MyButton(title: '9',onpress: (){
                       userInput +='9';
                       setState(() {

                       });
                     }),
                     MyButton(title: 'x',color: const Color(0xffffa00a),onpress: (){
                       userInput +='x';
                       setState(() {

                       });
                     }),


                   ],
                 ),
                 Row(
                   children: [

                     MyButton(title: '4',onpress: () {
                       userInput +='4';
                       setState(() {

                       });
                     },),
                     MyButton(title: '5',onpress: (){
                       userInput +='5';
                       setState(() {

                       });
                     },),
                     MyButton(title: '6',onpress: (){
                       userInput +='6';
                       setState(() {

                       });
                     }),
                     MyButton(title: '-',color: const Color(0xffffa00a),onpress: (){
                       userInput +='-';
                       setState(() {

                       });
                     }),


                   ],
                 ),
                 Row(
                   children: [

                     MyButton(title: '1',onpress: () {
                       userInput +='1';
                       setState(() {

                       });
                     },),
                     MyButton(title: '2',onpress: (){
                       userInput +='2';
                       setState(() {

                       });
                     },),
                     MyButton(title: '3',onpress: (){
                       userInput +='3';
                       setState(() {

                       });
                     }),
                     MyButton(title: '+',color: const Color(0xffffa00a),onpress: (){
                       userInput +='+';
                       setState(() {

                       });
                     }),


                   ],
                 ),
                 Row(
                   children: [

                     MyButton(title: '0',onpress: () {
                       userInput +='0';
                       setState(() {

                       });
                     },),
                     MyButton(title: '.',onpress: (){
                       userInput +='.';
                       setState(() {

                       });
                     },),
                     MyButton(title: 'DEL',onpress: (){
                       userInput=userInput.substring(0,userInput.length-1);
                       setState(() {

                       });

                     }),
                     MyButton(title: '=',color: const Color(0xffffa00a),onpress: ()
                       {
                         equalPres();
                         showAnswer=true;
                         setState(() {

                         });
                     }),


                   ],
                 )

               ],
             ),
           )
          ],
        ),

        )),

      ),
    );
  }

  void equalPres(){
    String finalUserInput=userInput;
    finalUserInput=userInput.replaceAll('x', '*');
    finalUserInput = handlePercentage(finalUserInput);
        Parser p =Parser();
    Expression expression = p.parse(finalUserInput);
    ContextModel contextModel=ContextModel();
    double eval=expression.evaluate(EvaluationType.REAL, contextModel);
    answer= eval.toString();
  }
}
String handlePercentage(String input) {
  // Regular expression to find patterns like "number%"
  final RegExp regExp = RegExp(r'(\d+)([+\-*/])(\d+)%');
  return input.replaceAllMapped(regExp, (Match match) {
    String numberBeforeOperator = match.group(1)!;
    String operator = match.group(2)!;
    String percentageValue = match.group(3)!;

    // Replace "numberBeforeOperator operator percentage%" with "numberBeforeOperator operator (numberBeforeOperator * percentage / 100)"
    return '$numberBeforeOperator $operator (${numberBeforeOperator} * $percentageValue / 100)';
  });
}







