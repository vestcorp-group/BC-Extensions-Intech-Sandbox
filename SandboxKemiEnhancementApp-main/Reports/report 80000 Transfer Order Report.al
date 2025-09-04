// https://api.businesscentral.dynamics.com/v2.0/f9b0ac4e-f41d-470a-8c60-592af9e81ca3/India/WS/Chemiprime%20Impex%20Pvt.%20Ltd/Codeunit/GenerateGPReport
// https://api.businesscentral.dynamics.com/v2.0/f9b0ac4e-f41d-470a-8c60-592af9e81ca3/India/WS/Chemiprime%20Impex%20Pvt.%20Ltd/Codeunit/GenerateGPReport
// https://api.businesscentral.dynamics.com/v2.0/3e2937d0-cd42-4c48-bf44-ee7afb3be012/UNIPIAN_R3_PROD/

// Display name: Unipian_ERP_R3_Prod
// Application (client) ID: b4e23081-09e8-4bf8-8742-38b466366294
// Object ID: c796205b-1e3f-4fc2-8e7c-4179d1a5629e
// Directory (tenant) ID: 3e2937d0-cd42-4c48-bf44-ee7afb3be012
// Managed application in local directory: Unipian_ERP_R3_Prod

// Client Secret
// Value: bGV8Q~td0hpkgsTj5MCT-I58jJcUhSNommNhrcOz
// Secret ID: f89c26ed-01fe-4368-a752-c4cdaca6f76e


// If requesting support, please provide the following details to help troubleshooting:

// Error message: 
// The company "Niochem FZE_1" does not exist.

// Internal session ID: 
// a76c1405-d628-4743-b8b2-323c88c0198f

// Application Insights session ID: 
// 79ade3b8-979a-4525-9407-dcbc8aa2babd

// Client activity id: 
// 7e126472-9ba2-44a9-9688-0a1fb4cdd5b8

// Time stamp on error: 
// 2025-02-18T14:40:50.6366728Z

// User telemetry id: 
// 64d84c98-04f9-4c02-a4fe-a1871084f4cd

// AL call stack: 
// "Gross Profit Report_ISPL"(Report 50115).UpdateICInvoiceLineForUAESI line 43 - Intech_Development by ISPL
// "Gross Profit Report_ISPL"(Report 50115).OnPostReport(Trigger) line 22 - Intech_Development by ISPL



//                         CLEAR(ICPartners);
//                         ICPartners.ChangeCompany(Companies.Name);
//                         ICPartners.SETRANGE("Customer No.", RecSalesInvHeader."Sell-to Customer No.");
//                         IF not ICPartners.FINDFIRST THEN
//                         //coment
//                         begin
//                             ExcludeForIndiaIC := false;//settings default value

//                             //checking IC customer for india environment to exclude those customers
//                             Clear(RecCsutomerL);
//                             RecCsutomerL.ChangeCompany(Companies.Name);
//                             if RecSalesInvHeader."Sell-to Customer No." <> '' then // added by baya
//                                 RecCsutomerL.GET(RecSalesInvHeader."Sell-to Customer No.");
//                             // if IsAPICall AND (RecCsutomerL."IC Company Code" <> '') then
//                             //     ExcludeForIndiaIC := true;
//                             if (RecCsutomerL."IC Company Code" <> '') then
//                                 ExcludeForIndiaIC := true;

//                             if ExcludeForIndiaIC = false then
//                             //comment

// Type Of Transaction: Purchase, Inter Company Partner Code: KEMIPEXFZCO, Starting Date: <=17-02-25, Ending Date: >=17-02-25, Item No.: FG0000176, Variant Code: '', Unit of Measure: MT, Currency Code: ''

// 1-Kemipex Business App-Compare
// 2-Kemipex Enhancement App- Live folder









