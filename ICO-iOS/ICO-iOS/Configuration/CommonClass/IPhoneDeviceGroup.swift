//
//  IPhoneDeviceGroup.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/21.
//

import Foundation
import UIKit
import DeviceKit

class IPhoneDeviceGroup{
    
    static let groupOfAllowedDevices: [Device] = [.iPhone6, .iPhone6Plus, .iPhone6s, .iPhone6sPlus, .simulator(.iPhone6), .simulator(.iPhone6Plus),.simulator(.iPhone6s),.simulator(.iPhone8),.simulator(.iPhone8Plus),.simulator(.iPhone5),.simulator(.iPhone4)
    ,.simulator(.iPhone7),.simulator(.iPhoneSE),.simulator(.iPhone7Plus),.simulator(.iPhoneSE2)]

    let device = Device.current
     
    
}
