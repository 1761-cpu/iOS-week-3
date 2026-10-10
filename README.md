# App Student Management

Hi Ms. Phượng, my name is **Võ Châu Anh**. This is my submission for building the App Student Management.

This is my second version of the Class Management System app, since I already did it in Week 2 
(reference: https://github.com/1761-cpu/iOS-week-2.git).

For this version, the main changes are:

- **Different background** from the first version.

- **"Bottom GPA" feature** added to show only the student with the 
 lowest GPA.

- **Refactored sort logic**: Switched from the older `.sorted { $0.GPA < $1.GPA }` to the more
  modern `.sorted(using: KeyPathComparator(\.GPA, order: .forward / .reverse))`. 

---

### Screenshots
Below are the screenshots showing its UI and features.

`Main View/ContentView`

<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-10-10 at 18 33 30" src="https://github.com/user-attachments/assets/eb909a17-de90-4afa-ba01-5d5f7b96d051" />

***
`Bottom GPA`

<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-10-10 at 18 33 42" src="https://github.com/user-attachments/assets/8bdd3b9d-e14a-49eb-acfb-383a60d6f996" />

***
`Add View`

<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-10-10 at 18 34 32" src="https://github.com/user-attachments/assets/2be979a8-db12-430d-b825-5f4702584db5" />

***
`Edit View`

<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-10-10 at 18 35 06" src="https://github.com/user-attachments/assets/54bf6844-0428-4477-8481-fe69fc3fe096" />

***
`Remove Feature`
 
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-10-10 at 18 35 26" src="https://github.com/user-attachments/assets/38357f5f-96af-40f5-8277-adee291f61be" />
