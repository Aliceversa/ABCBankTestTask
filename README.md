# ABCBankTestTask

• Images carousel: when user swipe left or right, list content should change accordingly. The images carousel can handle any number of images.

• The list: when user scrolls up the whole page should scroll with it. The list can handle any number of items.
P.S. images and list content can be local or loaded from the internet.

• Search: Search bar should pin top when it reaches screen top. When user enter text, it should filter the labels in the list based on the user input. 

• Floating action button should show a nice bottom sheet dialog that contain a small statistic that consist of the count of items for each page and show the top 3 occurrence character in the list. i.e listOf(“apple”, “banana” , “orange”, “blueberry”) 
  ```
  List 1 (4 items)
  a = 5
  e = 4  
  r = 3
  ```

• Don’t use third party libraries

• The code will be reviewed.

•	You’ve got 3.5 hours.

•	Implement the requirements using both SwiftUI & UIKit, each implementation should be pushed to a separate git branch.

•	Once done, push your code to GitHub and share the link with us.


## Overview

iOS application demonstrating image carousel with searchable item lists, implementing both UIKit (MVP) and SwiftUI (MVVM) architectures.

**Features:**
- Image carousel with horizontal swipe navigation
- Dynamic item lists synchronized with carousel
- Sticky search bar that pins to top when scrolling
- Live search filtering
- Statistics bottom sheet showing item counts and top 3 character occurrences

## Architecture

### UIKit - MVP (Model-View-Presenter)
**Why MVP for UIKit:**
- Explicit separation of concerns with clear responsibilities
- Protocol-based communication for better testability
- Presenter acts as mediator between View and Model
- Direct method calls instead of reactive bindings
- Better suited for imperative UI updates in UIKit

### SwiftUI - MVVM (Model-View-ViewModel)
**Why MVVM for SwiftUI:**
- Natural fit with SwiftUI's declarative paradigm
- Reactive updates through @Published properties
- Less boilerplate code with automatic UI binding
- State management aligns with SwiftUI's data flow
- ObservableObject protocol integrates seamlessly

**Key Architectural Difference:**
- **MVP**: Explicit communication (presenter.method() → view.display())
- **MVVM**: Reactive bindings (@Published → automatic UI update)

## Project Structure
```
ABCBankTestTask/
├── UIKit (feature/uikit)
│   ├── Models/
│   ├── Views/
│   ├── Presenters/
│   ├── Services/
│   └── Builders/
│
├── SwiftUI (feature/swiftui)
│   ├── Models/
│   ├── Views/
│   ├── ViewModels/
│   ├── Services/
│   └── Builders/
│
└── Tests/
    ├── MainPagePresenterTests.swift
    ├── MainPageViewModelTests.swift
    └── MockPagesProviderTests.swift
```

## What Was Done

✅ Image carousel handling any number of images  
✅ List content updates when carousel page changes  
✅ Entire page scrolls together (carousel + list)  
✅ Sticky search bar with pin/unpin behavior  
✅ Search filtering for current page items  
✅ Statistics bottom sheet (item counts + top 3 characters)  
✅ No third-party libraries used  
✅ Both UIKit (MVP) and SwiftUI (MVVM) implementations  
✅ Async/await with proper task cancellation  
✅ DiffableDataSource for safe UI updates  
✅ Background statistics calculation  
✅ Unit tests for Presenters, ViewModels, and Data Providers  

## What to Improve

### High Priority
1. **Real API Integration** - Replace mock data with actual network service
2. **Comprehensive Testing** - Add UI tests, increase coverage to 80%+, snapshot tests
3. **Error Handling** - User-friendly error messages, offline support, loading states

### Medium Priority
4. **Performance** - Image caching, pagination for large lists
5. **Accessibility** - VoiceOver, Dynamic Type, proper labels
6. **Localization** - Multi-language support, RTL layouts

### Production-Ready
7. **Analytics & Monitoring** - Crash reporting, performance tracking
8. **Additional Features** - Dark mode, iPad support, pull-to-refresh

## Branches

- `main` - Base branch
- `feature/uikit` - UIKit implementation (MVP)
- `feature/swiftui` - SwiftUI implementation (MVVM)

## How to Run

1. Clone repository
2. Open `ABCBankTestTask.xcodeproj`
3. Switch to desired branch (`feature/uikit` or `feature/swiftui`)
4. Build and run (⌘R)
5. Run tests (⌘U)

## Assumptions

- Local mock data with 1-second simulated delay
- Three pages: Motorcycles, Furniture, Fruits
- Character frequency counts letters only
- Portrait orientation only
- iOS 17.0+ deployment target

## Screenshots

### UIKit
<table>
  <tr>
    <td><img src="screenshots/uikit-main.png" width="250"/></td>
    <td><img src="screenshots/uikit-stats.png" width="250"/></td>
  </tr>
</table>

### SwiftUI
<table>
  <tr>
    <td><img src="screenshots/swiftui-main.png" width="250"/></td>
    <td><img src="screenshots/swiftui-stats.png" width="250"/></td>
  </tr>
</table>

---

**Time spent**: ~3.5 hours  
**iOS**: 17.0+  
**Swift**: 5.9+
