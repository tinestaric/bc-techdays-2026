// Sample AL extension — BC TechDays 2026 Workshop
// Used as the documentation subject (M1–M5 concept demos) and M5 tooltip target.
//
// M5 EXERCISE TARGET: Some page controls deliberately have no ToolTip property.
// In BC, tooltips can be set both on the table field (inherited) and overridden
// on the page control. Fields 4–7 have no tooltip on the table either —
// this page is where the background agent should add them.

page 50100 "Workshop Feedback Card"
{
    PageType = Card;
    Caption = 'Workshop Feedback Card';
    SourceTable = "Workshop Feedback";
    UsageCategory = Documents;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for this feedback record.';
                }
                field("Participant Name"; Rec."Participant Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the full name of the workshop participant.';
                }
                field("Feedback Date"; Rec."Feedback Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date on which the feedback was collected.';
                }
                field(Session; Rec.Session)
                {
                    ApplicationArea = All;
                    // No ToolTip — M5 background agent adds this
                }
            }
            group(Assessment)
            {
                Caption = 'Assessment';

                field(Rating; Rec.Rating)
                {
                    ApplicationArea = All;
                    // No ToolTip — M5 background agent adds this
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    // No ToolTip — M5 background agent adds this
                }
            }
            group(FollowUp)
            {
                Caption = 'Follow-up';

                field("Would Recommend"; Rec."Would Recommend")
                {
                    ApplicationArea = All;
                    // No ToolTip — M5 background agent adds this
                }
                field("Follow Up Required"; Rec."Follow Up Required")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether a follow-up action is required after reviewing this feedback.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(MarkFollowUp)
            {
                Caption = 'Mark for Follow-Up';
                ApplicationArea = All;
                Image = Reminder;
                ToolTip = 'Marks this feedback record as requiring a follow-up action.';

                trigger OnAction()
                begin
                    Rec."Follow Up Required" := true;
                    Rec.Modify(true);
                end;
            }
        }
    }
}
