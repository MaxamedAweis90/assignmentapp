import 'package:flutter/material.dart';

class CGPACalculator extends StatefulWidget {
  const CGPACalculator({super.key});

  @override
  _CGPACalculatorState createState() => _CGPACalculatorState();
}

class _CGPACalculatorState extends State<CGPACalculator> {
  final TextEditingController gradesController = TextEditingController();
  String result = '';

  // This function converts an input (either a letter grade or a percentage) into a GPA value.
  double getGPA(String input) {
    // Mapping of letter grades to their corresponding GPA on a 4.0 scale
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

    // Function to convert a percentage into a letter grade.
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

    // Try to treat the input as a percentage.
    double? percentage = double.tryParse(input);
    if (percentage != null) {
      String grade = getGrade(percentage);
      return gradeToGPA[grade]!;
    } else {
      // If it isn’t a percentage, assume it's already a grade string.
      return gradeToGPA[input] ?? 0.0;
    }
  }

  // This function calculates the overall GPA, converts it to the 10-scale, and appends a detailed grade message.
  void calculateCGPA() {
    String input = gradesController.text.trim();
    if (input.isEmpty) {
      setState(() {
        result = "Please enter valid grades or percentages.";
      });
      return;
    }

    // Splitting input on any whitespace to accommodate multiple spaces.
    List<String> inputs = input.split(RegExp(r'\s+'));
    List<double> gpas = inputs.map((grade) => getGPA(grade)).toList();

    double totalGPA = gpas.reduce((a, b) => a + b) / gpas.length;
    double cgpa10 = (totalGPA / 4.0) * 10;

    // Determine a detailed letter grade based on the CGPA in the 10-scale.
    String letterGrade;
    if (cgpa10 > 8.5) {
      letterGrade = "A+ (CGPA > 8.5)";
    } else if (cgpa10 >= 8.0) {
      letterGrade = "A (CGPA 8.0 - 8.4)";
    } else if (cgpa10 >= 7.5) {
      letterGrade = "B+ (CGPA 7.5 - 7.9)";
    } else if (cgpa10 >= 7.0) {
      letterGrade = "B (CGPA 7.0 - 7.4)";
    } else if (cgpa10 >= 6.5) {
      letterGrade = "B- (CGPA 6.5 - 6.9)";
    } else if (cgpa10 >= 6.0) {
      letterGrade = "C+ (CGPA 6.0 - 6.4)";
    } else if (cgpa10 >= 5.5) {
      letterGrade = "C (CGPA 5.5 - 5.9)";
    } else if (cgpa10 >= 5.0) {
      letterGrade = "C- (CGPA 5.0 - 5.4)";
    } else if (cgpa10 >= 4.5) {
      letterGrade = "D+ (CGPA 4.5 - 4.9)";
    } else if (cgpa10 >= 4.0) {
      letterGrade = "D (CGPA 4.0 - 4.4)";
    } else {
      letterGrade = "E (CGPA < 4.0)";
    }

    setState(() {
      result =
          "Total GPA: ${totalGPA.toStringAsFixed(2)}\n" +
          "CGPA (10 Scale): ${cgpa10.toStringAsFixed(2)}\n" +
          "Grade: $letterGrade";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CGPA Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: gradesController,
              decoration: const InputDecoration(
                labelText: 'Enter Grades or Percentages (e.g., A+ B 85)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateCGPA,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: const Text(
                'Calculate CGPA',
                style: TextStyle(color: Color.fromARGB(255, 241, 203, 203)),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              result,
              style: const TextStyle(fontSize: 24, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
