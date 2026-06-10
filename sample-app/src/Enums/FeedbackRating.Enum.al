// Sample AL extension — BC TechDays 2026 Workshop
// Used as the documentation subject (M1–M5 concept demos) and M5 tooltip target.
// See docs/ for the documentation the workshop creates around this object.

enum 50100 "Workshop Feedback Rating"
{
    Extensible = true;
    Caption = 'Workshop Feedback Rating';

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Excellent)
    {
        Caption = 'Excellent';
    }
    value(2; Good)
    {
        Caption = 'Good';
    }
    value(3; Average)
    {
        Caption = 'Average';
    }
    value(4; Poor)
    {
        Caption = 'Poor';
    }
}
