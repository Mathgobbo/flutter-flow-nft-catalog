import UIKit
import Flutter
import Flow
import FCL

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        initFCL(network: .mainnet)
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let deviceChannel = FlutterMethodChannel(name: "flowflutternftcatalog.beyonders/iOS",
                                                 binaryMessenger: controller.binaryMessenger)
        prepareMethodHandler(deviceChannel: deviceChannel)
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    /**
     Method to parse the method called by the Flutter application and resolve one of the following funtions
     **/
    private func prepareMethodHandler(deviceChannel: FlutterMethodChannel) {
        deviceChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if call.method == "getCatalog" {
                Task{
                    await self.getCatalog(result: result, call: call)
                }
            } else if(call.method == "getCatalogLength") {
                Task {
                    await self.getCatalogLength(result: result)
                }
            } else if(call.method == "changeToMainnet") {
                if(fcl.currentEnv != .mainnet){
                    self.initFCL(network: .mainnet)
                    result(nil);
                }
            } else if(call.method == "changeToTestnet") {
                if(fcl.currentEnv != .testnet){
                    self.initFCL(network: .testnet)
                    result(nil)
                }
            }else if (call.method == "changeToEmulator") {
                if(fcl.currentEnv != .emulator){
                    self.initFCL(network: .emulator)
                    result(nil)
                }
            }else if(call.method == "getCurrentUser"){
                self.getCurrentUser(result: result);
            }else if(call.method == "authenticate") {
                Task {
                    await self.authenticateUser(result:result);
                }
            }else if(call.method == "unauthenticate") {
                Task {
                    await self.unauthenticate(result:result);
                }
            }else if (call.method == "getAccountNFTs") {
                Task {
                    await self.getAccountNFTs(result: result, call: call)
                }
            } else if (call.method == "getAccountBeyondAffiliate") {
                Task {
                    await self.getAccountBeyondAffiliate(result: result, call: call)
                }
            }else if(call.method == "mintBeyondNFT") {
                Task {
                    await self.mintBeyondNFT(result: result)
                }
            }else {
                result(FlutterMethodNotImplemented)
                return
            }
            
        })
    }
    
    /**
     Method to confiure FCL
     @param network receives the desired network to start the FCL
     **/
    func initFCL(network: Flow.ChainID) {
        let accountProof = FCL.Metadata.AccountProofConfig(appIdentifier: "Flow Catalog v(0.0)")
        let walletConnect = FCL.Metadata.WalletConnectConfig(urlScheme: "flowCatalog://", projectID: "c284f5a3346da817aeca9a4e6bc7f935")
        let metadata = FCL.Metadata(appName: "Flow Catalog",
                                    appDescription: "Native Version of the Flow Catalog!",
                                    appIcon: URL(string: "https://placekitten.com/g/200/200")!,
                                    location: URL(string: "https://flow.org")!,
                                    accountProof: accountProof,
                                    walletConnectConfig: walletConnect)
        fcl.config(metadata: metadata,
                   env: network,
                   provider: fcl.currentProvider ?? .lilico)
    
        
        if(network == .mainnet){
            fcl.config.put("0xNFTCatalog", value: "0x49a7cda3a1eecc29")
            fcl.config.put("0xCustomNonFungibleToken", value: "0x1d7e57aa55817448")
            fcl.config.put("0xMetadataViews", value: "0x1d7e57aa55817448")
            fcl.config.put("0xNFTRetrieval", value: "0x49a7cda3a1eecc29")
            fcl.config.put("0xFlowToken", value: "0x1654653399040a61")
        }else if (network == .testnet){
            fcl.config.put("0xNFTCatalog", value: "0x324c34e1c517e4db")
            fcl.config.put("0xCustomNonFungibleToken", value: "0x631e88ae7f1d7c20")
            fcl.config.put("0xMetadataViews", value: "0x631e88ae7f1d7c20")
            fcl.config.put("0xNFTRetrieval", value: "0x324c34e1c517e4db")
            fcl.config.put("0xFlowToken", value: "0x7e60df042a9c0868")
            fcl.config.put("0xBeyond", value: "0x8294d1ec28f6ce7c")
        }else if(network == .emulator){
            fcl.config.put("0xNFTCatalog", value: "0xf8d6e0586b0a20c7")
            fcl.config.put("0xCustomNonFungibleToken", value: "0xf8d6e0586b0a20c7")
            fcl.config.put("0xMetadataViews", value: "0xf8d6e0586b0a20c7")
            fcl.config.put("0xNFTRetrieval", value: "0xf8d6e0586b0a20c7")
            fcl.config.put("0xBeyond", value: "0xf8d6e0586b0a20c7")
            fcl.config.put("0xFlowToken", value: "0x0ae53cb6e3f42a79")
            fcl.config.put("discovery.wallet", value: "http://localhost:8701/fcl/authn")
        }
    }
    
    
    /* Script to get Catalog in batches */
    var getCatalogScript: String =
            """
            import NFTCatalog from 0xNFTCatalog
            
                        pub fun main(batch : [UInt64]?): {String : NFTCatalog.NFTCatalogMetadata} {
                            if(batch == nil){
                                return NFTCatalog.getCatalog()
                            }
                            let catalog = NFTCatalog.getCatalog()
                            let catalogIDs = catalog.keys
                            var data : {String : NFTCatalog.NFTCatalogMetadata} = {}
                            var i = batch![0]
                            while i < batch![1] {
                                data.insert(key: catalogIDs[i], catalog[catalogIDs[i]]!)
                                i = i + 1
                            }
                            return data
                        }
            """
    /* Funtion to get Catalog in batches */
    private func getCatalog(result: FlutterResult, call: FlutterMethodCall) async {
        do{
            let args = call.arguments as! Dictionary<String, Any>
            let firstBatch = args["firstBatch"] as! Int
            let secondBatch = args["secondBatch"] as! Int
            
            let response = try await fcl.query {
                cadence {
                    getCatalogScript
                }
                arguments {
                    [.array([.uint64(UInt64(firstBatch)), .uint64(UInt64(secondBatch))])]
                }
            }.decode()
            result(response)
        }catch {
            print(error)
            result(error.localizedDescription)
        }
    }
    
    /**
     Functions to Get total of collections in catalog
     */
    private func getCatalogLength(result: FlutterResult) async {
        do{
            let response = try await fcl.query {
                cadence {
                    """
                    import NFTCatalog from 0xNFTCatalog
                    
                    pub fun main(): Int {
                        let catalog = NFTCatalog.getCatalog()
                        let catalogIDs = catalog.keys
                        return catalogIDs.length
                    }
                    """
                }
            }.decode()
            result(response)
        }catch {
            print(error)
            result(error.localizedDescription)
        }
    }
    
    /**
     Method to get FCL Current user
     */
    private func getCurrentUser(result: FlutterResult) {
        do {
            let response  = fcl.currentUser
            let jsonResponse = try response?.json()
            result(jsonResponse)
        }catch {
            print(error)
            result(error.localizedDescription)
        }
    }
    
    /**
     Method to Authenticate FCL user!
     */
    private func authenticateUser(result: FlutterResult) async {
        do {
            let response = try await fcl.authenticate()
            result(response.addr.description)
        }catch {
            print(error);
            result(error.localizedDescription)
        }
    }
    
    /**
     Method to Log out FCL user!
     */
    private func unauthenticate(result: FlutterResult) async {
        do {
            try await fcl.unauthenticate()
            result(nil)
        }catch{
            print(error)
            result(error.localizedDescription)
        }
    }
    
    
    /**
     Method to get all NFTs from an account
     */
    var getAccountNFTsScript = """
    import MetadataViews from 0xMetadataViews
    import NFTCatalog from 0xNFTCatalog
    import NFTRetrieval from 0xNFTRetrieval

    pub struct NFT {
        pub let id: UInt64
        pub let name: String
        pub let description: String
        pub let thumbnail: String
        pub let externalURL: String
        pub let storagePath: StoragePath
        pub let publicPath: PublicPath
        pub let privatePath: PrivatePath
        pub let publicLinkedType: Type
        pub let privateLinkedType: Type
        pub let collectionName: String
        pub let collectionDescription: String
        pub let collectionSquareImage: String
        pub let collectionBannerImage: String
        pub let collectionExternalURL: String
        pub let royalties: [MetadataViews.Royalty]

        init(
            id: UInt64,
            name: String,
            description: String,
            thumbnail: String,
            externalURL: String,
            storagePath: StoragePath,
            publicPath: PublicPath,
            privatePath: PrivatePath,
            publicLinkedType: Type,
            privateLinkedType: Type,
            collectionName: String,
            collectionDescription: String,
            collectionSquareImage: String,
            collectionBannerImage: String,
            collectionExternalURL: String,
            royalties: [MetadataViews.Royalty]
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.thumbnail = thumbnail
            self.externalURL = externalURL
            self.storagePath = storagePath
            self.publicPath = publicPath
            self.privatePath = privatePath
            self.publicLinkedType = publicLinkedType
            self.privateLinkedType = privateLinkedType
            self.collectionName = collectionName
            self.collectionDescription = collectionDescription
            self.collectionSquareImage = collectionSquareImage
            self.collectionBannerImage = collectionBannerImage
            self.collectionExternalURL = collectionExternalURL
            self.royalties = royalties
        }
    }

    pub fun main(ownerAddress: Address): {String: [NFT]} {
        let catalog = NFTCatalog.getCatalog()
        let account = getAuthAccount(ownerAddress)
        let items: [MetadataViews.NFTView] = []
        let data: {String: [NFT]} = {}

        for key in catalog.keys {
            let value = catalog[key]!
            let keyHash = String.encodeHex(HashAlgorithm.SHA3_256.hash(key.utf8))
            let tempPathStr = "catalog".concat(keyHash)
            let tempPublicPath = PublicPath(identifier: tempPathStr)!

            account.link<&{MetadataViews.ResolverCollection}>(
                tempPublicPath,
                target: value.collectionData.storagePath
            )

            let collectionCap = account.getCapability<&AnyResource{MetadataViews.ResolverCollection}>(tempPublicPath)

            if !collectionCap.check() {
                continue
            }

            let views = NFTRetrieval.getNFTViewsFromCap(collectionIdentifier: key, collectionCap: collectionCap)
            let items: [NFT] = []

            for view in views {
                let displayView = view.display
                let externalURLView = view.externalURL
                let collectionDataView = view.collectionData
                let collectionDisplayView = view.collectionDisplay
                let royaltyView = view.royalties

                if (displayView == nil || externalURLView == nil || collectionDataView == nil || collectionDisplayView == nil || royaltyView == nil) {
                    // Bad NFT. Skipping....
                    continue
                }

                items.append(
                    NFT(
                        id: view.id,
                        name: displayView!.name,
                        description: displayView!.description,
                        thumbnail: displayView!.thumbnail.uri(),
                        externalURL: externalURLView!.url,
                        storagePath: collectionDataView!.storagePath,
                        publicPath: collectionDataView!.publicPath,
                        privatePath: collectionDataView!.providerPath,
                        publicLinkedType: collectionDataView!.publicLinkedType,
                        privateLinkedType: collectionDataView!.providerLinkedType,
                        collectionName: collectionDisplayView!.name,
                        collectionDescription: collectionDisplayView!.description,
                        collectionSquareImage: collectionDisplayView!.squareImage.file.uri(),
                        collectionBannerImage: collectionDisplayView!.bannerImage.file.uri(),
                        collectionExternalURL: collectionDisplayView!.externalURL.url,
                        royalties: royaltyView!.getRoyalties()
                    )
                )
            }

            data[key] = items
        }

        return data
    }
"""
    private func getAccountNFTs(result: FlutterResult, call: FlutterMethodCall) async {
        do {
            let args = call.arguments as! Dictionary<String, Any>
            let addr = args["address"] as! String
            
            let response = try await fcl.query {
                cadence {
                    getAccountNFTsScript
                }
                arguments{
                    [.address(Flow.Address(hex: addr))]
                }
            }.decode()
            result(response)
        }catch {
            print(error)
            result(error.localizedDescription)
        }
    }
    
    
    /**
     Method to verify if user already has Affiliate NFT
     */
    
    var getAccountBeyondAffiliateScript = """
     import Beyond from 0xBeyond
     import NonFungibleToken from 0xCustomNonFungibleToken
     import MetadataViews from 0xMetadataViews
     
      pub fun main(address: Address): Beyond.Affiliate? {
              let beyondCollectionPublicCap = getAccount(address).getCapability<&Beyond.Collection{NonFungibleToken.CollectionPublic, Beyond.BeyondNFTCollectionPublic}>(Beyond.CollectionPublicPath)
              let beyondCollection = beyondCollectionPublicCap.borrow()
              if(beyondCollection == nil) {
                  return nil
              }
              
              let ids = beyondCollection?.getIDs()
              if(ids == nil || ids?.length == 0){
                  return nil
              }
          
          
              return Beyond.getAffiliateByAddress(address: address)
          
     }
 """
    private func getAccountBeyondAffiliate(result: FlutterResult, call: FlutterMethodCall) async{
        do {
            let args = call.arguments as! Dictionary<String, Any>
            let addr = args["address"] as! String
            print(addr)
            let response = try await fcl.query {
                cadence {
                    getAccountBeyondAffiliateScript
                }
                arguments {
                    [.address(Flow.Address(hex: addr))]
                }
            }.decode()
            result(response)
        }catch{
            print(error)
            result(error.localizedDescription)
        }
    }
    
    
    /**
        Method to mint an Beyond Affiliate NFT
     */
    var mintBeyondNFTScript = """
    import NonFungibleToken from 0xNonFungibleToken
    import MetadataViews from 0xMetadataViews
    import FlowToken from 0xFlowToken
    import Beyond from 0xBeyond

    transaction() {

        let buyerCollection: &{NonFungibleToken.CollectionPublic}
        let mintPrice: UFix64
        let buyerPaymentVault: &FlowToken.Vault

        prepare(signer: AuthAccount) {

            self.mintPrice = 1.0

            if signer.borrow<&Beyond.Collection>(from: Beyond.CollectionStoragePath) == nil {
                signer.save(<-Beyond.createEmptyCollection(), to: Beyond.CollectionStoragePath)
            }

            if signer.getLinkTarget(Beyond.CollectionPublicPath) == nil {
                signer.link<&Beyond.Collection{Beyond.BeyondNFTCollectionPublic, NonFungibleToken.CollectionPublic}>(Beyond.CollectionPublicPath, target: Beyond.CollectionStoragePath)
            }

            self.buyerCollection = signer.borrow<&Beyond.Collection{NonFungibleToken.CollectionPublic}>(
                from: Beyond.CollectionStoragePath
            ) ?? panic("Cannot borrow Beyond collection receiver capability from signer")

            self.buyerPaymentVault = signer.borrow<&FlowToken.Vault>(from: /storage/flowTokenVault)
                ?? panic("Can't borrow the Flow Token vault for the main payment from acct storage")
        }

        execute {
            Beyond.mintNFT(
                recipient: self.buyerCollection,
                payment: <- self.buyerPaymentVault.withdraw(amount: self.mintPrice)
            )
        }
    }
     
 """
    private func mintBeyondNFT(result: FlutterResult) async {
        do {
            let txId = try await fcl.mutate(cadence: mintBeyondNFTScript)
            let txSealed = try await txId.onceSealed()
            
            result(["txId": txId.hex, "status": try txSealed.status.json(), "errorMessage": txSealed.errorMessage])
        }catch{
            print(error)
            result(error.localizedDescription)
        }
    }
    
}
