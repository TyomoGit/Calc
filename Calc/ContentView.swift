//
//  ContentView.swift
//  Calc
//
//  Created by Tyomo on 2022/08/07.
//

import SwiftUI

struct ContentView: View {
    @State var isFirstNum = true
    @State var displayNum = ""
    @State var firstNum: Double = 0
    @State var secondNum: Double = 0
    enum OperandType {
        case plus
        case minus
        case multiplication
        case division
    }
    @State var mode: OperandType = .plus
    
    var body: some View {
        VStack{
            Text(displayNum)
                .bold()
                .font(.largeTitle)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                .padding()
                //.background(.gray)
                .background(Color.init(red: 0.9, green: 0.9, blue: 0.9))
            Spacer()
            VStack{
                HStack{
                    Button(action: {
                        addNum(num: "7")
                    }, label: {
                        Image(systemName: "7.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    })
                    Button(action: {
                        addNum(num: "8")
                    }, label: {
                        Image(systemName: "8.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    })
                    Button(action: {
                        addNum(num: "9")
                    }, label: {
                        Image(systemName: "9.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    })
                    Button(action: {
                        chooseOperand(mode: .division)
                    }, label: {
                        Image(systemName: "divide.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    })
                }
                HStack{
                    Button(action: {
                        addNum(num: "4")
                    }, label: {
                        Image(systemName: "4.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    })
                    Button(action: {
                        addNum(num: "5")
                    }, label: {
                        Image(systemName: "5.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    })
                    Button(action: {
                        addNum(num: "6")
                    }, label: {
                        Image(systemName: "6.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    })
                    Button(action: {
                        chooseOperand(mode: .multiplication)
                    }, label: {
                        Image(systemName: "multiply.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    })
                }
                HStack{
                    Button(action: {
                        addNum(num: "1")
                    }, label: {
                        Image(systemName: "1.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    })
                    Button(action: {
                        addNum(num: "2")
                    }, label: {
                        Image(systemName: "2.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    })
                    Button(action: {
                        addNum(num: "3")
                    }, label: {
                        Image(systemName: "3.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    })
                    Button(action: {
                        chooseOperand(mode: .minus)
                    }, label: {
                        Image(systemName: "minus.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    })
                }
                HStack{
                    Button(action: {
                        addNum(num: "0")
                    }, label: {
                        Image(systemName: "0.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    })
                    Button(action: {
                        clear()
                    }, label: {
                        Image(systemName: "c.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    })
                    Button(action: {
                        calcResult()
                    }, label: {
                        Image(systemName: "equal.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    })
                    Button(action: {
                        chooseOperand(mode: .plus)
                    }, label: {
                        Image(systemName: "plus.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    })
                }
            }
            .scaledToFill()
            //.frame(height: UIScreen.main.bounds.height * (3/5) , alignment: .bottom)
            //.frame(minHeight: UIScreen.main.bounds.width*(4/4), alignment: .bottom)
            .padding()
        }
    }
    
    func addNum(num: String){
        displayNum += num
    }
    
    func chooseOperand(mode: OperandType){
        if let displayNumUnwrap = Double(displayNum){
            firstNum = Double(displayNumUnwrap)
        }else{
            firstNum = 0
        }
        
        isFirstNum = false
        displayNum = ""
        self.mode = mode
    }
    
    func calcResult(){
        if let displayNumUnwrap = Double(displayNum){
            secondNum = Double(displayNumUnwrap)
        }else{
            secondNum = 0
        }
        isFirstNum = true
        var result: Double? = 0
        
        switch mode {
        case .plus:
            result = calcPlus(a: firstNum, b: secondNum)
        case .minus:
            result = calcMinus(a: firstNum, b: secondNum)
        case .multiplication:
            result = calcMultiplication(a: firstNum, b: secondNum)
        case .division:
            result = calcDivision(a: firstNum, b: secondNum)
        }
        
        clear()
        
        if let resultUnwarap = result {
            displayNum = String(resultUnwarap)
        }else{
            displayNum = "error"
        }
    }

    func calcPlus(a: Double, b: Double ) -> Double{
        return a + b
    }

    func calcMinus(a: Double, b: Double ) -> Double{
        return a - b
    }

    func calcMultiplication(a: Double, b: Double ) -> Double{
        return a * b
    }

    func calcDivision(a: Double, b: Double ) -> Double?{
        if b == 0 { return nil }
        return a / b
    }
    
    func clear(){
        displayNum = ""
        isFirstNum = true
        firstNum = 0
        secondNum = 0
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
