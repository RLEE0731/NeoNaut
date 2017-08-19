//
//  NeonLightWalletDB.swift
//  Neon
//
//  Created by James Donald on 8/18/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

public enum Net:String
{
    case testNet    = "TestNet"
    case mainNet    = "MainNet"
    
    public func urlString() -> String
    {
        switch(self)
        {
        case .mainNet:
            return "http://api.neonwallet.com"
        case .testNet:
            return "http://testnet-api.neonwallet.com"
        }
    }
}

public class NeonLightWalletDB: NSObject
{
    // The shared api instance
    public static let shared    = NeonLightWalletDB()
    
    // The current net being used for the api
    public var net:Net          = .mainNet
    
    // The current version of the api
    public let version          = "v1"
    
    // Hide the initializer
    private override init()
    { super.init() }
    
    // Select the net to use
    public func select(net:Net)
    { self.net = net }
    
    // builds the full url for the request
    private func build(endpoint: String) -> String
    {
        let host = self.net.urlString()
        return "\(host)/\(self.version)/\(endpoint)"
    }
    
    /// Gets the wallet for the given public address
    /// - parameter address: The public address of which to retrieve the wallet
    /// - parameter successBlock: The block which is called upon a successful response
    public func getWallet(forAddress address:String,
        successBlock:((_ wallet:Wallet?) -> Void)? = nil,
        failureBlock:((_ err:Error?) -> Void)? = nil)
    {
        let urlString   = self.build(endpoint: "address/balance/\(address)")
        let request     = Alamofire
            .request(urlString)
            .responseObject
            {(response: DataResponse<Wallet>) in
                // check for errors
                guard response.result.error == nil else
                {
                    failureBlock?(response.result.error)
                    return
                }
                
                // parse the wallet data
                let balanceResponse = response.result.value
                successBlock?(balanceResponse)
            }
        debugPrint(request)
    }
    
    /// Gets the history of transcations which have affected the given address
    /// - parameter address: The public address of which to retrieve transaction history
    /// - parameter successBlock: The block which is called upon a successful response
    public func getTransactions(forAddress address:String,
        successBlock:((_ transactions:Array<Transaction>) -> Void)? = nil,
        failureBlock:((_ err:Error?) -> Void)? = nil)
    {
        let urlString   = self.build(endpoint: "address/history/\(address)")
        let request     = Alamofire
            .request(urlString)
            .responseObject
            {(response: DataResponse<TransactionHistory>) in
                // check for errors
                guard response.result.error == nil else
                {
                    failureBlock?(response.result.error)
                    return
                }
                
                // parse the transactions
                let transactions = response.result.value?.transactions ?? []
                successBlock?(transactions)
            }
        debugPrint(request)
    }
}
