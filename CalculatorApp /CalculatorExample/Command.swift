
import Foundation

// 크게 네개의 작업으로 분류한다.
enum Command {
    case addDigit(String) // 숫자 추가
    case operation(String) // 연산해야 하는 작업
    case equal //  = 작업
    case clear // 쿨리어
}


/*
 사칙연산 수행을 위한 operator 생성
 
 
 */
