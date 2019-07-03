
import Foundation


print("HaHa")

let single = SingleLinkedList()

//single.push(node: SingleNode(value: "A"))
//print(single.head?.value)
//single.push(node: SingleNode(value: "B"))
//print(single.head?.next?.value)
//print(single.peek())
//
//single.push(node: SingleNode(value: "C"))
//
//single.insert(node: SingleNode(value: "F"), at: 1)
//
//print(single.size)
//
//print(single.nodeSearch(at: 1)?.next?.value)


let double = DoubleLinkedList()

double.append(node: DoubleNode(value: "A"))
print(double.first?.value)
double.append(node: DoubleNode(value: "B"))
print(double.first?.next?.value)

double.append(node: DoubleNode(value: "C"))
double.insert(node: DoubleNode(value: "F"), at: 1)

//double.removeAll()

double.scanValues()

//double.removeNode(at: 1)

double.removeNode(by: "A")
double.scanValues()
print(double.first?.value)
print(double.last?.value)



