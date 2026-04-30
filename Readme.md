//
//  Readme.md.swift
//  notes-app_ios
//
//  Created by Erick El nino on 2026/05/01.
//
# NotesApp — SwiftUI + MVVM + URLSession + Core Data

iOS 15+ Notes app that connects to the Express/MongoDB backend.

---

## Architecture

```
Network Layer          → URLSession (no Alamofire)
Models                 → Codable structs matching the API
Core Data              → Offline cache
Repository             → Combines network + cache, single source of truth
ViewModel              → All UI state and logic (ObservableObject)
Views                  → Thin, only read state and call ViewModel methods
```

### Why each protocol?

| Protocol | Why |
|----------|-----|
| `APIRequest` | Each operation is its own type; easy to test individually |
| `NetworkService` | Swap URLSession for a mock in tests without touching the ViewModel |
                                            | `NoteRepository` | ViewModel doesn't know if data came from network or cache |
                                            
                                            ---
                                            
                                            ## Xcode Setup (step by step)
                                            
                                            ### 1. Create the Xcode project
                                            
                                            1. Open Xcode → **File > New > Project**
                                            2. Choose **App** under iOS
                                            3. Set:
                                                - Product Name: `NotesApp`
                                            - Interface: `SwiftUI`
                                            - Language: `Swift`
                                            - **Check "Use Core Data"** ← important
                                            4. Save it
                                            
                                            ### 2. Copy the source files
                                            
                                            Copy every `.swift` file from each folder into your Xcode project,
                                         maintaining the group structure (Network, Models, CoreData, Repositories, ViewModels, Views).
                                            
                                            ### 3. Set up Core Data model
                                            
                                            1. Xcode auto-creates `NotesApp.xcdatamodeld` when you checked "Use Core Data"
                                            2. Click the `.xcdatamodeld` file
                                            3. Add entity: **NoteEntity**
                                            4. Add these 4 attributes:
                                                
                                                | Attribute | Type |
                                            |-----------|------|
                                            | id | String |
                                            | note | String |
                                            | createdAt | Date |
                                            | updatedAt | Date |
                                            
                                            5. In the Data Model Inspector (right panel) set **Codegen** to `Class Definition`
                                            
                                            ### 4. Delete the auto-generated AppDelegate/ContentView boilerplate
                                            
                                            Replace `ContentView.swift` and the App file with the ones provided.
                                            
                                            ### 5. Allow HTTP (localhost)
                                            
                                            The simulator uses `localhost`, which is HTTP not HTTPS.
                                            Add this to `Info.plist`:
                                                
                                                ```xml
                                            <key>NSAppTransportSecurity</key>
                                            <dict>
                                            <key>NSAllowsArbitraryLoads</key>
                                            <true/>
                                            </dict>
                                            ```
                                            
                                            Or in Xcode: select `Info.plist` → right-click → Add Row →
                                            `App Transport Security Settings` → Add child `Allow Arbitrary Loads` = YES.
                                            
                                            ### 6. Physical device
                                            
                                            Change the base URL in `APIConstants.swift`:
                                                
                                                ```swift
                                            // Find your Mac's local IP in System Settings > Wi-Fi > Details
                                            static let baseURL = "http://192.168.x.x:3000/api"
                                            ```
                                            
                                            ---
                                            
                                            ## Features
                                            
                                            - Fetch all notes from the API
                                            - Create a note
                                            - View note detail
                                            - Edit a note
                                            - Swipe to delete
                                            - Pull to refresh
                                            - Search / filter notes
                                            - Sort: Newest, Oldest, A-Z, Z-A
                                            - Offline mode with Core Data cache
                                            - Offline banner when no connection
                                            - Dark mode (automatic, no extra code needed)
                                            - Error alerts
                                            
                                            ---
                                            
                                            ## Running the backend
                                            
                                            ```bash
                                            cd notes-app
                                            docker-compose up -d
                                            npm run seed
                                            npm run dev
                                            ```
                                            
                                            API runs at `http://localhost:3000/api/notes`
