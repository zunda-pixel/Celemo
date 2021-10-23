//
//  Signal.swift
//  Celemo
//
//  Created by zunda on 2021/09/23.
//

import Foundation

struct Signal {
    struct AirConditioner {
        static let Power = [
            "オン" : "n",
            "オフ" : "f"
        ]
        
        static let Mode = [
            "自動" : 1,
            "冷房" : 2,
            "暖房" : 3,
            "ドライ" : 4,
            "送風" : 5,
        ]

        static let AirFlowAmount = [
            "自動" : 1,
            "強さ1" : 2,
            "強さ2" : 3,
            "強さ3" : 4,
            "強さ4" : 5,
            "強さ5" : 6,
            "静か" : 7,
        ]

        static let AirFlowDirection = [
            "停止" : 1,
            "上下" : 2,
            "左右" : 3,
            "両方" : 4,
        ]
    }
    
    enum TV: Int {
        case Power = 1
        case DigitalTV = 2
        case BS = 3
        case CS = 4
        case SwitchInput = 5
        case Ch1 = 6
        case Ch2 = 7
        case Ch3 = 8
        case Ch4 = 9
        case Ch5 = 10
        case Ch6 = 11
        case Ch7 = 12
        case Ch8 = 13
        case Ch9 = 14
        case Ch10 = 15
        case Ch11 = 16
        case Ch12 = 17
        case VolumeUp = 18
        case VolumeDown = 19
        case ChannelUp = 20
        case ChannelDown = 21
        case ScheduleTV = 22
        case Data = 23
        case Up = 24
        case Down = 25
        case Right = 26
        case Left = 27
        case Decision = 28
        case Mute = 29
        case Menu = 30
        case Undo = 31
        case Blue = 32
        case Red = 33
        case Green = 34
        case Yellow = 35
        case BS1 = 36
        case BS2 = 37
        case BS3 = 38
        case BS4 = 39
        case BS5 = 40
        case BS6 = 41
        case BS7 = 42
        case BS8 = 43
        case BS9 = 44
        case BS10 = 45
        case BS11 = 46
        case BS12 = 47
        case CS1 = 48
        case CS2 = 49
        case CS3 = 50
        case CS4 = 51
        case CS5 = 52
        case CS6 = 53
        case CS7 = 54
        case CS8 = 55
        case CS9 = 56
        case CS10 = 57
        case CS11 = 58
        case CS12 = 59
    }
}
