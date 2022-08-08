//
//  ContentView.swift
//  Calc
//
//  Created by Tyomo on 2022/08/07.
//

import SwiftUI

struct ContentView: View {
    @State var isFirstNum = true
    @State var hasDot = false
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
    let buttonWidth: CGFloat = ( UIScreen.main.bounds.width - 50)/4
    let items: [[String]] = [
        ["AC", "±", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]
    let numbers: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    let symbols: [String] = ["+", "-", "×", "÷","="]
    let functions: [String] = ["AC", "±", "."]
    
    var body: some View {
        VStack{
            ZStack{
                Text(displayNum)
                    .bold()
                    .font(.largeTitle)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
            .background(Color.init(red: 0.9, green: 0.9, blue: 0.9))
            
            VStack{
                ForEach(items, id: \.self){ lineItem in
                    HStack{
                        ForEach(lineItem, id: \.self){ item in
                            Button(action: {
                                clickButton(item: item)
                            }, label: {
                                ZStack{
                                    if item == "AC" || item == "0"{
                                        Rectangle()
                                            .frame(width: buttonWidth * 2 + 10, height: buttonWidth)
                                    }else{
                                        Rectangle()
                                            .frame(width: buttonWidth, height: buttonWidth)
                                    }
                                    Text(item)
                                        .bold()
                                        .scaledToFit()
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                                }
                                .foregroundColor(colorSelecter(item: item))
                                
                            })
                            .cornerRadius(16)
                            
                        }
                    }
                }
            }
            .scaledToFill()
            .padding(.bottom)
        }
        .navigationBarTitle("Calculator", displayMode: .inline)
        
    }
    
    //小数点は例外で青色
    func colorSelecter(item: String) -> Color{
        var buttonColor: Color = .blue
        if(numbers.contains(item) || item == "."){
            buttonColor = .blue
        }else if symbols.contains(item){
            buttonColor = .orange
        }else{
            buttonColor = .gray
        }
        return buttonColor
    }
    
    func clickButton(item: String){
        if numbers.contains(item){
            addNum(num: item)
        }else if symbols.contains(item) || functions.contains(item){
            switch item{
            case "+":
                chooseOperand(mode: .plus)
            case "-":
                chooseOperand(mode: .minus)
            case "×":
                chooseOperand(mode: .multiplication)
            case "÷":
                chooseOperand(mode: .division)
            case "=":
                calcResult()
            case "AC":
                clear()
            case "±":
                break;
            case ".":
                if(hasDot == false){
                    displayNum += "."
                    hasDot = true
                }
            default:
                chooseOperand(mode: .plus)
            }
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
        hasDot = false
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
            if(resultUnwarap == floor(resultUnwarap)){
                displayNum = String(Int(resultUnwarap))
            }else{
                displayNum = String(resultUnwarap)
            }
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
        hasDot = false
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
