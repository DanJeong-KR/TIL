//
//  ViewController.swift
//  DispatchQueueExample
//
//  Created by giftbot on 2019. 5. 20..
//  Copyright © 2019년 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
  
  @IBOutlet private weak var testView: UIView!

  @IBAction private func buttonDidTap(_ sender: Any) {
    print("---------- [ Change Color ] ----------\n")
    let r = CGFloat.random(in: 0...1.0)
    let g = CGFloat.random(in: 0...1.0)
    let b = CGFloat.random(in: 0...1.0)
    testView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
  }

    // main 에서는 큰 작업을 시키면 안된다. 버벅인다.
  func bigTask() { // 하나의 연산작업이나 코드블럭이 Task
    print("= Big task start =")
    for _ in 0...900_000_000 { _ = 1 + 1 }
    print("= Big task end =")
  }
  @IBAction func bigTaskOnMainThread() {
    //bigTask()

    // concurrent queue 에서 비동기적으로 task 를 수행한다.
    DispatchQueue.global().async {
        self.bigTask()
    }
    // 동시에 두 가지 작업을 수행하려면?
    
  }
  
  @IBAction func uiTaskOnBackgroundThread() {
    print("\n---------- [ uiTaskOnBackgroundThread ] ----------\n")
    
     //Invalid usage warning
//    DispatchQueue.global().async {
//      self.bigTask()
//      self.buttonDidTap(self) // 글로벌 스레드에서 ui바꾸는 작업을 하라고 경고가 뜸
//    }
    // 해결 방법?
//    DispatchQueue.global().async {
//        self.bigTask()
//        // 예를 들어 이미지 네트워킹
//
//        DispatchQueue.main.async {
//            // imageView 에 image 넣는 작업을 여기서.
//            self.buttonDidTap(self)
//        }
//    }
    DispatchQueue.global().async {
        self.bigTask()
        DispatchQueue.main.async {
            self.buttonDidTap(self)
        }
    }
  }
  
  @IBAction func executionOrder() {
    
    let serialQueue = DispatchQueue(label: "kr.changsik.serialQueue")
    print("\n---------- [ Serial Sync ] ----------\n")
    serialQueue.sync { print("1") }
    print("A")
    serialQueue.sync { print("2")}
    print("B")
    serialQueue.sync { print("3")}
    print("C")

    // Q. queue 에는 main 이나 global 안붙여도 상관없나?  안붙이면 디폴드 값이 무조건 main?

    print("\n---------- [ Serial Async ] ----------\n")
    serialQueue.async { print("1")}
    print("A")
    serialQueue.async { print("2")}
    print("B")
    serialQueue.async { print("3")}
    print("C")


    let concurrentQueue = DispatchQueue(label: "changsik.concurrentQueue", attributes: .concurrent)
    print("\n---------- [ Concurrent Sync ] ----------\n")
    concurrentQueue.sync { print("1")}
    print("A")
    concurrentQueue.sync { print("2")}
    print("B")
    concurrentQueue.sync { print("3")}
    print("C")

    print("\n---------- [ Concurrent Async ] ----------\n")
    concurrentQueue.async { print("1")}
    print("A")
    concurrentQueue.async { print("2")}
    print("B")
    concurrentQueue.async { print("3")}
    print("C")

    print("\n---------- [ Concurrent Async ] ----------\n")

    concurrentQueue.async { print("1") }
    print("A")
    concurrentQueue.async { print("2") }
    print("B")
    concurrentQueue.async { print("3") }
    print("C")
  }
  
  
  private func createDispatchWorkItem() -> DispatchWorkItem {
    let workItem = DispatchWorkItem {
      let bigNumber = 20_000_000
      let divideNumber = 5_000_000
      for i in 1...bigNumber {
        i % divideNumber == 0 ? print(i / divideNumber * 25, "%") : ()
      }
      print("done")
    }
    return workItem
  }
  
  @IBAction func waitWorkItem() {
    print("\n---------- [ waitWorkItem ] ----------\n")
    
    let workItem = createDispatchWorkItem()
    
    let myQueue = DispatchQueue(label: "changsik.myQueue")
    //myQueue.async(execute: workItem)
    myQueue.sync(execute: workItem)
    
    print("waiting 전")
    workItem.wait() // 비동기로 동작하는 작업을 기다렸다가 다음 줄의 코드 실행
    print("waiting 후")
  }
  
  
  // InactiveQueue
    let inactiveQueue = DispatchQueue(label: "changsik.inactiveQueue", attributes: .initiallyInactive)
    
    @IBAction func initiallyInactiveQueue() {
        print("\n---------- [ initiallyInactiveQueue ] ----------\n")
        
        let workItem = createDispatchWorkItem()
        inactiveQueue.async(execute: workItem)
        
        print("= Do Something... =")
        
        // 이전에 만들어 두고 필요할 때 Queue의 비동기 코드를 활성화 시킴.
        inactiveQueue.activate()
    }
    
  
    
  @IBAction func groupNotify() {
    print("\n---------- [ groupNotify ] ----------\n")
    
    let group =
        DispatchGroup()
    let queue1 = DispatchQueue(label: "changsik.queue1")
    let queue2 = DispatchQueue(label: "changsik.queue2")
    let queue3 = DispatchQueue(label: "changsik.queue3")
    
    //3번째
    queue1.async(group: group) {
        print("queue1 시작")
        for _ in 0...990_000_000 { _ = 1 + 1 }
        print("queue1 완료")
    }
    
    //2 번째
    queue2.async(group: group) {
        print("queue2 시작")
        for _ in 0...400_000_000 { _ = 1 + 1 }
        print("queue2 완료")
    }
    
    //1 번째
    queue3.async(group: group) {
        print("queue3 시작")
        for _ in 0...10_000_000 { _ = 1 + 1 }
        print("queue3 완료")
    }
    
    //모든 작업이 끝나면 알려주는 메소드
    group.notify(queue: .main) {
        print("전체 완료")
    }
  }
  
  
  var myWorkItem: DispatchWorkItem!
  
  @IBAction func cancelDispatchWorkItem() {
    myWorkItem = DispatchWorkItem(qos: .default) {
      let bigNumber = 80_000_000
      let divideNumber = 20_000_000
      for i in 1...bigNumber {
        guard !self.myWorkItem.isCancelled else { return }
        i % divideNumber == 0 ? print(i / divideNumber * 25, "%") : ()
      }
      print("done")
    }
    
    
    myWorkItem.perform() // workItem 을 바로 실행시킬 수 있지만 timeout 은 수행하지 않는다. 이 점을 유의.
    //DispatchQueue.global().async(execute: myWorkItem)
    
    
    // 2초 안에 완료하지 못하면 작업을 취소하고자 할 때
    let timeoutResult = myWorkItem.wait(timeout: .now() + 2)
    switch timeoutResult {
    case .success: print("success within 2 seconds")
    case .timedOut:
      myWorkItem.cancel() // cancel 은 안되고 iscancelled 라는 속성을 true 로 바꿔줌
      print("Timed out. task cancelled")
    }
  }
  
  
  @IBAction func testButton() {
  }
}


// 핵  심
// - 메인에서 빅 테스크를 실행하면 안된다
// - UI 를 Background 에서 수행하면 안된다는 것.
