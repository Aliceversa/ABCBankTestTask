# ABCBankTestTask

## Overview

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
#### UIKit
<img width="384" alt="UIKit Project Structure" src="https://github.com/user-attachments/assets/bebb6672-5154-4ea1-b799-a4cbe20b1265" />

#### SwiftUI
<img width="384" alt="SwiftUI Project Structure" src="https://github.com/user-attachments/assets/f4e43e89-27ff-44f3-b736-66c7b394289a" />

## What to Improve

1. **Real API Integration** - Replace mock data with actual network service
2. **Comprehensive Testing** - Add UI tests, increase coverage
3. **Error Handling** - User-friendly error messages
4. **Performance** - Image caching
5. **Localization** - Multi-language support

## Branches

- `main` - Base branch
- `feature/uikit` - UIKit implementation (MVP)
- `feature/swiftui` - SwiftUI implementation (MVVM)

## Appearance

### UIKit
<table>
  <tr>
    <td><img width="250" alt="UIKit Main Screen" src="https://github.com/user-attachments/assets/39190931-b948-46f4-ab44-8f2a5f439fc1" /></td>
    <td><img width="250" alt="UIKit Statistics" src="https://github.com/user-attachments/assets/3abc3f08-fbdd-433b-a192-6f119f54c2af" /></td>
  </tr>
  <tr>
    <td align="center">Main Screen</td>
    <td align="center">Statistics</td>
  </tr>
</table>

### SwiftUI
<table>
  <tr>
    <td><img width="250" alt="SwiftUI Main Screen" src="https://github.com/user-attachments/assets/927d1e7c-4c4b-4697-b590-5a43d7c08112" /></td>
    <td><img width="250" alt="SwiftUI Statistics" src="https://github.com/user-attachments/assets/6991f471-7ef6-4e03-a34d-ec7cd8e4a9b8" /></td>
  </tr>
  <tr>
    <td align="center">Main Screen</td>
    <td align="center">Statistics</td>
  </tr>
</table>

---

