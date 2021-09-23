//
//  AddingAppliancesView.swift
//  sRemo
//
//  Created by zunda on 2021/09/20.
//

import SwiftUI

protocol AddingAppliancesDelegate {
    func addAppliances(_ appliancesModel: AppliancesModel)
}

struct AddingAppliancesView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = AddingAppliancesViewModel()
    @State var selectedDeviceIndex: Int = 0
    @State var selectedAppliancesType: AppliancesTypes = AppliancesTypes.TV
    @State var appliancesNumber: Int = 0
    
    let delegate: AddingAppliancesDelegate
    
    var body: some View {
        List {
            HStack {
                Text("デバイスを選択")
                Spacer()
                Picker(selection: $selectedDeviceIndex, label: Text("デバイスを選択")) {
                    ForEach(0..<viewModel.devices.count) { index in
                        Text(viewModel.devices[index].name)
                            .tag(index)
                    }
                }
                .pickerStyle(.menu)
            }
            
            HStack {
                Text("家電番号")
                Spacer()
                TextField("家電番号", value: $appliancesNumber, formatter: NumberFormatter())
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .frame(width: 50)
                    .multilineTextAlignment(.trailing)
            }
            
            HStack {
                Text("家電タイプを選択")
                Spacer()
                Picker(selection: $selectedAppliancesType, label: Text("家電タイプを選択")) {
                    ForEach(AppliancesTypes.allCases, id: \.self) { appliancesType in
                        Text(appliancesType.rawValue)
                            .tag(appliancesType)
                    }
                }
                .pickerStyle(.menu)
            }
            
            Button(action: {
                let device = self.viewModel.devices[selectedDeviceIndex]
                let newAppliancesModel = AppliancesModel(id: device.id, number: appliancesNumber, type: selectedAppliancesType)
                self.delegate.addAppliances(newAppliancesModel)
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("追加")
            })
        }
    }
}

struct AddingAppliancesView_Previews: PreviewProvider, AddingAppliancesDelegate {
    func addAppliances(_ appliancesModel: AppliancesModel) {
        print("Hello")
    }
    
    static var previews: some View {
        AddingAppliancesView(delegate: self as! AddingAppliancesDelegate)
    }
}
