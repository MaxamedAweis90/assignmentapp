import 'dart:io';

double calculator(double num1, double num2, String sign) {
  if (sign == '+') {
    return num1 + num2;
  } else if (sign == '-') {
    return num1 - num2;
  } else if (sign == '*') {
    return num1 * num2;
  } else if (sign == '/') {
    return num1 / num2;
  } else {
    print(' Waxaad Galisay waa qalad!!!');
    return double.nan; // Return NaN for invalid operation
  }
}

void main() {
  double num1, num2, natiijo;
  String sign;
  print('Gali Numberka goobaad:');
  num1 = double.parse(stdin.readLineSync()!);

  print('Gali Calaamda xisaabeed (+, -, *, /):');
  sign = stdin.readLineSync()!;

  print('Gali Numberka Labaad:');
  num2 = double.parse(stdin.readLineSync()!);

  natiijo = calculator(num1, num2, sign);

  print('Natiijo: $natiijo');
}
