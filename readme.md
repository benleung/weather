# Purpose of app


# Architecture explaination
### Widget (weatherwidget)
Layered Architecture
1. Presentation Layer (Views)
2. Domain Layer (DTO)
3. Data Layer (Request, Repository, Entity)
4. Infrastructure Layer (FileStorage, APIRequestProtocol)

### Main App (weather)
Presentation layer can be further architected with MVP, MVVM to improve understandable, flexible, and maintainable. 


- Each screen with design is seperated by different storyboard
- LargeWidgetVC, MediumWidget, SmallWidget is intentionally created seperately instead of generalization for extensibility
- only one web API adress is used in this app at this moment, so the architecture is simplified. If there are multiple api address in future, APIClient is required to be implemented. APIKit
  - Error Reason Division
- storyboard: 

# Things to improve (if more time is given)

# Notes on running the app
- 

# Assumption on Requirement (or things to confirm with product manager in working scenarios)
- Widget would use actual current location, while main app use mock data (assuming that use case of main app is to customize appearance and change background image)
- error handling
- loading speed of opening gallery
- Immediately after app installation
# Demo
