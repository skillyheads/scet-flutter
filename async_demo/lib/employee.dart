class Employee {
  int empId;
  String empName;
  Employee(this.empId, this.empName);

  @override
  String toString() {
    return "EmpId: $empId; EmpName: $empName";
  }

  Employee? operator +(Object other) {
    if (other is Employee) {
      return Employee(empId + other.empId, '$empName : ${other.empName}');
    }
    return null;
  }

  operator ==(Object other) {
    if (other is Employee) {
      return empId == other.empId;
    }
    return false;
  }

  @override
  int get hashCode => empId * 123;
}
