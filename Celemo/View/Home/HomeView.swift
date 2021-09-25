//
//  HomeView.swift
//  HomeView
//
//  Created by zunda on 2021/09/13.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    
    @ViewBuilder
    func makeAppliancesView(device: DeviceModel, appliancesModel: AppliancesModel) -> some View {
        switch appliancesModel.appliancesType {
            case .TV:
                TVView(device: device, appliancesNumber: appliancesModel.deviceNumber)
            case .DVD:
                DVDView(device: device, appliancesNumber: appliancesModel.deviceNumber)
            case .Switch:
                SwitchView(device: device, appliancesNumber: appliancesModel.deviceNumber)
            case .AirConditioner:
                AirConditionerView(device: device, appliancesNumber: appliancesModel.deviceNumber)
            case .Light:
                LightView(device: device, appliancesNumber: appliancesModel.deviceNumber)
        }
    }
    
    var body: some View {
        List {
            Button(action: {
                self.viewModel.isShowAddingAppliancesView.toggle()
            }, label: {
                Text("家電を追加")
            })
                .sheet(isPresented: $viewModel.isShowAddingAppliancesView) {
                    AddingAppliancesView(delegate: self)
                }
            ForEach(self.viewModel.appliancesModels) { appliancesModel in
                if let device: DeviceModel = self.viewModel.deviceModels.first(where: { return $0.id == appliancesModel.deviceID }) {
                    Button(action: {
                        self.viewModel.isPresentedDetailAppliances.toggle()
                    }, label: {
                        HStack {
                            Text("\(device.name)")
                            Spacer()
                            Text("\(appliancesModel.appliancesType.rawValue)(\(appliancesModel.deviceNumber))")
                        }
                    })
                        .sheet(isPresented: $viewModel.isPresentedDetailAppliances) {
                            self.makeAppliancesView(device: device, appliancesModel: appliancesModel)
                        }
                }
            }
            .onDelete(perform: self.viewModel.removeAppliances(offsets:))
        }
        .onAppear(perform: {
            self.viewModel.loadDevices()
            self.viewModel.loadAppliances()
        })
        .alert("Error", isPresented: $viewModel.happenedError, actions: {
            
        })
    }

}

extension HomeView: AddingAppliancesDelegate {
    func addAppliances(_ appliancesModel: AppliancesModel) {
        self.viewModel.appliancesModels.append(appliancesModel)
        self.viewModel.saveAppliances()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

