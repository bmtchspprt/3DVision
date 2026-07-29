# Dialog XAML acceptance checklist

Use against decompiled XAML + screenshots. Mark done when title, groups, control counts, and button row match.

## Device

| Dialog | Title | Key controls | Buttons | Source |
|--------|-------|--------------|---------|--------|
| Output Settings | Output Settings... | Material Name; 7 calc radios; Measurement Units (Distance/Temp + Mass/Volume nested) | Edit Table... / OK / Close | OutputSettingsNewUC |
| Output Current | Output Current Settings | Tabs Output Current / Fault Current / HART Command #3 | Upload / Close | OutputCurrentMainUC |
| Current Simulation | Current Simulation Settings | Selection; mode combo; value; Apply/Stop/Close | (in body) | CurrentOutputSetUC |
| False Echo | False Echoes Mapping | Selection; Action/From/To/Threshold; beam checks | Reset Mapping / Close | FalseEchoMapWin |
| Devices Activation | Devices Activation | Tree + Reset / Firmware / Com. Quality tabs | Close | DeviceActivationWin |
| Advanced Parameters | Advanced Parameters | Vessel/Advanced/Advanced-Cont/Beams + Extra Params1/2/Poll; real AdvParams field names | Download All / Upload all… / Summary / Upload displayed / Close | AdvParamsWindow |
| Config Wizard | Configuration Wizard | Vessel step: General + Top/Center/Bottom shapes with JPG previews | &lt; Back / Next &gt; / Cancel | WizardWindowDevice / WizardStepVessel |
| Echo Curve | Echo Curve | Toolbar; All Beams; On Line/Downloaded/Noise | Close | WindowBeams |

## File / Edit / Tools

| Dialog | Title | Notes | Source |
|--------|-------|-------|--------|
| Edit Project | Edit Project | Site/vessel/scanner tree; Summary/Save As/Open | EditProjectWin |
| Add / Rename | Edit Base Properties | Name + Description | WndEditName |
| Vessel graphic figures | Vessel graphic figures | Type/Content/XYZ grid; Add/Edit/Delete… | FeaturesWindow |
| Server Connection | Server Connection | Name/Address/Port; Connect/Exit | WindowConnectToServer |
| Login (Switch User) | Login | User/Password/Type; OK/Cancel | WindowUserLogin |
| Reports Wizard | Reports Wizard | 7 steps; Settings / Previous / Next / Cancel | ReportWizardWindow |
| Hardware Inventory | Hardware Inventory | Full HW columns; Refresh/Close | ServersTableInventoryWindow |
| Measurement Summary | Measurement Summary | Volume%/Mass columns | ServersTable (meas mode) |
| Event Log Viewer | Event Log Viewer | Left filter + grid + detail | EventLogWindow |
| Material Configuration | Material Configuration | Available Materials list + Add/Edit | MaterialManagWindow |
| Client / Server Options | Client Settings / Server Configuration | GroupView radio nav | GroupView + Config UCs |
