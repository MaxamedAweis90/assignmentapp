import 'dart:io';

// Function to convert input to GPA (on a 4.0 scale)
double getGPA(String input) {
  Map<String, double> gradeToGPA = {
    'A+': 4.0,
    'A': 3.7,
    'B+': 3.3,
    'B': 3.0,
    'B-': 2.7,
    'C+': 2.3,
    'C': 2.0,
    'C-': 1.7,
    'D+': 1.3,
    'D': 1.0,
    'E': 0.0,
  };

  // Convert percentage to grade letter
  String getGrade(double percentage) {
    if (percentage >= 85) return 'A+';
    if (percentage >= 80) return 'A';
    if (percentage >= 75) return 'B+';
    if (percentage >= 70) return 'B';
    if (percentage >= 65) return 'B-';
    if (percentage >= 60) return 'C+';
    if (percentage >= 55) return 'C';
    if (percentage >= 50) return 'C-';
    if (percentage >= 45) return 'D+';
    if (percentage >= 40) return 'D';
    return 'E';
  }

  double? percentage = double.tryParse(input);
  if (percentage != null) {
    String grade = getGrade(percentage);
    return gradeToGPA[grade]!;
  } else {
    return gradeToGPA[input]!;
  }
}

void main() {
  // Weydii isticmaalaha inuu geliyo boqolleyda ama darajooyinka
  print("Geli boqolleyda ama darajooyinka sida A+ B C+ iwm (isku xiga): ");
  String? input = stdin.readLineSync();

  List<String> inputs = input!.split(' ');
  List<double> gpas = [];

  for (String inp in inputs) {
    gpas.add(getGPA(inp));
  }

  // Xisaabi GPA guud (celcelis ahaan) on a 4.0 scale
  double sum = gpas.reduce((a, b) => a + b);
  double totalGPA = sum / gpas.length;

  // U beddel 10-ka system si loo ogaado darajada, laakin lama soo bandhigayo
  double cgpa10 = (totalGPA / 4.0) * 10;

  // Daabac natiijada Total GPA (3 digits) iyo darajada (CGPA Range)
  print("\nTotal GPA: ${totalGPA.toStringAsFixed(2)}");

  if (cgpa10 > 8.5) {
    print("Darajada: A+ (CGPA > 8.5)");
  } else if (cgpa10 >= 8.0) {
    print("Darajada: A (CGPA 8.0 - 8.4)");
  } else if (cgpa10 >= 7.5) {
    print("Darajada: B+ (CGPA 7.5 - 7.9)");
  } else if (cgpa10 >= 7.0) {
    print("Darajada: B (CGPA 7.0 - 7.4)");
  } else if (cgpa10 >= 6.5) {
    print("Darajada: B- (CGPA 6.5 - 6.9)");
  } else if (cgpa10 >= 6.0) {
    print("Darajada: C+ (CGPA 6.0 - 6.4)");
  } else if (cgpa10 >= 5.5) {
    print("Darajada: C (CGPA 5.5 - 5.9)");
  } else if (cgpa10 >= 5.0) {
    print("Darajada: C- (CGPA 5.0 - 5.4)");
  } else if (cgpa10 >= 4.5) {
    print("Darajada: D+ (CGPA 4.5 - 4.9)");
  } else if (cgpa10 >= 4.0) {
    print("Darajada: D (CGPA 4.0 - 4.4)");
  } else {
    print("Darajada: E (CGPA < 4.0)");
  }
}
