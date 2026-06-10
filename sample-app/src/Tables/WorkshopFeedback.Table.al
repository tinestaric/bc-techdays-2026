// Sample AL extension — BC TechDays 2026 Workshop
// Used as the documentation subject (M1–M5 concept demos) and M5 tooltip target.
//
// M5 EXERCISE TARGET: Some fields deliberately have no ToolTip property.
// The background-agent task in Exercise 5.1 is:
//   "Add missing ToolTip properties to all fields in this table."
// The agent needs to identify which fields are missing tooltips and add them —
// without you watching it work.

table 50100 "Workshop Feedback"
{
    Caption = 'Workshop Feedback';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            ToolTip = 'Specifies the unique identifier for this feedback record.';
        }
        field(2; "Participant Name"; Text[100])
        {
            Caption = 'Participant Name';
            ToolTip = 'Specifies the full name of the workshop participant.';
        }
        field(3; "Feedback Date"; Date)
        {
            Caption = 'Feedback Date';
            ToolTip = 'Specifies the date on which the feedback was collected.';
        }
        field(4; Session; Text[100])
        {
            Caption = 'Session';
            // No ToolTip — M5 background agent adds this
        }
        field(5; Rating; Enum "Workshop Feedback Rating")
        {
            Caption = 'Rating';
            // No ToolTip — M5 background agent adds this
        }
        field(6; Comments; Text[250])
        {
            Caption = 'Comments';
            // No ToolTip — M5 background agent adds this
        }
        field(7; "Would Recommend"; Boolean)
        {
            Caption = 'Would Recommend';
            // No ToolTip — M5 background agent adds this
        }
        field(8; "Follow Up Required"; Boolean)
        {
            Caption = 'Follow Up Required';
            ToolTip = 'Specifies whether a follow-up action is required after reviewing this feedback.';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Participant Name", "Feedback Date", Rating) { }
    }
}
