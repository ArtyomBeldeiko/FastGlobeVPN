//
//  VPNManager.swift
//  FastGlobeVPN
//
//  Created by Artyom Beldeiko on 28.09.22.
//

import Foundation
import NetworkExtension

final class VPNHandler {
    
    let vpnManager = NEVPNManager.shared()
    
    func initVPNTunnelProviderManager() {
        
        print("CALL LOAD TO PREFERENCES...")
        self.vpnManager.loadFromPreferences { (error) -> Void in
            
            if((error) != nil) {
                
                print("VPN Preferences error: 1")
            } else {
                
                let IKEv2Protocol = NEVPNProtocolIKEv2()
                
                IKEv2Protocol.username = vpnUser().username
                IKEv2Protocol.serverAddress = vpnServer().serverID
                IKEv2Protocol.remoteIdentifier = vpnServer().remoteID
                IKEv2Protocol.localIdentifier = vpnUser().localID
                
                IKEv2Protocol.deadPeerDetectionRate = .low
                IKEv2Protocol.authenticationMethod = .none
                IKEv2Protocol.useExtendedAuthentication = true
                IKEv2Protocol.disconnectOnSleep = false
                
                IKEv2Protocol.ikeSecurityAssociationParameters.encryptionAlgorithm = .algorithmAES256
                IKEv2Protocol.ikeSecurityAssociationParameters.integrityAlgorithm = .SHA256
                IKEv2Protocol.ikeSecurityAssociationParameters.diffieHellmanGroup = .group14
                IKEv2Protocol.ikeSecurityAssociationParameters.lifetimeMinutes = 1440
                
                IKEv2Protocol.childSecurityAssociationParameters.encryptionAlgorithm = .algorithmAES256
                IKEv2Protocol.childSecurityAssociationParameters.integrityAlgorithm = .SHA256
                IKEv2Protocol.childSecurityAssociationParameters.diffieHellmanGroup = .group14
                IKEv2Protocol.childSecurityAssociationParameters.lifetimeMinutes = 1440
                
                let kcs = KeychainService()
                kcs.save(key: "VPN_PASSWORD", value: vpnUser().password)
                IKEv2Protocol.passwordReference = kcs.load(key: "VPN_PASSWORD")
                
                self.vpnManager.protocolConfiguration = IKEv2Protocol
                self.vpnManager.localizedDescription = "Safe Login Configuration"
                self.vpnManager.isEnabled = true
                
                self.vpnManager.isOnDemandEnabled = true
                
                
                
                var rules = [NEOnDemandRule]()
                let rule = NEOnDemandRuleConnect()
                rule.interfaceTypeMatch = .any
                rules.append(rule)
                
                print("SAVE TO PREFERENCES...")
                
                self.vpnManager.saveToPreferences(completionHandler: { (error) -> Void in
                    if((error) != nil) {
                        
                        print("VPN Preferences error: 2")
                    } else {
                        
                        print("CALL LOAD TO PREFERENCES AGAIN...")
                        
                        self.vpnManager.loadFromPreferences(completionHandler: { (error) in
                            if ((error) != nil) {
                                print("VPN Preferences error: 2")
                            } else {
                                var startError: NSError?
                                do {
                                    try self.vpnManager.connection.startVPNTunnel()
                                } catch let error as NSError {
                                    
                                    startError = error
                                    print(startError.debugDescription)
                                } catch {
                                    
                                    print("Fatal Error")
                                    fatalError()
                                }
                                if ((startError) != nil) {
                                    print("VPN Preferences error: 3")
                                    print("title: Oops.., message: Something went wrong while connecting to the VPN. Please try again.")
                                    
                                    print(startError.debugDescription)
                                } else {
                                    print("Starting VPN...")
                                }
                            }
                        })
                    }
                })
            }
        }
        
    }
    
    static func connectVPN() {
        VPNHandler().initVPNTunnelProviderManager()
        print("Connection check: Connected")
    }
    
    static func disconnectVPN() {
        VPNHandler().vpnManager.connection.stopVPNTunnel()
        print("Connection check: Disconnected")
    }
    
    static func checkStatus() {
        
        let status = VPNHandler().vpnManager.connection.status
        print("VPN connection status = \(status.rawValue)")
        
        switch status {
        case NEVPNStatus.connected:
            
            print("Connected")
            
        case NEVPNStatus.invalid, NEVPNStatus.disconnected :
            
            print("Disconnected")
            
        case NEVPNStatus.connecting , NEVPNStatus.reasserting:
            
            print("Connecting")
            
        case NEVPNStatus.disconnecting:
            
            print("Disconnecting")
            
        default:
            print("Unknown VPN connection status")
        }
    }
}

