import UIKit

//MARK: - fizbuzz with for loop -
func fizzBuzzz(n: Int) -> Void {
   for i in 0..<n {
       each(i)
   }

}

//MARK: - fizbuzz without for loop -
func each(_ n: Int) -> Void {
    switch(n % 3 == 0, n % 5 == 0) {
    case(true, false):
        print("fizz")
    case(false, true):
        print("buzz")
    case(true, true):
        print("fizzbuzz")
    case(false, false):
        print("\(n)")
    }
    
}

//MARK: - minimum divisor 1 -
func findMinNumber(n: Int) -> Int {
    var n = n
    var count = 0
    var ans = 1
    
    while (n % 2 == 0) {
        count += 1
        n /= 2
    }

    if (count % 3 != 0) {
        ans *= Int(pow(2.0, Double(count % 3)) )
    }
    var i = 3
    while (i <= Int(sqrt(Double(Int(n))))) {
        count = 0
        while (n % i == 0) {
            count += 1
            n /= i
        }

        if (count % 3 != 0) {
            ans *= Int(pow(Double(i), Double(count % 3)))
        }
        i += 2
    }
    
    if (n > 2) {
        ans *= n
        
    }
    return ans
}

findMinNumber(n: 128)



//MARK: - minimumDivisor with array -
func okz(_ x: Int,_ nums: [Int],_ threshold:Int) -> Bool {
    var sum = 0
    for i in nums {
        sum += Int(ceil(CGFloat(i)/CGFloat(x)));
    }
    return sum <= threshold;
}


func minimumDivisorCorrect(arr: [Int],  threshold: Int) -> Int {
    var low = 1;
    var high = Int.max
    while(low < high){
        let mid = low + (high - low)/2;
        if(okz(mid, arr, threshold)){
            high = mid;
        } else {low = mid + 1;}
    }
    return high;
}
minimumDivisorCorrect(arr: [2, 4, 5], threshold: 10)
//minimumDivisorCorrect(arr: [2, 3, 5, 7], threshold: 11)
//minimumDivisorCorrect(arr: [44,22,33,11,1], threshold: 5)


//MARK: - slowestkey -
func slowestKey(keyTimes: [[Int]]) -> Character {
    let str = "abcdefghijklmnopqrstuvwxyz"
    let alphabetList = Array(str)
    
    var tStart = 0
    var maxT = (0,"")
    keyTimes.map {
        let T = $0[1] - tStart
        let c = alphabetList[$0[0]]
        if T > maxT.0 { maxT = (T, String(c)) }
        tStart = $0[1]
    }
    return Character(String(maxT.1))
}

print(slowestKey(keyTimes: [[0,2],[1,7],[0,9]]))





