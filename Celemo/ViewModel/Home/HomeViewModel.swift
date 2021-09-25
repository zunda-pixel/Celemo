//
//  HomeViewModel.swift
//  Celemo
//
//  Created by zunda on 2021/09/21.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var appliancesModels: [AppliancesModel]
    @Published var deviceModels: [DeviceModel]
    @Published var isPresentedDetailAppliances = false
    @Published var happenedError: Bool = false
    @Published var isShowAddingAppliancesView = false

    init() {
        appliancesModels = []
        deviceModels = []
    }

    func loadDevices() {
        do {
            self.deviceModels = try UserDefaultWrapper.loadArrayOfData(key: "devicesData")
        } catch let error {
            happenedError.toggle()
            print(error)
        }
    }

    func loadAppliances() {
        do {
            self.appliancesModels = try UserDefaultWrapper.loadArrayOfData(key: "appliancesModelsData")
        } catch let error {
            happenedError.toggle()
            print(error)
        }
    }

    func saveAppliances() {
        do {
            try UserDefaultWrapper.saveArrayOfData(key: "appliancesModelsData", self.appliancesModels)
        } catch let error {
            happenedError.toggle()
            print(error)
        }
    }

    func removeAppliances(offsets: IndexSet) {
        self.appliancesModels.remove(atOffsets: offsets)
        self.saveAppliances()
    }
}
