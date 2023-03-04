//
//  Calculator.swift
//  Calculartor
//
//  Created by 박경춘 on 2023/03/02.
//

import SwiftUI

enum ButtonType: String {
    case zero, one, two, three, four, five, six, seven, eight, nine
    case dot, equal, plus, minus, multiple, divide
    case percent, opposite, clear
    
    var ButtonDisplayName: String{
        switch self {
        case .zero:
            return "0"
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .equal:
            return "="
        case .plus:
            return "+"
        case .minus:
            return "-"
        case .multiple:
            return "X"
        case .dot:
            return "."
        case .opposite:
            return "+/-"
        case .divide:
            return "÷"
        case .clear:
            return "C"
        case .percent:
            return "%"
        }
    }
    
    var ButtonbackgroundColor: Color{
        switch self{
        case .dot, .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            return Color("Number")
        case .clear, .opposite, .percent:
            return Color.gray
        case .multiple, .minus, .plus, .equal, .divide:
            return Color.orange
        }
    }
    
    var ButtonforegroundColor: Color{
        switch self{
        case .dot, .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .multiple, .minus, .plus, .equal, .divide:
            return Color.white
        case .clear, .opposite, .percent:
            return Color.black
       
        }
    }
}
    
struct ContentView: View {
        
    @State var toltalNumber: String = "0"
    @State var tmptotalNumber : Int = 0
    @State var operateType: ButtonType = .clear
    @State var isNotEditing: Bool = true
        
        private let buttonData: [[ButtonType]] = [
            [.clear,.opposite,.percent,.divide],
            [.seven,.eight,.nine,.multiple],
            [.four,.five,.six,.minus],
            [.three,.two,.one,.plus],
            [.zero,.dot,.equal]
        ]
        
        
        
        
        var body: some View {
            ZStack{
                Color.black.ignoresSafeArea()
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Text(toltalNumber)
                            .padding()
                            .font(.system(size: 70))
                            .foregroundColor(.white)
                    }
                    
                    ForEach(buttonData, id: \.self) { line in
                        HStack{
                            ForEach(line, id: \.self){ item in
                                Button {
                                    if isNotEditing{
                                        if item == .clear {
                                            toltalNumber = "0"
                                            isNotEditing = true
                                        }
                                        else if item == .plus ||
                                                    item == .minus ||
                                                    item == .multiple ||
                                                    item == .divide
                                        {
                                            toltalNumber = "Error"
                                            //isNotEditing = false
                                        }
                                        else{
                                            toltalNumber = item.ButtonDisplayName
                                            isNotEditing = false
                                        }
                                        
                                    }
                                    else{
                                        if item == .clear {
                                            toltalNumber = "0"
                                            isNotEditing = true
                                        }
                                        else if item == .plus
                                        {
                                            tmptotalNumber = Int(toltalNumber) ?? 0
                                            operateType = .plus
                                            isNotEditing = true
                                            
                                        }
                                        else if item == .minus
                                        {
                                            tmptotalNumber = Int(toltalNumber) ?? 0
                                            operateType = .minus
                                            isNotEditing = true
                                            
                                        }
                                        else if item == .multiple
                                        {
                                            tmptotalNumber = Int(toltalNumber) ?? 0
                                            operateType = .multiple
                                            isNotEditing = true
                                            
                                        }
                                        else if item == .divide
                                        {
                                            tmptotalNumber = Int(toltalNumber) ?? 0
                                            operateType = .divide
                                            isNotEditing = true
                                            
                                        }
                                        else if item == .equal
                                        {
                                            if operateType == .plus{
                                                toltalNumber = String((Int(toltalNumber) ?? 0) + tmptotalNumber)
                                            }
                                            else if operateType == .minus{
                                                toltalNumber = String(tmptotalNumber - (Int(toltalNumber) ?? 0))
                                            }
                                            else if operateType == .multiple{
                                                toltalNumber = String((Int(toltalNumber) ?? 0) * tmptotalNumber)
                                            }
                                            else if operateType == .divide{
                                                toltalNumber = String(tmptotalNumber / (Int(toltalNumber) ?? 0))
                                            }
                                        }
                                        else{
                                            toltalNumber += item.ButtonDisplayName
                                        }
                                    }
                                    
                                } label: {
                                    Text(item.ButtonDisplayName)
                                        .bold()
                                        .frame(width: calButtonWidth(button: item), height: calButtonHeight(button: item))
                                        .background(item.ButtonbackgroundColor)
                                        .cornerRadius(40)
                                        .foregroundColor(item.ButtonforegroundColor)
                                        .font(.system(size: 33))
                                }
                            }
                        }
                    }
                }
            }
    }
    
    private func calButtonWidth(button buttonType: ButtonType) -> CGFloat {
        switch buttonType{
        case .zero:
            return ((UIScreen.main.bounds.width - 5*10) / 4) * 2
        default:
            return (UIScreen.main.bounds.width - 5*10) / 4
        }
    }
    
    private func calButtonHeight(button: ButtonType) -> CGFloat {
        return (UIScreen.main.bounds.width - 5*10) / 4
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
