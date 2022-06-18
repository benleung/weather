# Purpose of app
Design and Implement an app as a long term project

# Technology used
- CoreLocation
- SwiftUI
- Storyboard
- WidgetKit

# Developer's Build environment
- xcode 13.1, macOS BigSur 11.6, intel mac
- build target for main app: `weather`
- build target for widget: `weatherwidget`

Note: There are occasions that widget doesn't get location data properly in simulator. In that case, try to use a different simulator, and do not forget to configure to simulate location.

# Screenshots
![picture 1](images/e8f404a41c2085cd8846801ea8a9d14df2b30021f50bd2613244e42e7c2356ee.png)  
![picture 2](images/dd06d8c6837dd92a863fd91ef4599774dadb87766e2a3bb1f879b71aefc691dc.png)  
![picture 3](images/ca1c169ef6ed806d37563dbf9127faaf8e0ff4ef2cc79827b0f3abcd46e06be0.png)  
![picture 4](images/95685854f07e30a93cb0bc1af86e2ebc42c794676f6b53ca8f054fd85bb2eb94.png)  
![picture 5](images/9a5d1227ceb658cdd4336b5117949c4577c7d320e2b99b25f898bc749262efb3.png)  

# Architecture explaination
### Widget (weatherwidget)
Layered Architecture
1. Presentation Layer (Views)
2. Domain Layer (DTO)
3. Data Layer (Request, Repository, Entity)
4. Infrastructure Layer (FileStorage, APIRequestProtocol)

Note:
- Presentation layer can be further divided with View and ViewModel to improve understandable, flexible, and maintainable. This demo app is simplified for that part, but can be easily modified when future requirement is decided.
- classes like APIRequestProtocol, APIError is highly minimized for simplicity. In work environment, library like APIKit, Alamofire would be introduced for API handling cababilities.

### Main App (weather)
Note:
- Requirement for main app is very simple (without data handling) in main app, and hence a simple View-Controller pattern is used here for time and simplicity reason. If given more time, it can be further architected with MVP, MVVM to improve understandable, flexible, and maintainable. 
- Each screen with design is seperated by different storyboard for simplicity reason
- LargeWidgetVC, MediumWidget, SmallWidget is intentionally created seperately for extensibility on widget design change (which likely happens)

# Assumption on Requirement, and further improvement
- Widget would use actual current location, while main app use mock data (assuming that use case of main app is to customize appearance and change background image)

### Other Assumption
- Requirement states that widget should be updated every 1 minute, but due to os limitation of widget specification, location and weather data might be delayed as long as 15 minutes

### Edge Cases
- App unauthenticated or immediately after installing
![picture 1](images/11a1e69e05af1eb1c3fefe1d35ac8d672e88e45651e86d5b271397a5090c19dd.png)  

- Address of location is unidentified
![picture 2](images/67f7c3d38090e9ca932a84f5807f66be0a465b2cfa58d38e1e80269757a70046.png)  

- Widget would keep unupdated if API request fails

### Improvement Suggestion on requirement
- (main app) loading speed of opening gallery is slow, a spinning activity indicator should be displayed
- (main app) a view on main app displaying instruction to prompt users to authorize location, if not authorized yet
- (widget) a different design of view for api error might be required

# Remarks: about Test Codes
- `struct weatherwidget_Previews: PreviewProvider` has covered different patterns for UIs
- test codes on infra.framework is in target `infraTests`
- test codes on DTO, Entity would be great if given enough time.
