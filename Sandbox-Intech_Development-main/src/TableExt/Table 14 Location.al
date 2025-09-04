tableextension 50149 LocExt extends Location
{
    fields
    {
        //T47724-NS
        field(50150; "Free Zone"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50151; "Payment Details"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50152; "Customer No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        //T47724-NE
    }

}