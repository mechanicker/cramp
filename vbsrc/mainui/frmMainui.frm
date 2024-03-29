VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form frmMainui 
   Caption         =   "CRAMP - Scenario"
   ClientHeight    =   8505
   ClientLeft      =   5340
   ClientTop       =   3075
   ClientWidth     =   9075
   Icon            =   "frmMainui.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8505
   ScaleWidth      =   9075
   Begin VB.Frame fraMainUI 
      Height          =   6900
      Index           =   3
      Left            =   -6480
      TabIndex        =   63
      Top             =   7800
      Visible         =   0   'False
      Width           =   7695
      Begin VB.Frame frmSettings 
         Caption         =   "CRAMP Variables"
         Height          =   2985
         Left            =   600
         TabIndex        =   64
         Top             =   480
         Width           =   6700
         Begin VB.CommandButton cmdEdit 
            Caption         =   "&Edit"
            Height          =   375
            Left            =   2760
            TabIndex        =   65
            Top             =   2400
            Width           =   1095
         End
         Begin MSComctlLib.ListView lvwVariables 
            Height          =   1935
            Left            =   360
            TabIndex        =   4
            Top             =   360
            Width           =   5925
            _ExtentX        =   10451
            _ExtentY        =   3413
            LabelEdit       =   1
            Sorted          =   -1  'True
            LabelWrap       =   -1  'True
            HideSelection   =   0   'False
            FullRowSelect   =   -1  'True
            _Version        =   393217
            ForeColor       =   -2147483640
            BackColor       =   -2147483643
            BorderStyle     =   1
            Appearance      =   1
            NumItems        =   0
         End
      End
   End
   Begin VB.Frame fraMainUI 
      Height          =   6900
      Index           =   2
      Left            =   -3960
      TabIndex        =   57
      Top             =   8040
      Visible         =   0   'False
      Width           =   7695
      Begin VB.Frame frmList 
         Height          =   4215
         Left            =   360
         TabIndex        =   58
         Top             =   480
         Width           =   7095
         Begin VB.CommandButton cmdRunList 
            Caption         =   "Run"
            Height          =   495
            Left            =   5520
            TabIndex        =   62
            Top             =   2160
            Width           =   1095
         End
         Begin VB.CommandButton cmdRemoveList 
            Caption         =   "Remove"
            Height          =   495
            Left            =   5520
            TabIndex        =   61
            Top             =   1320
            Width           =   1095
         End
         Begin VB.CommandButton cmdAddList 
            Caption         =   "Add"
            Height          =   495
            Left            =   5520
            TabIndex        =   60
            Top             =   480
            Width           =   1095
         End
         Begin VB.ListBox lstScenarios 
            Height          =   3570
            Left            =   360
            TabIndex        =   59
            Top             =   360
            Width           =   4695
         End
      End
      Begin MSComDlg.CommonDialog dlgList 
         Left            =   6840
         Top             =   6120
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
   End
   Begin VB.Frame fraMainUI 
      Height          =   7308
      Index           =   1
      Left            =   1080
      TabIndex        =   2
      Top             =   720
      Visible         =   0   'False
      Width           =   7450
      Begin MSComctlLib.ImageList SortIconImageList 
         Left            =   6840
         Top             =   7080
         _ExtentX        =   794
         _ExtentY        =   794
         BackColor       =   -2147483643
         ImageWidth      =   8
         ImageHeight     =   7
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   2
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMainui.frx":0CCA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmMainui.frx":0D9C
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin VB.Frame Frame4 
         Caption         =   "Profiling"
         Height          =   972
         Left            =   120
         TabIndex        =   33
         Top             =   240
         Width           =   7215
         Begin VB.CommandButton stopCommand 
            Caption         =   "Stop"
            Height          =   288
            Left            =   4440
            TabIndex        =   40
            Top             =   480
            Width           =   972
         End
         Begin VB.CommandButton flushproCommand 
            Caption         =   "Flush"
            Height          =   288
            Left            =   5640
            TabIndex        =   39
            Top             =   480
            Width           =   972
         End
         Begin VB.CommandButton startCommand 
            Caption         =   "Start"
            Height          =   288
            Left            =   3240
            TabIndex        =   38
            Top             =   480
            Width           =   972
         End
         Begin VB.TextBox pidText 
            Height          =   288
            Left            =   2040
            TabIndex        =   36
            Top             =   480
            Width           =   972
         End
         Begin VB.TextBox compnameText 
            Height          =   288
            Left            =   120
            TabIndex        =   34
            Top             =   480
            Width           =   1692
         End
         Begin VB.Label procidLabel 
            Caption         =   "Pid"
            Height          =   252
            Left            =   2040
            TabIndex        =   37
            Top             =   240
            Width           =   972
         End
         Begin VB.Label compnameLabel 
            Caption         =   "Profile Host"
            Height          =   252
            Left            =   120
            TabIndex        =   35
            Top             =   240
            Width           =   1692
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Result"
         Height          =   3972
         Left            =   120
         TabIndex        =   30
         Top             =   3120
         Width           =   7215
         Begin VB.CommandButton preCommand 
            Caption         =   "Previous"
            Height          =   288
            Left            =   1200
            TabIndex        =   46
            Top             =   240
            Width           =   972
         End
         Begin VB.CommandButton nextCommand 
            Caption         =   "Next"
            Height          =   288
            Left            =   3751
            TabIndex        =   45
            Top             =   240
            Width           =   972
         End
         Begin VB.TextBox listitemText 
            Height          =   288
            Left            =   5760
            TabIndex        =   44
            Top             =   240
            Width           =   951
         End
         Begin MSComctlLib.ListView queryLV 
            Height          =   3135
            Left            =   120
            TabIndex        =   31
            Top             =   720
            Width           =   6975
            _ExtentX        =   12303
            _ExtentY        =   5530
            LabelEdit       =   1
            LabelWrap       =   -1  'True
            HideSelection   =   -1  'True
            AllowReorder    =   -1  'True
            FullRowSelect   =   -1  'True
            _Version        =   393217
            ForeColor       =   -2147483640
            BackColor       =   -2147483643
            BorderStyle     =   1
            Appearance      =   1
            NumItems        =   0
         End
         Begin VB.Label maxLabel 
            AutoSize        =   -1  'True
            Height          =   192
            Left            =   3050
            TabIndex        =   50
            Top             =   480
            Width           =   36
         End
         Begin VB.Label deshLabel 
            Alignment       =   2  'Center
            AutoSize        =   -1  'True
            Caption         =   "-"
            Height          =   192
            Left            =   2916
            TabIndex        =   49
            Top             =   480
            Width           =   60
         End
         Begin VB.Label miniLabel 
            Alignment       =   1  'Right Justify
            AutoSize        =   -1  'True
            Height          =   192
            Left            =   2800
            TabIndex        =   48
            Top             =   480
            Width           =   51
         End
         Begin VB.Label totalLabel 
            Alignment       =   2  'Center
            Height          =   252
            Left            =   120
            TabIndex        =   47
            Top             =   480
            Width           =   852
         End
         Begin VB.Label itemrangeLabel 
            Caption         =   "Item range : "
            Height          =   252
            Left            =   4920
            TabIndex        =   43
            Top             =   240
            Width           =   852
         End
         Begin VB.Label totLabel 
            Caption         =   "Total items:"
            Height          =   204
            Left            =   120
            TabIndex        =   42
            Top             =   240
            Width           =   852
         End
         Begin VB.Label rngLabel 
            Caption         =   "Visible items:"
            Height          =   204
            Left            =   2520
            TabIndex        =   41
            Top             =   240
            Width           =   972
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Query"
         Height          =   700
         Left            =   120
         TabIndex        =   27
         Top             =   2400
         Width           =   7215
         Begin VB.CommandButton backCommand 
            Caption         =   "Back"
            Height          =   288
            Left            =   6120
            TabIndex        =   56
            Top             =   240
            Width           =   972
         End
         Begin VB.CommandButton runCommand 
            Caption         =   "Init"
            Height          =   288
            Left            =   5040
            TabIndex        =   32
            Top             =   240
            Width           =   972
         End
         Begin VB.CommandButton queryCommand 
            Caption         =   "Run"
            Enabled         =   0   'False
            Height          =   288
            Left            =   3960
            TabIndex        =   29
            Top             =   240
            Width           =   972
         End
         Begin VB.TextBox queryText 
            Enabled         =   0   'False
            Height          =   288
            Left            =   120
            TabIndex        =   28
            Top             =   240
            Width           =   3732
         End
      End
      Begin VB.Frame Frame1 
         Caption         =   "Query Option"
         Height          =   972
         Left            =   120
         TabIndex        =   14
         Top             =   1320
         Width           =   7215
         Begin VB.ComboBox tableCombo 
            Height          =   315
            Left            =   2520
            Style           =   2  'Dropdown List
            TabIndex        =   54
            Top             =   840
            Width           =   972
         End
         Begin VB.ComboBox actionCombo 
            Height          =   315
            Left            =   120
            Style           =   2  'Dropdown List
            TabIndex        =   52
            Top             =   840
            Width           =   972
         End
         Begin VB.TextBox addressText 
            Enabled         =   0   'False
            Height          =   288
            Left            =   4680
            TabIndex        =   51
            Top             =   480
            Width           =   1092
         End
         Begin VB.CheckBox appendCheck 
            Caption         =   "Append"
            Height          =   312
            Left            =   6840
            TabIndex        =   21
            Top             =   480
            Width           =   852
         End
         Begin VB.TextBox limitText 
            Height          =   288
            Left            =   5880
            TabIndex        =   19
            Text            =   "10"
            Top             =   480
            Width           =   852
         End
         Begin VB.ComboBox rtCombo 
            Height          =   288
            Left            =   3600
            Style           =   2  'Dropdown List
            TabIndex        =   18
            Top             =   480
            Width           =   972
         End
         Begin VB.ComboBox threadCombo 
            Height          =   288
            Left            =   2520
            Style           =   2  'Dropdown List
            TabIndex        =   17
            Top             =   480
            Width           =   972
         End
         Begin VB.ComboBox staCombo 
            Height          =   288
            Left            =   1200
            Style           =   2  'Dropdown List
            TabIndex        =   16
            Top             =   480
            Width           =   1212
         End
         Begin VB.ComboBox pidCombo 
            Height          =   288
            Left            =   120
            Style           =   2  'Dropdown List
            TabIndex        =   15
            Top             =   480
            Width           =   972
         End
         Begin VB.Label tableLabel 
            Caption         =   "Table"
            Height          =   255
            Left            =   3600
            TabIndex        =   55
            Top             =   840
            Width           =   975
         End
         Begin VB.Label actionLabel 
            Caption         =   "Action"
            Height          =   255
            Left            =   1200
            TabIndex        =   53
            Top             =   840
            Width           =   975
         End
         Begin VB.Label limitLabel 
            Caption         =   "Limit"
            Height          =   252
            Left            =   5880
            TabIndex        =   26
            Top             =   240
            Width           =   852
         End
         Begin VB.Label addLabel 
            Caption         =   "Address"
            Height          =   252
            Left            =   4680
            TabIndex        =   25
            Top             =   240
            Width           =   1092
         End
         Begin VB.Label rtLabel 
            Caption         =   "Type"
            Height          =   252
            Left            =   3600
            TabIndex        =   24
            Top             =   240
            Width           =   972
         End
         Begin VB.Label threadLabel 
            Caption         =   "Thread"
            Height          =   252
            Left            =   2520
            TabIndex        =   23
            Top             =   240
            Width           =   972
         End
         Begin VB.Label selLabel 
            Caption         =   "Selection"
            Height          =   252
            Left            =   1200
            TabIndex        =   22
            Top             =   240
            Width           =   1212
         End
         Begin VB.Label pidLabel 
            Caption         =   "Pid"
            Height          =   252
            Left            =   120
            TabIndex        =   20
            Top             =   240
            Width           =   972
         End
      End
      Begin VB.Label perlLabel 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "perltext"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   360
         Left            =   3120
         TabIndex        =   66
         Top             =   7080
         Visible         =   0   'False
         Width           =   1065
      End
   End
   Begin VB.Frame fraMainUI 
      Height          =   6900
      Index           =   0
      Left            =   8160
      TabIndex        =   1
      Top             =   -6000
      Width           =   7450
      Begin VB.ComboBox cboIdRef 
         Height          =   315
         Left            =   6000
         TabIndex        =   13
         Top             =   4920
         Width           =   1215
      End
      Begin VB.CommandButton cmdBrowse 
         Caption         =   "..."
         Height          =   255
         Left            =   6120
         TabIndex        =   12
         Top             =   6360
         Visible         =   0   'False
         Width           =   255
      End
      Begin VB.TextBox txtInput 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   6000
         TabIndex        =   11
         Top             =   5880
         Visible         =   0   'False
         Width           =   1215
      End
      Begin VB.ComboBox cboTrueFalse 
         Height          =   315
         ItemData        =   "frmMainui.frx":0E6E
         Left            =   6000
         List            =   "frmMainui.frx":0E78
         TabIndex        =   10
         Text            =   "TRUE"
         Top             =   5400
         Visible         =   0   'False
         Width           =   1215
      End
      Begin VB.CommandButton cmdRun 
         Caption         =   "&Run"
         Height          =   495
         Left            =   6000
         TabIndex        =   9
         Top             =   2520
         Width           =   1215
      End
      Begin VB.CommandButton cmdDelete 
         Caption         =   "&Delete"
         Height          =   495
         Left            =   6000
         TabIndex        =   8
         Top             =   1800
         Width           =   1215
      End
      Begin VB.CommandButton cmdAddTc 
         Caption         =   "Add &Testcase"
         Height          =   495
         Left            =   6000
         TabIndex        =   7
         Top             =   1080
         Width           =   1215
      End
      Begin VB.CommandButton cmdAddGroup 
         Caption         =   "Add &Group"
         Height          =   495
         Left            =   6000
         TabIndex        =   6
         Top             =   360
         Width           =   1215
      End
      Begin MSComDlg.CommonDialog dlgSelect 
         Left            =   6720
         Top             =   6240
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin MSComctlLib.ListView lvwAttributes 
         Height          =   2300
         Left            =   240
         TabIndex        =   5
         Top             =   4320
         Width           =   5500
         _ExtentX        =   9710
         _ExtentY        =   4048
         LabelWrap       =   -1  'True
         HideSelection   =   0   'False
         FullRowSelect   =   -1  'True
         GridLines       =   -1  'True
         _Version        =   393217
         ForeColor       =   -2147483640
         BackColor       =   -2147483643
         BorderStyle     =   1
         Appearance      =   1
         NumItems        =   0
      End
      Begin MSComctlLib.TreeView tvwNodes 
         Height          =   3504
         Left            =   240
         TabIndex        =   3
         Top             =   480
         Width           =   5496
         _ExtentX        =   9710
         _ExtentY        =   6165
         _Version        =   393217
         HideSelection   =   0   'False
         LabelEdit       =   1
         Style           =   7
         Appearance      =   1
         OLEDragMode     =   1
         OLEDropMode     =   1
      End
   End
   Begin MSComctlLib.TabStrip tspMainUI 
      Height          =   8055
      Left            =   600
      TabIndex        =   0
      Top             =   240
      Width           =   8415
      _ExtentX        =   14843
      _ExtentY        =   14208
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   3
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Engine"
            Key             =   "tspEngine"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Profiler"
            Key             =   "tspProfiler"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab3 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Settings"
            Key             =   "tspSettings"
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
   Begin VB.Menu mnuFile 
      Caption         =   " &File"
      Begin VB.Menu mnuNew 
         Caption         =   "&New"
         Shortcut        =   ^N
      End
      Begin VB.Menu mnuOpen 
         Caption         =   "&Open"
         Shortcut        =   ^O
      End
      Begin VB.Menu mnuSpace0 
         Caption         =   "-"
      End
      Begin VB.Menu mnuNewList 
         Caption         =   "N&ew Scenario List"
         Shortcut        =   ^E
      End
      Begin VB.Menu mnuOpenList 
         Caption         =   "Open Scenario &List"
         Shortcut        =   ^L
      End
      Begin VB.Menu mnuSpace1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSave 
         Caption         =   "&Save"
         Shortcut        =   ^S
      End
      Begin VB.Menu mnuSaveAs 
         Caption         =   "Save &As.."
         Shortcut        =   ^A
      End
      Begin VB.Menu mnuSpace2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuMRU 
         Caption         =   ""
         Index           =   0
         Visible         =   0   'False
      End
      Begin VB.Menu mnuMRU 
         Caption         =   ""
         Index           =   1
         Visible         =   0   'False
      End
      Begin VB.Menu mnuMRU 
         Caption         =   ""
         Index           =   2
         Visible         =   0   'False
      End
      Begin VB.Menu mnuMRU 
         Caption         =   ""
         Index           =   3
         Visible         =   0   'False
      End
      Begin VB.Menu mnuSpace3 
         Caption         =   "-"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuExit 
         Caption         =   "E&xit"
         Shortcut        =   ^X
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "&Help"
   End
   Begin VB.Menu mnuLVRigCL 
      Caption         =   "&LVRightCL"
      Visible         =   0   'False
      Begin VB.Menu manuHideShow 
         Caption         =   "HideShowHeaders"
      End
      Begin VB.Menu manuDevider 
         Caption         =   "-"
      End
      Begin VB.Menu manuCurrSetting 
         Caption         =   "Save setting"
      End
      Begin VB.Menu manuStack 
         Caption         =   "Stack"
      End
   End
   Begin VB.Menu mnuNodeRightCL 
      Caption         =   "NodeRightCL"
      Visible         =   0   'False
      Begin VB.Menu mnuNodeMoveUp 
         Caption         =   "Move Up"
      End
      Begin VB.Menu mnuNodeMoveDown 
         Caption         =   "Move Down"
      End
   End
End
Attribute VB_Name = "frmMainui"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim SelNode As Node
Dim Draging As Boolean

'***********************************************************
'
'***********************************************************

Option Explicit

Const SYNCHRONIZE = 1048576
Const NORMAL_PRIORITY_CLASS = &H20&
Const INFINITE = -1

Private SelectedIndex As Integer
Private imgIconNo As Integer

'***********************************************************
' Sets the IdRef field in attributes
'***********************************************************
Private Sub cboIdRef_Click()
    lvwAttributes.SelectedItem.SubItems(1) = cboIdRef.Text
    lvwAttributes.SetFocus
    cboIdRef.Visible = False
    
End Sub

'***********************************************************
' Sets the True/False in attributes
'***********************************************************
Private Sub cboTrueFalse_Click()
    
    lvwAttributes.SelectedItem.SubItems(1) = cboTrueFalse.Text
    lvwAttributes.SetFocus
    cboTrueFalse.Visible = False
    
End Sub

'***********************************************************
'Adds a group in scenario
'First update the DB with present attributes data in listview
'then adds a new node in treeview
'***********************************************************
Private Sub cmdAddGroup_Click()
    
    WriteIntoDB
    
    AddNodeInTreeView tvwNodes.SelectedItem, otGroup
    
    gSaveFlag = True
    
End Sub

'***********************************************************
'
'***********************************************************
Private Sub cmdAddList_Click()
    AddScenarioInList
End Sub

'***********************************************************
'Adds a testcase in scenario
'First update the DB with present attributes data in listview
'then adds a new node in treeview
'***********************************************************
Private Sub cmdAddTc_Click()
    
    WriteIntoDB
    
    AddNodeInTreeView tvwNodes.SelectedItem, otTestcase
    
    gSaveFlag = True
    
End Sub

'***********************************************************
'Sets the EXE path in the testcase attribute
'***********************************************************
Private Sub cmdBrowse_Click()
    Dim ExecPath As String
    Dim strReturnString As String
    Dim retVal As Boolean
    retVal = False
    dlgSelect.Flags = cdlOFNNoChangeDir
    dlgSelect.Filter = "EXE Files (*.exe)|*.exe"
    dlgSelect.CancelError = True
    strReturnString = ""
    
On Local Error GoTo BrowseError
    
    While retVal = False
        dlgSelect.ShowOpen
        ExecPath = dlgSelect.FileName
        
        If ExecPath <> "" Then
            retVal = GetUNCPath(ExecPath, strReturnString)
        End If
        
    Wend
    
    lvwAttributes.SelectedItem.SubItems(1) = strReturnString
    lvwAttributes.SetFocus
    cmdBrowse.Visible = False
    
    Exit Sub
    
BrowseError:
    
    lvwAttributes.SetFocus
    cmdBrowse.Visible = False
    
End Sub

'***********************************************************
'Deletes the selected node from scenario
'***********************************************************
Private Sub cmdDelete_Click()
    Dim selectedNode As Node
    Dim selectedType As ObjectType
    
    cmdDelete.SetFocus
    Set selectedNode = tvwNodes.SelectedItem
    lvwAttributes_LostFocus
    selectedType = nodeType(selectedNode)
    DeleteNode selectedNode
    DeleteRecord selectedNode
        
    gSaveFlag = True
        
End Sub

'***********************************************************
'
'***********************************************************
Private Sub cmdEdit_Click()
    
    ShowUserVar
    
End Sub

'***********************************************************
'
'***********************************************************
Private Sub cmdRemoveList_Click()
    
    Dim intListIndex As Integer
    intListIndex = lstScenarios.ListIndex
    lstScenarios.RemoveItem (intListIndex)
    cmdRemoveList.Enabled = False
    gSaveFlag = True
    
End Sub

'***********************************************************
'Runs the scenario and generates the results.
'First it saves the entire scenario and then runs it.
'***********************************************************
Private Sub cmdRun_Click()
        
    Dim Command As String
    
    SaveFunction gCurFileName
    
    Command = gCRAMPPath & "\bin\CRAMPEngine.exe " & gCurFileName
    
    RunScenario Command
    
End Sub

'***********************************************************
'
'***********************************************************
Private Sub cmdRunList_Click()
    Dim Command As String, strPerlPath As String, strNoConsole As String
    'Better save the list again
    SaveScList gCurScListFileName
    strNoConsole = gCRAMPPath + "/bin/noconsole"
    strPerlPath = gCRAMPPath + "/TOOLS/PERL/bin/perl.exe"
    Command = strNoConsole & gstrSpace & strPerlPath & gstrSpace & gCRAMPPath & _
                "\bin\crampstaf.pl" & gstrSpace & gCurScListFileName
    
    RunScenario Command
    
End Sub

'***********************************************************
'When CRAMP application starts it does following things.
'***********************************************************
Private Sub Form_Load()
    
    CleanAndRestart
    
    InitialiseMRUFileList
    
    CreateDatabase
        
    AddNodeInTreeView , otScenario
    
    RenameFormWindow
    
    '***********************************************************
    ' My Code Starts Here
    '***********************************************************
    'descending order
    imgIconNo = lvwDescending
    'get all cramp environment variable
    GetEnvironmentVariable
    'add raw/tick
    SetRTCombo
    'set stat/thread/addr combobox
    SetSTACombo
    'set action combobox
    SetActionCB
    'set table combobox
    SetTableCB
    'move action controls
    HideShowControls (actionCombo.Text)
    'move controls
    MoveControls (staCombo.Text)

End Sub

'***********************************************************
'
'***********************************************************
Private Sub Form_Unload(Cancel As Integer)
    WriteIntoDB
    
    SaveIntoMRUFile
    
    If Not CheckSaveStatus Then
        Cancel = -1
        Exit Sub
    Else
        CleanUp 'pie added this code
    End If
    
    Set ADOXcatalog = Nothing
    If FileExists(gDatabaseName) Then
        DeleteFile gDatabaseName
    End If
    
End Sub

'***********************************************************
'
'***********************************************************
Private Sub lstScenarios_Click()
    Dim strSelection As String
    
    If lstScenarios.ListCount = 0 Then
        Exit Sub
    End If
    
    cmdRemoveList.Enabled = True
    
End Sub

'***********************************************************
'
'***********************************************************
Private Sub lstScenarios_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Button = vbRightButton Then
      PopupMenu mnuNodeRightCL
    End If
End Sub

'***********************************************************
'Sets the attributs in the listview
'***********************************************************
Private Sub lvwAttributes_Click()
    Dim CellWidth As Double
    Dim Selection As String
    Dim PX As Double
    Dim PY As Double
    Dim ExecPath As String
    
    'Hide the combo boxes and browse button
    cboTrueFalse.Visible = False
    cboIdRef.Visible = False
    cmdBrowse.Visible = False
    txtInput.Visible = False
    txtInput.Text = ""
    
    CellWidth = lvwAttributes.Width _
                - lvwAttributes.ColumnHeaders(1).Width _
                - 300
                
    PX = lvwAttributes.Left _
        + lvwAttributes.SelectedItem.Left _
        + lvwAttributes.ColumnHeaders(1).Width _
        + 75
        
    PY = lvwAttributes.Top _
        + lvwAttributes.SelectedItem.Top _
        + 50
       
    Selection = lvwAttributes.SelectedItem
    If UCase(Selection) = UCase("ExecPath") Then
        cmdBrowse.Move PX + CellWidth - 300, PY
        cmdBrowse.Visible = True
        SelectedIndex = lvwAttributes.SelectedItem.index
        
        Exit Sub
    ElseIf UCase(Selection) = UCase("IdRef") Then
        CreateIdRefList
        Dim index As Integer
        cboIdRef.Clear
        cboIdRef.Move PX, PY, CellWidth - 150
        cboIdRef.Visible = True
        cboIdRef.Text = lvwAttributes.SelectedItem.SubItems(1)
        For index = 1 To gIdRef.Count
            cboIdRef.AddItem gIdRef.Item(index)
        Next index
        cboIdRef.SetFocus
        SelectedIndex = lvwAttributes.SelectedItem.index
        
        Exit Sub
    
    End If
    
    Selection = lvwAttributes.SelectedItem.SubItems(1)
    Select Case UCase(Selection)
           
        Case "TRUE", "FALSE"
            cboTrueFalse.Move PX, PY, CellWidth - 150
            cboTrueFalse.Visible = True
            cboTrueFalse.Text = Selection
            cboTrueFalse.SetFocus
            SelectedIndex = lvwAttributes.SelectedItem.index
            
            Exit Sub
            
    End Select
      
    txtInput.Text = Selection
    txtInput.Height = lvwAttributes.SelectedItem.Height _
                      - 75
                      
    txtInput.Move PX, PY, CellWidth
    txtInput.Visible = True
    'txtInput.SelText = Selection
    txtInput.SetFocus
    SelectedIndex = lvwAttributes.SelectedItem.index
        
End Sub

'***********************************************************
'When user clicks other than listview, update the DB.
'***********************************************************
Private Sub lvwAttributes_LostFocus()
    
    If cboTrueFalse.Visible Or _
       cboIdRef.Visible Or _
       txtInput.Visible Then
       
       Exit Sub
    End If
    
    WriteIntoDB
    
End Sub

Private Sub lvwVariables_DblClick()
    ShowUserVar
End Sub

'***********************************************************
'End the CRAMP application
'***********************************************************
Private Sub mnuExit_Click()
    Dim stFrameType As ScType
    stFrameType = GetScType
    
    If Not stFrameType = stList Then
        
        WriteIntoDB
    
        SaveIntoMRUFile
        
        If Not CheckSaveStatus Then
            Exit Sub
        Else
          CleanUp 'pie added this code
        End If
    Else
        SaveIntoMRUFile
        'Add code for scenario list frame stuff
        If Not CheckScListSaveStatus Then
            Exit Sub
        End If
        
    End If
    
    Set ADOXcatalog = Nothing
    If FileExists(gDatabaseName) Then
        DeleteFile gDatabaseName
    End If
    
    End
End Sub

'***********************************************************
'
'***********************************************************
Private Sub mnuFile_Click()
    
    HideShowMenuItems
    
    Dim stFrameType As ScType
    stFrameType = GetScType
    
    If stFrameType = stFile Then
        WriteIntoDB
    End If
    
End Sub

'***********************************************************
'
'***********************************************************
Private Sub mnuHelp_Click()
    
    WriteIntoDB
    
    Dim pptPath As String
    pptPath = App.Path & "\..\docs\CRAMP.ppt"
    Dim ppt As Object
    Set ppt = CreateObject("PowerPoint.Application.9")
    ppt.Visible = True
    ppt.Presentations.Open pptPath
    ppt.ActivePresentation.SlideShowSettings.Run
    Set ppt = Nothing
    
    'LoadHelp
    
End Sub

'***********************************************************
'User has clicked on one of most recent used scenario
'First save the existing scenario if it is modified
'then open the clicked scenario
'***********************************************************
Private Sub mnuMRU_Click(index As Integer)
    
    Dim stFrameType As ScType
    stFrameType = GetScType
    If stFrameType = stList Then
        'Check for earlier scenario list operation
        If Not CheckScListSaveStatus Then
            Exit Sub
        End If
    Else
        If Not CheckSaveStatus Then
            Exit Sub
        End If
    End If
    
    Dim strSelection As String, Msg As String
    strSelection = gMRUList(0, index)
    
    If Not FileExists(strSelection) Then
        
        Msg = "ERROR: Scenario file " & Chr(13) & Chr(34) & _
              strSelection & Chr(34) & Chr(13) & _
              " does not exist"
        ShowErrorMsgbox Msg
        Exit Sub
    End If
    
    'Find whether the selection is Scenario or List
    Dim strFileExtn As String
    strFileExtn = GetFileExt(strSelection)
    
    Select Case LCase(strFileExtn)
        Case LCase("xml")
            CleanAndRestart
            CreateDatabase
            gCurScenarioName = GetFileNameWithoutExt(strSelection)
            gCurFileName = strSelection
            LoadScenario gCurFileName
            cmdRun.Enabled = True
    
        Case LCase("txt")
            ShowListFrame
            gCurScListName = GetFileNameWithoutExt(strSelection)
            gCurScListFileName = strSelection
            LoadScenarioListFrame gCurScListFileName
        Case Else
            'ERROR msg
            Msg = "ERROR: Unknown format of selected file"
            ShowErrorMsgbox Msg
            Exit Sub
    End Select
        
    mnuSave.Enabled = True
    RenameFormWindow
    UpdateMRUFileList strSelection
    gSaveFlag = False
 
End Sub

'***********************************************************
'User has clicked on New menu in File menu,
'Save the existing scenario if it is modified
'Clean and restart CRAMP application
'***********************************************************
Private Sub mnuNew_Click()
    
    Dim stFrameType As ScType
    stFrameType = GetScType
    If stFrameType = stList Then
        'Check for earlier scenario list operation
        If Not CheckScListSaveStatus Then
            Exit Sub
        End If
    Else
        If Not CheckSaveStatus Then
            Exit Sub
        End If
    End If
    
    CleanAndRestart
    RenameFormWindow
    CreateDatabase
        
    AddNodeInTreeView , otScenario
    
End Sub

'***********************************************************
'
'***********************************************************
Private Sub mnuNewList_Click()
    
    Dim stFrameType As ScType
    stFrameType = GetScType
    If stFrameType = stFile Then
        If Not CheckSaveStatus Then
            Exit Sub
        End If
    Else
        'Check for earlier scenario list operation
        If Not CheckScListSaveStatus Then
            Exit Sub
        End If
    End If
    
    ShowListFrame
    RenameFormWindow
    gSaveFlag = False
    mnuSave.Enabled = False
End Sub

'***********************************************************
'
'***********************************************************
Private Sub mnuNodeMoveDown_Click()
    Dim stFrameType As ScType
    stFrameType = GetScType
    If stFrameType = stFile Then
        MoveDownNodeSelection
    Else
        MoveDownListItem
    End If
    
End Sub

'***********************************************************
'
'***********************************************************
Private Sub mnuNodeMoveUp_Click()
    Dim stFrameType As ScType
    stFrameType = GetScType
    If stFrameType = stFile Then
        MoveUpNodeSelection
    Else
        MoveUpListItem
    End If
    
End Sub

'***********************************************************
'Opens the selected scenario file
'***********************************************************
Private Sub mnuOpen_Click()
    Dim stFrameType As ScType
    stFrameType = GetScType
    'Check for earlier scenario list operation
    If stFrameType = stList Then
        If Not CheckScListSaveStatus Then
            Exit Sub
        End If
    Else
        'Check for earlier scenario operation
        If Not CheckSaveStatus Then
            Exit Sub
        End If
    End If
    
    Dim strFileName As String
    dlgSelect.Filter = "XML Files (*.xml)|*.xml"
    dlgSelect.FileName = ""
    dlgSelect.ShowOpen
    'Set the global file name
    If dlgSelect.FileName <> "" Then
        CleanAndRestart
    
        CreateDatabase
    
        gCurScenarioName = Left(dlgSelect.FileTitle, _
                                (Len(dlgSelect.FileTitle) - 4))
        strFileName = dlgSelect.FileName
        gCurFileName = strFileName
        mnuSave.Enabled = True
        LoadScenario strFileName
        cmdRun.Enabled = True
        RenameFormWindow
        UpdateMRUFileList strFileName
        gSaveFlag = False
    End If
    
End Sub

'***********************************************************
'
'***********************************************************
Private Sub mnuOpenList_Click()
    
    Dim stFrameType As ScType
    stFrameType = GetScType
    If stFrameType = stFile Then
        If Not CheckSaveStatus Then
            Exit Sub
        End If
    Else
        'Check for earlier scenario list operation
        If Not CheckScListSaveStatus Then
            Exit Sub
        End If
    
    End If
        
    'Call the open function
    OpenScList
    
End Sub

'***********************************************************
'Save the current scenario file
'***********************************************************
Private Sub mnuSave_Click()
        
    Dim stFrameType As ScType
    stFrameType = GetScType
    
    If stFrameType = stFile Then
        SaveFunction gCurFileName
    Else
        SaveScList gCurScListFileName
    End If
    
End Sub

'***********************************************************
'Save the current scenario with new name
'***********************************************************
Private Sub mnuSaveAs_Click()
    
  Dim stFrameType As ScType
    stFrameType = GetScType
    If stFrameType = stFile Then
        If tspMainUI.SelectedItem.Caption = "Engine" Then
            FileSaveAs
        Else 'profiler
            SaveLVInfoToExcel
        End If
    Else
        ScListSaveAs
    End If
    
End Sub
'***********************************************************
'User has changed the tab strip option, set the Application
'header accordingly by calling RenameFormWindow
'***********************************************************
Private Sub tspMainUI_Click()
    Dim stFrameType As ScType
    stFrameType = GetScType
    If stFrameType = stList Then
        'Check for earlier scenario list operation
        If Not CheckScListSaveStatus Then
            Exit Sub
        End If
    Else
        If Not CheckSaveStatus Then
            Exit Sub
        End If
    End If
    
    Dim ii As Integer
    For ii = 0 To fraMainUI.Count - 1
        fraMainUI(ii).Visible = False
    Next ii
    
    Select Case LCase(tspMainUI.SelectedItem.key)
        Case LCase("tspEngine"):
            fraMainUI(0).Visible = True
            fraMainUI(tspMainUI.SelectedItem.index - 1).Move 600, 840
            mnuSave.Enabled = False
            gSaveFlag = False
            RenameFormWindow
        Case LCase("tspProfiler"):
            fraMainUI(1).Visible = True
            fraMainUI(tspMainUI.SelectedItem.index - 1).Move 600, 840
            mnuSave.Enabled = False
            gSaveFlag = False
            RenameFormWindow
        Case LCase("tspSettings"):
            fraMainUI(3).Visible = True
            fraMainUI(3).Move 600, 840
            ShowSettingsPage
            RenameFormWindow
            'mnuSave.Visible = False
            'mnuSaveAs.Visible = False
    End Select
        
End Sub

'***********************************************************
'
'***********************************************************
Private Sub tvwNodes_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Button = vbRightButton Then
      PopupMenu mnuNodeRightCL
    End If
End Sub

'***********************************************************
'
'***********************************************************
Private Sub tvwNodes_OLEDragDrop(Data As MSComctlLib.DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Dim strKey As String, strText As String
    Dim nodNew As Node, nodDragged As Node
    Dim nodType As ObjectType
    'If nothing is selected for drag, do nothing.
    If tvwNodes.SelectedItem Is Nothing Then
    Else
        'Reference the selected node as the one being dragged.
        Set nodDragged = tvwNodes.SelectedItem
        If nodDragged.index <> tvwNodes.DropHighlight.index Then
            'Set the drop target as the selected node's parent.
            nodType = nodeType(tvwNodes.DropHighlight)
            If nodType = otGroup Or nodType = otScenario Then
                Set nodDragged.Parent = tvwNodes.DropHighlight
                SetActionButtons
            Else
                Dim Msg, Style, Title, Response, MyString
                Msg = "ERROR: " & "Invalid target" & Chr(13) & _
                      "Target must be group/scenario node."
                Style = vbCritical + vbOKOnly
                Title = "CRAMP Error"
                MsgBox Msg, Style, Title
            End If
            
        End If
    End If
    'Deselect the node
    Set nodDragged = Nothing
    'Unhighlight the nodes.
    Set tvwNodes.DropHighlight = Nothing
End Sub

'***********************************************************
'
'***********************************************************
Private Sub tvwNodes_OLEDragOver(Data As MSComctlLib.DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)
    'If no node is selected, select the first node you dragged over.
    If tvwNodes.SelectedItem Is Nothing Then
        Set tvwNodes.SelectedItem = tvwNodes.HitTest(X, Y)
    End If
    'Highlight the node being dragged over as a potential drop target.
    Set tvwNodes.DropHighlight = tvwNodes.HitTest(X, Y)
End Sub

'***********************************************************
'
'***********************************************************
Private Sub tvwNodes_OLEStartDrag(Data As MSComctlLib.DataObject, AllowedEffects As Long)
    tvwNodes.SelectedItem = Nothing
End Sub

'***********************************************************
'
'***********************************************************
Private Sub tvwNodes_NodeClick(ByVal Node As MSComctlLib.Node)
    
    'Hide the combo boxes and browse button
    cmdBrowse.Visible = False
    cboTrueFalse.Visible = False
    cboIdRef.Visible = False
    
    WriteIntoDB
    
    RefreshData
    
    SetActionButtons
    
    gSaveFlag = True
    
End Sub

'***********************************************************
'
'***********************************************************
Private Sub txtInput_LostFocus()
        
    If UCase(lvwAttributes.ListItems(SelectedIndex)) = UCase("Name") Then
        If Not IsNumeric(txtInput.Text) Then
            lvwAttributes.ListItems(SelectedIndex).SubItems(1) = txtInput.Text
            'tvwNodes.SelectedItem.Text = txtInput.Text
            UpdateNodeName txtInput.Text
        End If
        
    End If
    
    If UCase(lvwAttributes.ListItems(SelectedIndex)) <> UCase("Release") And _
       UCase(lvwAttributes.ListItems(SelectedIndex)) <> UCase("Argv") Then
        If IsNumeric(txtInput.Text) Then
            lvwAttributes.ListItems(SelectedIndex).SubItems(1) = txtInput.Text
        End If
    Else
        lvwAttributes.ListItems(SelectedIndex).SubItems(1) = txtInput.Text
    End If
    
    lvwAttributes.SetFocus
    txtInput.Visible = False
    
End Sub

'***********************************************************
' My Code Starts Here
'***********************************************************

'***********************************************************
' append check box control
'***********************************************************
Private Sub appendCheck_Click()
  'set query text
  SetQueryText (staCombo.Text)
End Sub

'***********************************************************
' set integer value only
'***********************************************************
Private Sub limitText_KeyPress(KeyAscii As Integer)
  KeyAscii = ChkForDigit(KeyAscii)
End Sub
'***********************************************************
' limit text box lost focus notification
'***********************************************************
Private Sub limitText_LostFocus()
  If Not IsNumeric(limitText.Text) Then
    limitText.Text = 10
  End If
  If limitText.Text = "0" Then
    limitText.Text = 10
  End If
  'set query text
  SetQueryText (staCombo.Text)
End Sub

'***********************************************************
' set integer value only
'***********************************************************
Private Sub pidText_KeyPress(KeyAscii As Integer)
  If KeyAscii = 44 Or KeyAscii = 3 Or KeyAscii = 22 Then Exit Sub
  KeyAscii = ChkForDigit(KeyAscii)
End Sub
'***********************************************************
' set process id combo box
'***********************************************************
Private Sub pidCombo_Click()
  Dim pidHand As udtPID
  
  If UBound(pidArray) < 0 Then Exit Sub
  If pidCombo.ListIndex > UBound(pidArray) Then Exit Sub
  
  Screen.MousePointer = vbHourglass
  pidHand = pidArray(pidCombo.ListIndex)
  
  'set thread combo box
  SetValueInComboBox pidHand, Me.threadCombo
  'set query text
  SetQueryText (staCombo.Text)
  Screen.MousePointer = vbDefault
End Sub

'***********************************************************
' query command control
'***********************************************************
Private Sub queryCommand_Click()
Screen.MousePointer = vbHourglass

'while dumping do not load any thing in the LV
If Me.actionCombo.Text = "DUMP" Then
  MsgBox "Dumping of database will take time."
End If

Dim strTmp As Boolean
'run perl script
RunPerlScriptWithCP
'store query.psf file into the dictionary
strTmp = CreateDictionary
StorePreviousQuery

If Me.actionCombo.Text = "DUMP" Then
  'clean up ui
  If queryLV.ColumnHeaders.Count > 0 Then
    queryLV.ColumnHeaders.Clear
  End If
  queryLV.ListItems.Clear
  gDicCountLower = 0
  frmMainui.miniLabel.Caption = gDicCountLower
  gDicCountUpper = 0
  frmMainui.maxLabel.Caption = gDicCountUpper
  If gobjDic.Count > 0 Then
    gobjDic.removeAll
  End If
  frmMainui.totalLabel.Caption = gobjDic.Count
  Screen.MousePointer = vbDefault
  Exit Sub
End If

gDicCountLower = 0
gDicCountUpper = listitemText.Text
'set query.psf output into the listview
SetValueInListView
HideShowNextPre
'show hide col
ShowHideCol
'add-remove ADDR
AddRemAddrInSTACB
manuCurrSetting.Checked = False
If frmMainui.queryLV.ListItems.Count <> 0 Then
  frmMainui.queryLV.SetFocus
End If
Screen.MousePointer = vbDefault
End Sub

'***********************************************************
' set raw-tick combo box
'***********************************************************
Private Sub rtCombo_Click()
  'set query text
  SetQueryText (frmMainui.staCombo.Text)
End Sub
'***********************************************************
' set stat-threads-addr combo box
'***********************************************************
Private Sub staCombo_Click()
  'set query text
  SetQueryText (staCombo.Text)
  'move controls
  MoveControls (staCombo.Text)
End Sub

'***********************************************************
' set threads combo box
'***********************************************************
Private Sub threadCombo_Click()
  'set query text
  SetQueryText (frmMainui.staCombo.Text)
End Sub

'***********************************************************
' run command control
'***********************************************************
Private Sub runCommand_Click()
  Screen.MousePointer = vbHourglass
  'set process id combobox
  SetProcessIDCombo
  'clean up ui
  If queryLV.ColumnHeaders.Count > 0 Then
    queryLV.ColumnHeaders.Clear
  End If
  queryLV.ListItems.Clear
  gDicCountLower = 0
  frmMainui.miniLabel.Caption = gDicCountLower
  gDicCountUpper = 0
  frmMainui.maxLabel.Caption = gDicCountUpper
  If gobjDic.Count > 0 Then
    gobjDic.removeAll
  End If
  'add-remove ADDR
  AddRemAddrInSTACB
  frmMainui.totalLabel.Caption = gobjDic.Count
  Screen.MousePointer = vbDefault
  'disable run button when respective db file is not there
  If frmMainui.pidCombo.Text = "" Then
    Me.queryCommand.Enabled = False
  Else
    Me.queryCommand.Enabled = True
  End If
  'set query text
  SetQueryText (staCombo.Text)
End Sub

'***********************************************************
' start button click
'***********************************************************
Private Sub startCommand_Click()
  
  If compnameText.Text = "" Then
    MsgBox "ERROR :: Null computer name"
    Exit Sub
  End If
  
  If pidText.Text = "" Then
    MsgBox "ERROR :: Null pid value"
    Exit Sub
  End If
  
  'start profiling
  DoProfiling ("START")
End Sub

'***********************************************************
' stop button click
'***********************************************************
Private Sub stopCommand_Click()
  If compnameText.Text = "" Then
    MsgBox "ERROR :: Null computer name"
    Exit Sub
  End If
  
  If pidText.Text = "" Then
    MsgBox "ERROR :: Null pid value"
    Exit Sub
  End If
  
  'stop profiling
  DoProfiling ("STOP")

End Sub

'***********************************************************
' flush button click
'***********************************************************
Private Sub flushproCommand_Click()
  
  If compnameText.Text = "" Then
    MsgBox "ERROR :: Null computer name"
    Exit Sub
  End If
  
  If pidText.Text = "" Then
    MsgBox "ERROR :: Null pid value"
    Exit Sub
  End If
  
  'flush profiling
  DoProfiling ("FLUSH")
End Sub

'***********************************************************
' listview double click
'***********************************************************
Private Sub queryLV_DblClick()
  If queryLV.ColumnHeaders.Count <> 0 Then
    SetValueFromLV (staCombo.Text)
  End If
End Sub
'***********************************************************
' next button click
'***********************************************************
Private Sub nextCommand_Click()
  Screen.MousePointer = vbHourglass
  gDicCountLower = gDicCountUpper
  gDicCountUpper = gDicCountUpper + listitemText.Text
  SetValueInListView
  HideShowNextPre
  'show hide col
  ShowHideCol
  'show icon on header
  ShowSortIconInLVHeader Me.queryLV, imgIconNo
  manuCurrSetting.Checked = False
  Screen.MousePointer = vbDefault
End Sub
'***********************************************************
' previous button click
'***********************************************************
Private Sub preCommand_Click()
  Screen.MousePointer = vbHourglass
  
  If Not (gDicCountLower - listitemText.Text) < 0 Then
    gDicCountLower = gDicCountLower - listitemText.Text
    gDicCountUpper = gDicCountLower + listitemText.Text
  Else
    gDicCountUpper = gDicCountLower
    gDicCountLower = 0
  End If
  
  SetValueInListView
  HideShowNextPre
  'show hide col
  ShowHideCol
  'show icon on header
  ShowSortIconInLVHeader Me.queryLV, imgIconNo
  manuCurrSetting.Checked = False
  Screen.MousePointer = vbDefault
End Sub
'***********************************************************
' set integer value
'***********************************************************
Private Sub listitemText_KeyPress(KeyAscii As Integer)
  KeyAscii = ChkForDigit(KeyAscii)
End Sub
'***********************************************************
' listitem lost focus
'***********************************************************
Private Sub listitemText_LostFocus()
  If Not IsNumeric(listitemText.Text) Then
    listitemText.Text = 100
  End If
  If listitemText.Text > 2000 Then
    listitemText.Text = 2000
  End If
End Sub
'***********************************************************
' pop up menu when right click in the listview
'***********************************************************
Private Sub queryLV_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
  If queryLV.ColumnHeaders.Count > 0 Then
    If Button = vbRightButton Then
      PopupMenu mnuLVRigCL
    End If
  End If
End Sub
'***********************************************************
' click on the manu hide-show
'***********************************************************
Private Sub manuHideShow_Click()
  Screen.MousePointer = vbHourglass
  
  Dim X_Cord As Long
  Dim Y_cord As Long
  
  X_Cord = 0
  Y_cord = 0
  
  InitLVColHSForm
  'set check box sensitivity
  SetCHBSensitivity
  GetCurrCursorPosition X_Cord, Y_cord
  'MsgBox X_Cord & "    " & Y_cord
  frmLVColHS.Top = X_Cord
  frmLVColHS.Left = Y_cord
  
  frmLVColHS.Visible = True
  manuHideShow.Enabled = False
  'frmMainui.Enabled = False
  Screen.MousePointer = vbDefault
End Sub
'***********************************************************
' set current setting
'***********************************************************
Private Sub manuCurrSetting_Click()
  Screen.MousePointer = vbHourglass
  manuCurrSetting.Checked = True
  StoreUserSetting
  Screen.MousePointer = vbDefault
End Sub
'***********************************************************
' set stack
'***********************************************************
Private Sub manuStack_Click()
  Screen.MousePointer = vbHourglass
  GetStackForGivenPosition
  Screen.MousePointer = vbDefault
End Sub
'***********************************************************
' column header click fpr sorting
'***********************************************************
Private Sub queryLV_ColumnClick(ByVal ColumnHeader As MSComctlLib.ColumnHeader)
  
  Dim strTmp As Boolean
  DoEvents
  
  With Me.queryLV
    
    .MousePointer = ccHourglass
  
    'tie images to listview headers
    .ColumnHeaderIcons = SortIconImageList
    .SortKey = ColumnHeader.index - 1
  
    imgIconNo = GetIconNumber(imgIconNo)
  
    'sort
    RunPerlScriptWithCP ColumnHeader.index - 1, imgIconNo
    strTmp = CreateDictionary
    SetValueInListView
  
    'show icon on header
    ShowSortIconInLVHeader Me.queryLV, imgIconNo
  
    'show hide col
    ShowHideCol
  
    .Refresh
    .MousePointer = ccDefault
  
  End With
  
End Sub

'***********************************************************
' resizing the window
'***********************************************************
Private Sub Form_Resize()
  tspMainUI.Move 240, 240
  fraMainUI(0).Move 600, 840
  fraMainUI(1).Move 600, 840
  fraMainUI(2).Move 600, 840
  fraMainUI(3).Move 600, 840
  On Error Resume Next
  
  Dim l, t, w, h
  If Me.WindowState <> vbMinimized Then
    If Me.WindowState <> vbMaximized Then
      If Me.Width < 9000 Then     'prevent form getting too small in width
        Me.Width = 9000
      End If
      If Me.Height < 9000 Then    'prevent from getting too small in height
        Me.Height = 9000
      End If
    End If
        
    tspMainUI.Width = Me.Width - 550
    tspMainUI.Height = Me.Height - 1200
        
    'scenario tab page
    fraMainUI(0).Width = tspMainUI.Width - (2 * (fraMainUI(0).Left - tspMainUI.Left))
    fraMainUI(0).Height = tspMainUI.Height - (1.5 * (fraMainUI(0).Top - tspMainUI.Top))
        
    fraMainUI(2).Width = fraMainUI(0).Width
    fraMainUI(2).Height = fraMainUI(0).Height
    fraMainUI(3).Width = fraMainUI(0).Width
    fraMainUI(3).Height = fraMainUI(0).Height
    
    With Me
      'move the tree listview
      l = .tvwNodes.Left
      t = .tvwNodes.Top
      w = fraMainUI(0).Width - (3 * (tvwNodes.Left - fraMainUI(0).Left)) - cmdAddGroup.Width
      h = fraMainUI(0).Height - (3 * (fraMainUI(0).Top - tvwNodes.Top)) - lvwAttributes.Height
      .tvwNodes.Move l, t, w - 2000, h + 200
      
      'move the scenario listview
      l = .lvwAttributes.Left
      t = tvwNodes.Height - (2 * (tvwNodes.Top - fraMainUI(0).Top))
      w = fraMainUI(0).Width - (2 * (fraMainUI(0).Left - lvwAttributes.Left))
      h = .lvwAttributes.Height
      .lvwAttributes.Move l, t, w + 200, h
      
      'move push button in width
      cmdAddGroup.Left = tvwNodes.Width + 550
      cmdAddTc.Left = tvwNodes.Width + 550
      cmdDelete.Left = tvwNodes.Width + 550
      cmdRun.Left = tvwNodes.Width + 550
      
      'move push button in height
      cmdAddGroup.Top = tvwNodes.Top
      cmdAddTc.Top = cmdAddGroup.Top + (2 * cmdAddGroup.Height)
      cmdDelete.Top = cmdAddTc.Top + (2 * cmdAddTc.Height)
      cmdRun.Top = cmdDelete.Top + (2 * cmdDelete.Height)
      
      'set column header width
      If .lvwAttributes.ColumnHeaders.Count >= 2 Then
        .lvwAttributes.ColumnHeaders(2).Width = .lvwAttributes.Width - .lvwAttributes.ColumnHeaders(1).Width - 100
      End If
      
      'hide controls
      txtInput.Visible = False
      cboTrueFalse.Visible = False
      cboIdRef.Visible = False
      cmdBrowse.Visible = False
    End With
                
    'profiler tab page
    fraMainUI(1).Width = tspMainUI.Width - (2 * (fraMainUI(0).Left - tspMainUI.Left))
    fraMainUI(1).Height = tspMainUI.Height - (1.5 * (fraMainUI(0).Top - tspMainUI.Top))
    
    Frame4.Width = fraMainUI(1).Width - (((fraMainUI(1).Left - Frame4.Left) - 250))
    Frame1.Width = fraMainUI(1).Width - (((fraMainUI(1).Left - Frame1.Left) - 250))
    Frame2.Width = fraMainUI(1).Width - (((fraMainUI(1).Left - Frame2.Left) - 250))
    Frame3.Width = fraMainUI(1).Width - (((fraMainUI(1).Left - Frame3.Left) - 250))
    
    Frame3.Height = fraMainUI(1).Height - Frame4.Height - Frame1.Height _
                    - Frame2.Height - (fraMainUI(1).Top - Frame4.Top + 50)
    
    'move the profiler listview
    With Me.queryLV
      l = .Left
      t = .Top
      w = Frame3.Width - ((Frame3.Left + .Left) + 150)
      h = Frame3.Height - 850
      .Move l, t, w + 150, h
    End With
  End If
  
  Me.Refresh

End Sub

'***********************************************************
' set action combo box
'***********************************************************
Private Sub actionCombo_Click()
  HideShowControls (actionCombo.Text)
  If actionCombo.Text = "DUMP" Then
    SetQueryText (actionCombo.Text)
  Else
    SetQueryText (staCombo.Text)
  End If
End Sub
'***********************************************************
' call previous query
'***********************************************************
Private Sub backCommand_Click()
If gSPrevQuery <> "" Then
  Screen.MousePointer = vbHourglass
  Me.queryText.Text = gSPrevQuery
  'run perl script
  RunPerlScriptWithCP
  'store query.psf file into the dictionary
  Dim strTmp As Boolean
  strTmp = CreateDictionary
  StorePreviousQuery
  gDicCountLower = 0
  gDicCountUpper = listitemText.Text
  'set query.psf output into the listview
  SetValueInListView
  HideShowNextPre
  'show hide col
  ShowHideCol
  'add-remove ADDR
  AddRemAddrInSTACB
  manuCurrSetting.Checked = False
  If frmMainui.queryLV.ListItems.Count <> 0 Then
    frmMainui.queryLV.SetFocus
  End If
  frmMainui.backCommand.Enabled = False
  Screen.MousePointer = vbDefault
End If
End Sub

'***********************************************************
' table combo box
'***********************************************************
Private Sub tableCombo_Click()
  SetQueryText (actionCombo.Text)
End Sub

