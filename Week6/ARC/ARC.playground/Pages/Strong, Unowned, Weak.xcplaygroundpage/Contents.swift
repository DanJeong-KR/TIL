//: [Previous](@previous)
//: - - -
//: # Unowned
//: - - -

class Teacher {
  var student: Student?
  deinit {
    print("Teacher is being deinitialized")
  }
}

class Student {
  // strong, unowned, weak
//  let teacher: Teacher
  unowned let teacher: Teacher
//  weak var teacher: Teacher?
  
  init(teacher: Teacher) {
    self.teacher = teacher
  }
  deinit {
    print("Student is being deinitialized")
  }
}

var teacher: Teacher? = Teacher()
var student: Student? = Student(teacher: teacher!)
teacher?.student = student

//teacher?.student = nil

print("\n---------- [ teacher release ] ----------\n")
teacher = nil

print("\n---------- [ student release ] ----------\n")
student = nil


// delegate 에서 weak var delegate 도 강한참조 사이클 때문에 써준다.

/***************************************************
 1) strong  : 명시적으로 nil 대입 필요. teacher?.student = nil
 2) unowned : 자동으로 deinit. nil 처리 된 속성에 접근하면 런타임 에러 발생
 3) weak    : 자동으로 deinit. nil 처리 된 속성에 접근하면 nil 반환
 ***************************************************/


//: [Next](@next)
