import 'dart:io';


void main(){
  print("enter two numbers:");
  String? val1 = stdin.readLineSync();
  String? val2 = stdin.readLineSync();
  int intval1 = int.parse(val1!);
  int intval2 = int.parse(val2!);

  int sum = intval1 + intval2;
  print("the sum is $sum");

}