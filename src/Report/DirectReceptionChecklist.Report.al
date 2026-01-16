report 80014 "DPG Direct Reception Checklist" // 5045314 "Direct Reception Checklist"
{
    // // @ Area Service
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA033067   12.04.12 DR DE Captions implemented
    // PA033259   22.08.12 AI Deletion of Start/Stop History in Code, update copyright and Version List
    // PA033336   14.09.12 RDLC Development
    //                        - Conversion to RDLC Format
    //                        - DataSetFieldName generated for all controls
    // PA033336   28.09.12 8746462: In RDLC: 'Mileage' control forated for dynamic display values according to regional settings.
    // PA033259   22.11.12 DR Change the variable names according to incadea styleguide
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA035597   10.02.14 GC NAV 2013 R2 Technical Upgrade
    // 
    // DAF
    // FJC05112019 05.11.2019 FLC New layout
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/DirectReceptionChecklist.rdlc';

    Caption = 'Direct Vehicle Reception-Checklist';

    dataset
    {
        dataitem("Service Header"; "Service Header")
        {
            column(Service_Header__Sell_to_Customer_Name_; "Sell-to Customer Name")
            {
            }
            column(Service_Header__License_No__; "License No.")
            {
            }
            column(GetServiceAdvisorName__Service_Advisor_No___; GetServiceAdvisorName("Service Advisor No."))
            {
            }
            column(Service_Header__Sell_to_Phone_No__; "Sell-to Phone No.")
            {
            }
            column(Service_Header_Mileage; Mileage)
            {
            }
            column(Service_Header_VIN; VIN)
            {
            }
            column(DirectReceptPictureG__Direct_Reception_Picture_; DirectReceptPictureG."Direct Reception Picture")
            {
            }
            column(Service_Header__Order_Date_; FORMAT("Order Date"))
            {
            }
            column(Direct_Vehicle_Reception_Checklist_Caption; Direct_Vehicle_Reception_Checklist_CaptionLbl)
            {
            }
            column(Service_Header__Sell_to_Customer_Name_Caption; FIELDCAPTION("Sell-to Customer Name"))
            {
            }
            column(Service_Header__License_No__Caption; FIELDCAPTION("License No."))
            {
            }
            column(Service_Advisor_Name_Caption; Service_Advisor_Name_CaptionLbl)
            {
            }
            column(Service_Header__Sell_to_Phone_No__Caption; FIELDCAPTION("Sell-to Phone No."))
            {
            }
            column(Service_Header_MileageCaption; FIELDCAPTION(Mileage))
            {
            }
            column(Service_Header_VINCaption; FIELDCAPTION(VIN))
            {
            }
            column(Interior_Caption; Interior_CaptionLbl)
            {
            }
            column(Examination_of_Exterior_Caption; Examination_of_Exterior_CaptionLbl)
            {
            }
            column(Engine_Compartment_Caption; Engine_Compartment_CaptionLbl)
            {
            }
            column(Vehicle_Hoist_Caption; Vehicle_Hoist_CaptionLbl)
            {
            }
            column(Additional_Services_Caption; Additional_Services_CaptionLbl)
            {
            }
            column(Illumination_Check_Caption; Illumination_Check_CaptionLbl)
            {
            }
            column(Dash_Board_Switches__Functional_Test_Caption; Dash_Board_Switches__Functional_Test_CaptionLbl)
            {
            }
            column(Rim_Locks__Rim_Lock_Key_Caption; Rim_Locks__Rim_Lock_Key_CaptionLbl)
            {
            }
            column(Stone_Chipping__Windshield_Headlights__Caption; Stone_Chipping__Windshield_Headlights__CaptionLbl)
            {
            }
            column(Head_Lights__adjustment_damages_dull__Caption; Head_Lights__adjustment_damages_dull__CaptionLbl)
            {
            }
            column(Wiper_Blades__front_rear__Caption; Wiper_Blades__front_rear__CaptionLbl)
            {
            }
            column(Painting_Caption; Painting_CaptionLbl)
            {
            }
            column(Bodywork_Condition__incl__Pulp_Catchers_Mirrors__Caption; Bodywork_Condition__incl__Pulp_Catchers_Mirrors__CaptionLbl)
            {
            }
            column(Visual_Inspection__loss_of_water_oil__marten_damage__Caption; Visual_Inspection__loss_of_water_oil__marten_damage__CaptionLbl)
            {
            }
            column(Oil_Level_Check_Caption; Oil_Level_Check_CaptionLbl)
            {
            }
            column(Battery_Test_Caption; Battery_Test_CaptionLbl)
            {
            }
            column(Brake_Fluid_Level__tightness__Caption; Brake_Fluid_Level__tightness__CaptionLbl)
            {
            }
            column(Fan_Belt__visual_inspection__tension__Caption; Fan_Belt__visual_inspection__tension__CaptionLbl)
            {
            }
            column(Tooth_Belt__visual_inspection__tension__Caption; Tooth_Belt__visual_inspection__tension__CaptionLbl)
            {
            }
            column(Level_of_Cooling_Fluid__antifreeze__tightness__Caption; Level_of_Cooling_Fluid__antifreeze__tightness__CaptionLbl)
            {
            }
            column(Windshield_Washer__condition_antifreeze__Caption; Windshield_Washer__condition_antifreeze__CaptionLbl)
            {
            }
            column(Condition_of_Rims_Tires_Caption; Condition_of_Rims_Tires_CaptionLbl)
            {
            }
            column(Tread_Pattern_in_mm_Caption; Tread_Pattern_in_mm_CaptionLbl)
            {
            }
            column(Wear_Pattern__Suspension__Geometry_Caption; Wear_Pattern__Suspension__Geometry_CaptionLbl)
            {
            }
            column(Steering__visual_inspection__Caption; Steering__visual_inspection__CaptionLbl)
            {
            }
            column(Oil_Loss__engine_gearbox__transmission__axle__Caption; Oil_Loss__engine_gearbox__transmission__axle__CaptionLbl)
            {
            }
            column(Brake_Disks__Pads__Lines__Hoses_Caption; Brake_Disks__Pads__Lines__Hoses_CaptionLbl)
            {
            }
            column(Joint_Gaiters_Joint_Boots_Caption; Joint_Gaiters_Joint_Boots_CaptionLbl)
            {
            }
            column(Shock_Absorbers__tightness__Caption; Shock_Absorbers__tightness__CaptionLbl)
            {
            }
            column(Front__Center__Rear_Silencer_Caption; Front__Center__Rear_Silencer_CaptionLbl)
            {
            }
            column(Fuel_Tank_Tank_Pipes_Caption; Fuel_Tank_Tank_Pipes_CaptionLbl)
            {
            }
            column(Other__Comments_Caption; Other__Comments_CaptionLbl)
            {
            }
            column(Remark__Caption; Remark__CaptionLbl)
            {
            }
            column(DataItem1119427055; This_report_is_the_result_of_a_visual_inspection_of_the_points_exclusively_mentioned_rLbl)
            {
            }
            column(Signature_Customer_Caption; Signature_Customer_CaptionLbl)
            {
            }
            column(Signature_Service_Advisor_Caption; Signature_Service_Advisor_CaptionLbl)
            {
            }
            column(Rental_Car_Required__Caption; Rental_Car_Required__CaptionLbl)
            {
            }
            column(Interior_Cleaning_Caption; Interior_Cleaning_CaptionLbl)
            {
            }
            column(Car_Wash_Caption; Car_Wash_CaptionLbl)
            {
            }
            column(OKCaption; OKCaptionLbl)
            {
            }
            column(not_OK_Caption; not_OK_CaptionLbl)
            {
            }
            column(Service_Header__Order_Date_Caption; Service_Header__Order_Date_CaptionLbl)
            {
            }
            column(Service_Header_Document_Type; "Document Type")
            {
            }
            column(Service_Header_No_; "No.")
            {
            }
            column(Vehicle_conditions_caption; Vehicle_conditions_caption)
            {
            }
            column(Vehicle_damages_caption; Vehicle_damages_caption)
            {
            }
            column(Radio; Radio)
            {
            }
            column(Notebook; Notebook)
            {
            }
            column(Fuel_level; Fuel_level)
            {
            }
            column(AdBlue_level; AdBlue_level)
            {
            }
            column(WO_number; WO_number)
            {
            }
            column(TV; TV)
            {
            }
            column(Refigerator; Refigerator)
            {
            }
            column(Navigation_system; Navigation_system)
            {
            }
            column(Windscreen_damage; Windscreen_damage)
            {
            }
            column(Body_damage; Body_damage)
            {
            }
            column(Tire_damage; Tire_damage)
            {
            }
            column(Mirror_damage; Mirror_damage)
            {
            }
            column(Cab_damage; Cab_damage)
            {
            }
            column(Paint_damage; Paint_damage)
            {
            }
            column(Phone; Phone)
            {
            }
            column(Yes; Yes)
            {
            }
            column(No; No)
            {
            }
            column(Service_header_No; "Service Header"."No.")
            {
            }
            column(Lights_damage; Lights_damage)
            {
            }
            column(Name; Name)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF DirectReceptPictureG.GET() THEN
                    DirectReceptPictureG.CALCFIELDS("Direct Reception Picture");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        ServSetupG.GET();
    end;

    var
        AddressSetupG: Record "Address Setup";
        AddressSetupReadG: Boolean;
        ServSetupG: Record "Service Setup";
        DirectReceptPictureG: Record "Serv. Sched. Direct Picture";
        Direct_Vehicle_Reception_Checklist_CaptionLbl: Label 'Direct Vehicle Reception-Checklist';
        Service_Advisor_Name_CaptionLbl: Label 'Service Advisor Name';
        Interior_CaptionLbl: Label 'Interior';
        Examination_of_Exterior_CaptionLbl: Label 'Examination of Exterior';
        Engine_Compartment_CaptionLbl: Label 'Engine Compartment';
        Vehicle_Hoist_CaptionLbl: Label 'Vehicle Hoist';
        Additional_Services_CaptionLbl: Label 'Additional Services';
        Illumination_Check_CaptionLbl: Label 'Illumination Check';
        Dash_Board_Switches__Functional_Test_CaptionLbl: Label 'Dash Board Switches, Functional Test';
        Rim_Locks__Rim_Lock_Key_CaptionLbl: Label 'Rim Locks: Rim Lock Key?';
        Stone_Chipping__Windshield_Headlights__CaptionLbl: Label 'Stone Chipping (Windshield/Headlights)';
        Head_Lights__adjustment_damages_dull__CaptionLbl: Label 'Head Lights (adjustment/damages/dull)';
        Wiper_Blades__front_rear__CaptionLbl: Label 'Wiper Blades (front/rear)';
        Painting_CaptionLbl: Label 'Painting';
        Bodywork_Condition__incl__Pulp_Catchers_Mirrors__CaptionLbl: Label 'Bodywork Condition (incl. Pulp Catchers/Mirrors)';
        Visual_Inspection__loss_of_water_oil__marten_damage__CaptionLbl: Label 'Visual Inspection (loss of water/oil, marten damage)';
        Oil_Level_Check_CaptionLbl: Label 'Oil Level Check';
        Battery_Test_CaptionLbl: Label 'Battery Test';
        Brake_Fluid_Level__tightness__CaptionLbl: Label 'Brake Fluid Level (tightness)';
        Fan_Belt__visual_inspection__tension__CaptionLbl: Label 'Fan Belt (visual inspection, tension)';
        Tooth_Belt__visual_inspection__tension__CaptionLbl: Label 'Tooth Belt (visual inspection, tension)';
        Level_of_Cooling_Fluid__antifreeze__tightness__CaptionLbl: Label 'Level of Cooling Fluid (antifreeze, tightness)';
        Windshield_Washer__condition_antifreeze__CaptionLbl: Label 'Windshield Washer (condition/antifreeze)';
        Condition_of_Rims_Tires_CaptionLbl: Label 'Condition of Rims/Tires';
        Tread_Pattern_in_mm_CaptionLbl: Label 'Tread Pattern in mm';
        Wear_Pattern__Suspension__Geometry_CaptionLbl: Label 'Wear Pattern, Suspension, Geometry';
        Steering__visual_inspection__CaptionLbl: Label 'Steering (visual inspection)';
        Oil_Loss__engine_gearbox__transmission__axle__CaptionLbl: Label 'Oil Loss (engine/gearbox (transmission)/axle)';
        Brake_Disks__Pads__Lines__Hoses_CaptionLbl: Label 'Brake Disks/-Pads/-Lines/-Hoses';
        Joint_Gaiters_Joint_Boots_CaptionLbl: Label 'Joint Gaiters/Joint Boots';
        Shock_Absorbers__tightness__CaptionLbl: Label 'Shock Absorbers (tightness)';
        Front__Center__Rear_Silencer_CaptionLbl: Label 'Front-/Center-/Rear Silencer';
        Fuel_Tank_Tank_Pipes_CaptionLbl: Label 'Fuel Tank/Tank Pipes';
        Other__Comments_CaptionLbl: Label 'Other, comments';
        Remark__CaptionLbl: Label 'Remark:';
        This_report_is_the_result_of_a_visual_inspection_of_the_points_exclusively_mentioned_rLbl: Label 'This report is the result of a visual inspection of the points exclusively mentioned in this form. The found deficiencies listed in this report are no exclusion for the fact that your vehicle might have further deficiencies.';
        Signature_Customer_CaptionLbl: Label 'Signature Customer';
        Signature_Service_Advisor_CaptionLbl: Label 'Signature Service Advisor';
        Rental_Car_Required__CaptionLbl: Label 'Rental Car Required?';
        Interior_Cleaning_CaptionLbl: Label 'Interior Cleaning';
        Car_Wash_CaptionLbl: Label 'Car Wash';
        OKCaptionLbl: Label 'OK';
        not_OK_CaptionLbl: Label 'not OK';
        Service_Header__Order_Date_CaptionLbl: Label 'Order Date';
        Vehicle_conditions_caption: Label 'Vehicle conditions';
        Vehicle_damages_caption: Label 'Vehicle damages';
        Radio: Label 'Radio';
        Notebook: Label 'Laptop';
        Fuel_level: Label 'Fuel level';
        AdBlue_level: Label 'AdBlue level';
        WO_number: Label 'Order number';
        TV: Label 'TV';
        Refigerator: Label 'Refrigerator';
        Navigation_system: Label 'Navigation system';
        Windscreen_damage: Label 'Windscreen damage';
        Body_damage: Label 'Body damage';
        Tire_damage: Label 'Tire damage';
        Mirror_damage: Label 'Mirror damage';
        Cab_damage: Label 'Cab damage';
        Paint_damage: Label 'Paint damage';
        Phone: Label 'Phone:';
        Yes: Label 'Yes';
        No: Label 'No';
        Lights_damage: Label 'Lights damage';
        Name: Label 'Name';

    [Scope('Internal')]
    procedure GetServiceAdvisorName(ServAdvisorNoP: Code[20]): Text[70]
    var
        EmployeeL: Record Employee;
    begin
        IF ServAdvisorNoP = '' THEN
            EXIT('');

        IF ServAdvisorNoP <> EmployeeL."No." THEN
            IF NOT EmployeeL.GET(ServAdvisorNoP) THEN
                EXIT('');

        IF NOT AddressSetupReadG THEN
            AddressSetupG.GET();

        IF AddressSetupG."Name Sequence" = AddressSetupG."Name Sequence"::"Last/First Name" THEN
            EXIT(EmployeeL."Last Name" + ', ' + EmployeeL."First Name")
        ELSE
            EXIT(EmployeeL."First Name" + ', ' + EmployeeL."Last Name");
    end;
}

