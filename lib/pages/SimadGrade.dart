import 'dart:io';

// Function to convert input to GPA (on a 4.0 scale)
double getGPA(String input) {
  Map<String, double> gradeToGPA = {
    'A': 4.0,
    'A-': 3.67,
    'B+': 3.33,
    'B': 3.0,
    'B-': 2.67,
    'C+': 2.33,
    'C': 2.0,
    'C-': 1.67,
    'D': 1.33,
    'F': 0.0,
  };

  // Convert percentage to grade letter
  String getGrade(double percentage) {
    if (percentage >= 95) return 'A';
    if (percentage >= 90) return 'A-';
    if (percentage >= 85) return 'B+';
    if (percentage >= 80) return 'B';
    if (percentage >= 75) return 'B-';
    if (percentage >= 70) return 'C+';
    if (percentage >= 65) return 'C';
    if (percentage >= 60) return 'C-';
    if (percentage >= 50) return 'D';
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

  if (cgpa10 >= 9.5) {
    print("Darajada: A (CGPA ≥ 9.5)");
  } else if (cgpa10 >= 9.0) {
    print("Darajada: A- (CGPA 9.0 - 9.4)");
  } else if (cgpa10 >= 8.5) {
    print("Darajada: B+ (CGPA 8.5 - 8.9)");
  } else if (cgpa10 >= 8.0) {
    print("Darajada: B (CGPA 8.0 - 8.4)");
  } else if (cgpa10 >= 7.5) {
    print("Darajada: B- (CGPA 7.5 - 7.9)");
  } else if (cgpa10 >= 7.0) {
    print("Darajada: C+ (CGPA 7.0 - 7.4)");
  } else if (cgpa10 >= 6.5) {
    print("Darajada: C (CGPA 6.5 - 6.9)");
  } else if (cgpa10 >= 6.0) {
    print("Darajada: C- (CGPA 6.0 - 6.4)");
  } else if (cgpa10 >= 5.0) {
    print("Darajada: D (CGPA 5.0 - 5.9)");
  } else {
    print("Darajada: E (CGPA < 5.0)");
  }
}
