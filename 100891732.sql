--Midland Optical Customer database
--Brandon Marino 100891732
--December 22nd 2014

--Information used in this example will be made up as the owner of the business, my aunt, can not legaly
--release her patient's personal information without their consent.  And she would have had to make a lot of calls

--DROP ALL TABLES FOR TESTING PURPOSES
--=====================================
DROP TABLE if exists insurance;
DROP TABLE if exists lenses;
DROP TABLE if exists frames;
DROP TABLE if exists prescriptions;
DROP TABLE if exists patients;
DROP TABLE if exists sales;

--CREATE DATABASE TABLES
--=======================

--Insurance Profile
--Will contain the information necessart to submit a claim
create table if not exists insurance(
        policy_no TEXT primary key NOT NULL, --the policy number, normally consists of numbers and characters
        company TEXT NOT NULL, --examples: Manulife, BMO, Aviva
        allotment DOUBLE NOT NULL, --business owner may need to leave this value blank to enter it later after consulting the company for the alloted funds
        --used DOUBLE default NULL, may be left unfilled for the above reason
        assignment_intent int NOT NULL -- 1-3 clinic, client, not allowed 
    );

--Lenses
--will store information of the lenses that are installed into each pair of glasses
create table if not exists lense(
        lense_id INTEGER primary key NOT NULL, --auto increment key
        type TEXT default NULL, --sv,bifocals,progressives,etc
        material TEXT NOT NULL, --what the lenses are made of
        base_curve TEXT default NULL, --base curve of the lense
        coating TEXT NOT NULL, --coating on lenses
        cost DOUBLE NOT NULL --the cost of the frames by themselves
    );

--Frames
--specific information about each type of frame that the business owns
create table if not exists frames(
        frame_id INTEGER primary key NOT NULL, --auto increment key
        model TEXT NOT NULL, --model tag of the frame pair
        manufacturer TEXT NOT NULL, --manufacter of the lenses (Oakly, Addidas, etc)
        frame_material TEXT NOT NULL, --plastic, metal, etc
        colour TEXT NOT NULL, --colour of the frames
        cost DOUBLE NOT NULL --cost of the frames
    );

--Prescriptions
--used to store information about each individuals prescriptions 
--the prescription may be made at some point and the values filled later
create table if not exists prescriptions(
        presc_id INTEGER primary key NOT NULL, --auto increment key
        patient INTEGER NOT NULL,
        OD TEXT NOT NULL,
        OS TEXT NOT NULL,
        presc_add TEXT NOT NULL,
        prism TEXT default NULL,
        date_RX TEXT NOT NULL, --Will be stored in the form of YYYY-MM-DD
        refferingDoctor TEXT NOT NULL,
        refferingLocation TEXT NOT NULL,
        refferingNumber TEXT NOT NULL,
        left_pupillaryDistance TEXT NOT NULL,
        right_pupillaryDistance TEXT NOT NULL,
        left_seg-height TEXT NOT NULL,
        right_seg-height TEXT NOT NULL,
        --hts TEXT default NULL,
        --frame_measurements TEXT default NULL,
        foreign key (patient) references patients(px_id) on delete cascade
    );

--Patients
--Personal information for use with contact and insurance policies
create table if not exists patients(
        px_id INTEGER primary key NOT NULL, --auto increment key
        first_name TEXT NOT NULL, --name of patient
        last_name TEXT NOT NULL,
        st_address TEXT NOT NULL, --street address of the patient
        city TEXT NOT NULL, --home city of the patient
        province VARCHAR(2) NOT NULL, --will store the province code of the current user
        primary_phoneNo INTEGER NOT NULL, --patient's main phonenumber
        secondary_phoneNo INTEGER default NULL, --student who contributed the data
        email TEXT default NULL, --email, users may not be able to provide them
        occupation TEXT default NULL, --patient's occupation (engineer, doctor, teacher)
        policy_no TEXT default NULL references insurance(policy_no), --refence to insurance table, you can pick on claiming
        sec_policy_no TEXT default NULL references insurance(policy_no), --refence to insurance table
        date_of_next_exam TEXT default NULL, -- Date by which the patient whould have their next exam
        acknowledged int NOT NULL, -- if the patient has confirmed a date
        refferedBy INTEGER default NULL references px_id --another patient who refered this one
    );

--Sales
--information about specific glasses which were sold by the business
create table if not exists sales(
        date TEXT NOT NULL, --date of sale YYYY-MM-DD
        patient INTEGER NOT NULL,
        frame INTEGER NOT NULL references frames(frame_id),
        lense INTEGER NOT NULL references lenses(lense_id),
        foreign key (patient) references patients(px_id) on delete cascade
    );

--INSERT DATA
--=======================

begin transaction;

--Insert Insurance information
--due to the legality around patient confidentiality, these values will be randomly generated for testing using 'http://www.generatedata.com/'
--patients each have an insurance element. some family plans exist though
/*
insert into insurance (policy_no,company,allotment) values ("99999","Manulife",352.27);
insert into insurance (policy_no,company,allotment) values ("99998","Allstate",269.65);
insert into insurance (policy_no,company,allotment) values ("99997","Assumption Life",287.43);
insert into insurance (policy_no,company,allotment) values ("99996","Manulife",757.21);
insert into insurance (policy_no,company,allotment) values ("99995","Assumption Life",912.51);
insert into insurance (policy_no,company,allotment) values ("99994","BMO Insurance",100.98);
insert into insurance (policy_no,company,allotment) values ("99993","BMO Insurance",493.71);
insert into insurance (policy_no,company,allotment) values ("99992","BMO Insurance",217.77);
insert into insurance (policy_no,company,allotment) values ("99991","Manulife",957.78);
insert into insurance (policy_no,company,allotment) values ("99990","BMO Insurance",457.28);
insert into insurance (policy_no,company,allotment) values ("99989","BMO Insurance",676.58);
insert into insurance (policy_no,company,allotment) values ("99988","Allstate",992.89);
insert into insurance (policy_no,company,allotment) values ("99987","Assumption Life",186.72);
insert into insurance (policy_no,company,allotment) values ("99986","Allstate",757.63);
insert into insurance (policy_no,company,allotment) values ("99985","Manulife",940.32);
insert into insurance (policy_no,company,allotment) values ("99984","Allstate",874.12);
insert into insurance (policy_no,company,allotment) values ("99983","Allstate",888.65);
insert into insurance (policy_no,company,allotment) values ("99982","Allstate",984.61);
insert into insurance (policy_no,company,allotment) values ("99981","Assumption Life",211.02);
insert into insurance (policy_no,company,allotment) values ("99980","Assumption Life",940.20);
insert into insurance (policy_no,company,allotment) values ("99979","Assumption Life",866.72);
insert into insurance (policy_no,company,allotment) values ("99978","BMO Insurance",544.88);
insert into insurance (policy_no,company,allotment) values ("99977","Assumption Life",442.54);
insert into insurance (policy_no,company,allotment) values ("99976","Assumption Life",647.08);
insert into insurance (policy_no,company,allotment) values ("99975","BMO Insurance",883.00);
insert into insurance (policy_no,company,allotment) values ("99974","Assumption Life",277.84);
insert into insurance (policy_no,company,allotment) values ("99973","Allstate",675.86);
insert into insurance (policy_no,company,allotment) values ("99972","Allstate",624.67);
insert into insurance (policy_no,company,allotment) values ("99971","Assumption Life",711.15);
insert into insurance (policy_no,company,allotment) values ("99970","BMO Insurance",989.28);
insert into insurance (policy_no,company,allotment) values ("99969","Manulife",927.69);
insert into insurance (policy_no,company,allotment) values ("99968","Manulife",712.34);
insert into insurance (policy_no,company,allotment) values ("99967","Manulife",207.74);
insert into insurance (policy_no,company,allotment) values ("99966","Assumption Life",819.39);
insert into insurance (policy_no,company,allotment) values ("99965","Allstate",809.43);
insert into insurance (policy_no,company,allotment) values ("99964","Assumption Life",573.18);
insert into insurance (policy_no,company,allotment) values ("99963","Manulife",537.35);
insert into insurance (policy_no,company,allotment) values ("99962","Allstate",392.27);
insert into insurance (policy_no,company,allotment) values ("99961","Manulife",262.56);
insert into insurance (policy_no,company,allotment) values ("99960","Manulife",531.68);
insert into insurance (policy_no,company,allotment) values ("99959","Assumption Life",476.86);
insert into insurance (policy_no,company,allotment) values ("99958","BMO Insurance",367.17);
insert into insurance (policy_no,company,allotment) values ("99957","Assumption Life",126.88);
insert into insurance (policy_no,company,allotment) values ("99956","Assumption Life",683.93);
insert into insurance (policy_no,company,allotment) values ("99955","Assumption Life",450.00);
insert into insurance (policy_no,company,allotment) values ("99954","BMO Insurance",250.59);
insert into insurance (policy_no,company,allotment) values ("99953","Allstate",439.32);
insert into insurance (policy_no,company,allotment) values ("99952","BMO Insurance",005.11);
insert into insurance (policy_no,company,allotment) values ("99951","BMO Insurance",749.87);
insert into insurance (policy_no,company,allotment) values ("99950","Assumption Life",661.50);
insert into insurance (policy_no,company,allotment) values ("99949","BMO Insurance",388.21);
insert into insurance (policy_no,company,allotment) values ("99948","Manulife",628.13);
insert into insurance (policy_no,company,allotment) values ("99947","Allstate",674.89);
insert into insurance (policy_no,company,allotment) values ("99946","Assumption Life",441.97);
insert into insurance (policy_no,company,allotment) values ("99945","Allstate",396.48);
insert into insurance (policy_no,company,allotment) values ("99944","Allstate",837.58);
insert into insurance (policy_no,company,allotment) values ("99943","Manulife",176.63);
insert into insurance (policy_no,company,allotment) values ("99942","Assumption Life",272.45);
insert into insurance (policy_no,company,allotment) values ("99941","BMO Insurance",292.86);
insert into insurance (policy_no,company,allotment) values ("99940","Manulife",413.46);
insert into insurance (policy_no,company,allotment) values ("99939","Manulife",270.42);
insert into insurance (policy_no,company,allotment) values ("99938","Manulife",972.29);
insert into insurance (policy_no,company,allotment) values ("99937","BMO Insurance",789.73);
insert into insurance (policy_no,company,allotment) values ("99936","Manulife",782.44);
insert into insurance (policy_no,company,allotment) values ("99935","Manulife",618.34);
insert into insurance (policy_no,company,allotment) values ("99934","Assumption Life",608.02);
insert into insurance (policy_no,company,allotment) values ("99933","BMO Insurance",616.40);
insert into insurance (policy_no,company,allotment) values ("99932","Allstate",565.62);
insert into insurance (policy_no,company,allotment) values ("99931","BMO Insurance",366.29);
insert into insurance (policy_no,company,allotment) values ("99930","Allstate",720.64);
insert into insurance (policy_no,company,allotment) values ("99929","BMO Insurance",059.75);
insert into insurance (policy_no,company,allotment) values ("99928","Allstate",333.24);
insert into insurance (policy_no,company,allotment) values ("99927","Allstate",090.26);
insert into insurance (policy_no,company,allotment) values ("99926","Assumption Life",538.88);
insert into insurance (policy_no,company,allotment) values ("99925","Allstate",995.40);
insert into insurance (policy_no,company,allotment) values ("99924","Allstate",793.33);
insert into insurance (policy_no,company,allotment) values ("99923","Manulife",671.54);
insert into insurance (policy_no,company,allotment) values ("99922","BMO Insurance",323.45);
insert into insurance (policy_no,company,allotment) values ("99921","Manulife",795.76);
insert into insurance (policy_no,company,allotment) values ("99920","Manulife",106.92);
insert into insurance (policy_no,company,allotment) values ("99919","Assumption Life",957.99);
insert into insurance (policy_no,company,allotment) values ("99918","Manulife",639.35);
insert into insurance (policy_no,company,allotment) values ("99917","BMO Insurance",788.14);
insert into insurance (policy_no,company,allotment) values ("99916","Manulife",463.37);
insert into insurance (policy_no,company,allotment) values ("99915","Manulife",285.53);
insert into insurance (policy_no,company,allotment) values ("99914","Assumption Life",678.66);
insert into insurance (policy_no,company,allotment) values ("99913","Allstate",670.00);
insert into insurance (policy_no,company,allotment) values ("99912","BMO Insurance",526.64);
insert into insurance (policy_no,company,allotment) values ("99911","Manulife",880.38);
insert into insurance (policy_no,company,allotment) values ("99910","Manulife",338.16);
insert into insurance (policy_no,company,allotment) values ("99909","Assumption Life",796.56);
insert into insurance (policy_no,company,allotment) values ("99908","BMO Insurance",390.56);
insert into insurance (policy_no,company,allotment) values ("99907","Allstate",398.04);
insert into insurance (policy_no,company,allotment) values ("99906","Manulife",355.57);
insert into insurance (policy_no,company,allotment) values ("99905","Assumption Life",417.42);
insert into insurance (policy_no,company,allotment) values ("99904","Allstate",822.00);
insert into insurance (policy_no,company,allotment) values ("99903","BMO Insurance",269.03);
insert into insurance (policy_no,company,allotment) values ("99902","Assumption Life",310.77);
insert into insurance (policy_no,company,allotment) values ("99901","Manulife",257.21);

--Insert Lense information

insert into lenses (type, material, base_curve, cost) values ("sv","polarized","+2.74",63.90);
insert into lenses (type, material, base_curve, cost) values ("bifocal","transitions","+2.97",64.25);
insert into lenses (type, material, base_curve, cost) values ("multi focal","transitions","+2.23",55.63);
insert into lenses (type, material, base_curve, cost) values ("bifocal","polarized","+0.20",51.01);
insert into lenses (type, material, base_curve, cost) values ("sv","hi-index","+2.13",95.57);
insert into lenses (type, material, base_curve, cost) values ("sv","polarized","+2.27",58.37);
insert into lenses (type, material, base_curve, cost) values ("sv","hi-index","+1.42",67.26);
insert into lenses (type, material, base_curve, cost) values ("bifocal","plastic","+0.26",67.77);
insert into lenses (type, material, base_curve, cost) values ("sv","hi-index","+3.00",81.97);
insert into lenses (type, material, base_curve, cost) values ("multi focal","polarized","+0.74",63.76);
insert into lenses (type, material, base_curve, cost) values ("multi focal","transitions","+2.85",72.46);
insert into lenses (type, material, base_curve, cost) values ("sv","transitions","+2.97",61.79);
insert into lenses (type, material, base_curve, cost) values ("sv","hi-index","+1.56",75.96);
insert into lenses (type, material, base_curve, cost) values ("sv","polarized","+1.32",55.32);
insert into lenses (type, material, base_curve, cost) values ("sv","polymer","+2.35",87.78);
insert into lenses (type, material, base_curve, cost) values ("sv","polarized","+1.01",96.78);
insert into lenses (type, material, base_curve, cost) values ("sv","polymer","+2.97",82.31);
insert into lenses (type, material, base_curve, cost) values ("bifocal","plastic","+2.27",85.08);
insert into lenses (type, material, base_curve, cost) values ("multi focal","plastic","+0.40",78.69);
insert into lenses (type, material, base_curve, cost) values ("sv","plastic","-0.83",77.06);
insert into lenses (type, material, base_curve, cost) values ("sv","plastic","-1.56",54.39);
insert into lenses (type, material, base_curve, cost) values ("bifocal","polarized","-0.05",54.48);
insert into lenses (type, material, base_curve, cost) values ("multi focal","polarized","-1.31",84.68);
insert into lenses (type, material, base_curve, cost) values ("sv","plastic","-2.26",59.88);
insert into lenses (type, material, base_curve, cost) values ("sv","polarized","-0.49",52.14);
insert into lenses (type, material, base_curve, cost) values ("bifocal","polymer","-2.74",63.96);
insert into lenses (type, material, base_curve, cost) values ("multi focal","polymer","-1.53",88.09);
insert into lenses (type, material, base_curve, cost) values ("bifocal","transitions","-2.03",78.03);
insert into lenses (type, material, base_curve, cost) values ("sv","polarized","-1.40",91.91);
insert into lenses (type, material, base_curve, cost) values ("sv","hi-index","-1.33",95.17);
insert into lenses (type, material, base_curve, cost) values ("multi focal","plastic","-1.70",58.85);
insert into lenses (type, material, base_curve, cost) values ("sv","hi-index","-1.85",73.95);
insert into lenses (type, material, base_curve, cost) values ("sv","hi-index","-1.47",88.96);
insert into lenses (type, material, base_curve, cost) values ("multi focal","transitions","-2.93",95.93);
insert into lenses (type, material, base_curve, cost) values ("bifocal","polymer","-2.43",71.16);
insert into lenses (type, material, base_curve, cost) values ("bifocal","polymer","-2.47",51.21);
insert into lenses (type, material, base_curve, cost) values ("sv","transitions","-0.51",58.38);
insert into lenses (type, material, base_curve, cost) values ("multi focal","plastic","-1.85",83.15);
insert into lenses (type, material, base_curve, cost) values ("sv","polarized","-0.10",92.89);
insert into lenses (type, material, base_curve, cost) values ("sv","transitions","-1.47",90.15);
insert into lenses (type, material, base_curve, cost) values ("multi focal","polymer","-0.97",50.05);
insert into lenses (type, material, base_curve, cost) values ("multi focal","transitions","-1.80",52.42);
insert into lenses (type, material, base_curve, cost) values ("bifocal","polymer","-0.13",77.71);
insert into lenses (type, material, base_curve, cost) values ("sv","plastic","-0.88",94.60);
insert into lenses (type, material, base_curve, cost) values ("multi focal","polymer","-0.73",66.90);
insert into lenses (type, material, base_curve, cost) values ("bifocal","hi-index","-1.69",88.96);
insert into lenses (type, material, base_curve, cost) values ("bifocal","polymer","+2.30",83.42);
insert into lenses (type, material, base_curve, cost) values ("bifocal","plastic","+1.81",92.22);
insert into lenses (type, material, base_curve, cost) values ("sv","polarized","+2.21",62.19);
insert into lenses (type, material, base_curve, cost) values ("sv","polarized","+1.79",95.86);
insert into lenses (type, material, base_curve, cost) values ("sv","transitions","+0.32",58.64);
insert into lenses (type, material, base_curve, cost) values ("multi focal","polymer","+1.93",94.08);
insert into lenses (type, material, base_curve, cost) values ("multi focal","plastic","+0.01",67.09);
insert into lenses (type, material, base_curve, cost) values ("multi focal","hi-index","+1.45",72.40);
insert into lenses (type, material, base_curve, cost) values ("multi focal","transitions","+1.74",96.96);
insert into lenses (type, material, base_curve, cost) values ("multi focal","polarized","+0.33",83.25);
insert into lenses (type, material, base_curve, cost) values ("multi focal","polarized","+0.84",77.42);
insert into lenses (type, material, base_curve, cost) values ("multi focal","plastic","+0.66",79.88);
insert into lenses (type, material, base_curve, cost) values ("bifocal","transitions","+0.22",57.88);
insert into lenses (type, material, base_curve, cost) values ("multi focal","plastic","+0.91",81.75);
insert into lenses (type, material, base_curve, cost) values ("multi focal","polarized","+0.65",68.74);
insert into lenses (type, material, base_curve, cost) values ("sv","hi-index","+2.51",64.45);
insert into lenses (type, material, base_curve, cost) values ("sv","plastic","+2.07",70.23);
insert into lenses (type, material, base_curve, cost) values ("multi focal","hi-index","+0.75",77.13);
insert into lenses (type, material, base_curve, cost) values ("bifocal","polymer","+1.14",72.16);
insert into lenses (type, material, base_curve, cost) values ("multi focal","polymer","+1.48",55.95);
insert into lenses (type, material, base_curve, cost) values ("multi focal","transitions","+2.85",72.46);
insert into lenses (type, material, base_curve, cost) values ("sv","transitions","+2.97",61.79);
insert into lenses (type, material, base_curve, cost) values ("sv","hi-index","+1.56",75.96);
insert into lenses (type, material, base_curve, cost) values ("sv","polarized","+1.32",55.32);
insert into lenses (type, material, base_curve, cost) values ("sv","polymer","+2.35",87.78);
insert into lenses (type, material, base_curve, cost) values ("sv","polarized","+1.01",96.78);
insert into lenses (type, material, base_curve, cost) values ("sv","polymer","+2.97",82.31);
insert into lenses (type, material, base_curve, cost) values ("bifocal","plastic","+2.27",85.08);
insert into lenses (type, material, base_curve, cost) values ("multi focal","plastic","+0.40",78.69);
insert into lenses (type, material, base_curve, cost) values ("sv","plastic","-0.83",77.06);
insert into lenses (type, material, base_curve, cost) values ("sv","plastic","-1.56",54.39);
insert into lenses (type, material, base_curve, cost) values ("bifocal","polarized","-0.05",54.48);
insert into lenses (type, material, base_curve, cost) values ("multi focal","polarized","-1.31",84.68);
insert into lenses (type, material, base_curve, cost) values ("sv","plastic","-2.26",59.88);
insert into lenses (type, material, base_curve, cost) values ("sv","polarized","-0.49",52.14);
insert into lenses (type, material, base_curve, cost) values ("bifocal","polymer","-2.74",63.96);
insert into lenses (type, material, base_curve, cost) values ("multi focal","polymer","-1.53",88.09);
insert into lenses (type, material, base_curve, cost) values ("bifocal","transitions","-2.03",78.03);
insert into lenses (type, material, base_curve, cost) values ("sv","polarized","-1.40",91.91);
insert into lenses (type, material, base_curve, cost) values ("sv","hi-index","-1.33",95.17);
insert into lenses (type, material, base_curve, cost) values ("multi focal","plastic","-1.70",58.85);
insert into lenses (type, material, base_curve, cost) values ("sv","hi-index","-1.85",73.95);
insert into lenses (type, material, base_curve, cost) values ("sv","hi-index","-1.47",88.96);
insert into lenses (type, material, base_curve, cost) values ("multi focal","transitions","-2.93",95.93);
insert into lenses (type, material, base_curve, cost) values ("bifocal","polymer","-2.43",71.16);
insert into lenses (type, material, base_curve, cost) values ("bifocal","polymer","-2.47",51.21);
insert into lenses (type, material, base_curve, cost) values ("sv","transitions","-0.51",58.38);
insert into lenses (type, material, base_curve, cost) values ("multi focal","plastic","-1.85",83.15);
insert into lenses (type, material, base_curve, cost) values ("sv","polarized","-0.10",92.89);
insert into lenses (type, material, base_curve, cost) values ("sv","transitions","-1.47",90.15);
insert into lenses (type, material, base_curve, cost) values ("multi focal","polymer","-0.97",50.05);
insert into lenses (type, material, base_curve, cost) values ("multi focal","transitions","-1.80",52.42);
insert into lenses (type, material, base_curve, cost) values ("bifocal","polymer","-0.13",77.71);
insert into lenses (type, material, base_curve, cost) values ("sv","polymer","+2.97",82.31);

--Insert Frames information
--this is all of the information for each of the individual lenses, each perscription needs one of these but there could be more or less of them

insert into frames (colour, cost, model, manufacturer, frame_material) values ("white",79.73,"snowden","Lycos","plastic");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("black",64.47,"wire","Lycos","plastic");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("blue",91.32,"wire","Chami","metal");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("red",75.25,"librarian","Chami","metal");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("red",66.38,"librarian","Lycos","metal");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("black",59.60,"wire","MauiGem","plastic");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("blue",74.76,"wire","MauiGem","plastic");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("grey",90.18,"wire","MauiGem","semi");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("red",51.28,"wire","MauiGem","metal");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("black",92.07,"wire","Lycos","semi");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("white",88.54,"snowden","MauiGem","metal");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("red",87.04,"librarian","Chami","metal");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("black",68.23,"wire","MauiGem","plastic");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("blue",58.31,"wire","Lycos","plastic");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("blue",95.53,"snowden","Chami","metal");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("blue",75.01,"wire","MauiGem","semi");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("red",53.51,"wire","Addidas","plastic");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("blue",55.87,"snowden","Lycos","semi");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("red",83.82,"librarian","Addidas","semi");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("blue",66.13,"librarian","Chami","plastic");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("black",64.65,"wire","Altavista","plastic");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("red",66.73,"wire","Altavista","plastic");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("grey",89.00,"librarian","Lycos","metal");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("grey",50.72,"snowden","Lycos","plastic");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("white",92.01,"snowden","Lycos","metal");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("grey",81.53,"librarian","MauiGem","metal");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("red",63.63,"snowden","Lycos","metal");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("black",73.27,"librarian","Altavista","semi");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("red",68.07,"snowden","Addidas","plastic");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("black",76.63,"wire","Lycos","semi");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("white",84.92,"librarian","Chami","semi");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("black",94.30,"snowden","Chami","metal");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("grey",56.56,"snowden","MauiGem","semi");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("grey",97.97,"snowden","MauiGem","plastic");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("blue",76.10,"wire","Addidas","plastic");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("grey",76.44,"wire","Altavista","metal");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("grey",63.22,"wire","Addidas","metal");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("red",80.54,"wire","Lycos","metal");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("black",88.94,"wire","MauiGem","metal");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("red",55.13,"wire","MauiGem","semi");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("blue",54.35,"snowden","Lycos","metal");
insert into frames (colour, cost, model, manufacturer, frame_material) values ("grey",96.02,"snowden","MauiGem","metal");

--Prescriptions

insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("12mm","40mm","+1.70","2.50","18-02-15","Sylvia Z. Lang","2.75","-1.70","+2.75","10.0cm",1);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("35mm","40mm","+1.50","2.50","03-01-14","Pearl Z. Massey","1.70","+1.50","+1.50","15.5cm",2);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("40mm","35mm","+1.70","1.70","17-06-14","Alea N. Gilbert","2.75","-1.70","+1.50","12.5cm",3);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("60mm","40mm","+2.75","2.50","11-02-13","Mollie B. Hood","1.50","-1.70","-1.70","10.0cm",4);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("40mm","35mm","+1.50","1.70","26-12-14","Althea O. Cochran","2.75","-1.70","-1.70","15.5cm",5);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("60mm","60mm","+2.75","1.50","03-06-13","Declan Y. Underwood","2.50","+2.75","+2.75","14.5cm",6);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("60mm","60mm","+2.50","1.70","22-03-13","Meredith A. Villarreal","1.70","+2.75","+1.50","10.0cm",7);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("60mm","35mm","+2.50","2.50","27-05-14","Darius V. Thompson","2.75","-2.50","+1.50","10.0cm",8);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("31mm","40mm","+2.75","2.50","03-01-14","Jade J. Barlow","2.75","-1.70","-2.50","10.0cm",10);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("31mm","40mm","+2.75","2.75","06-01-13","Otto C. Holloway","1.50","+1.50","+1.50","14.5cm",11);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("40mm","35mm","+1.50","2.75","24-02-15","Noel D. Cooke","2.50","-1.70","+1.50","12.5cm",12);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("12mm","31mm","+2.75","2.50","10-11-13","Doris V. Bush","2.75","-1.70","-2.50","15.5cm",13);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("31mm","12mm","+2.75","2.50","17-05-15","Barbara L. Shelton","2.50","-2.50","+1.50","14.5cm",14);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("12mm","60mm","+1.70","2.75","08-03-15","Octavius D. Herman","1.50","+1.50","+1.50","10.0cm",15);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("35mm","12mm","+2.50","2.75","24-08-14","Camden K. Waters","1.70","+1.50","+1.50","12.5cm",16);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("12mm","12mm","+1.50","1.50","18-01-15","Aretha M. Osborne","1.70","+2.75","+2.75","12.5cm",17);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("31mm","35mm","+1.50","1.50","04-10-15","Barbara C. Thompson","2.50","-2.50","-2.50","12.5cm",18);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("31mm","35mm","+2.50","2.50","03-12-15","Amity Y. Espinoza","1.50","-2.50","-1.70","12.5cm",19);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("12mm","12mm","+2.50","2.75","16-11-15","Farrah N. Morales","1.50","-2.50","-1.70","10.0cm",20);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("35mm","60mm","+2.50","2.75","27-07-13","Tad B. Morris","2.75","-2.50","+1.50","15.5cm",21);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("40mm","60mm","+1.70","2.75","05-01-14","Lillian V. Stafford","1.70","+1.50","+1.50","14.5cm",22);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("35mm","12mm","+2.75","1.70","13-05-14","Tasha Q. Powell","1.50","-2.50","+2.75","14.5cm",23);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("35mm","60mm","+2.50","1.50","26-09-15","Connor X. Watkins","2.75","+2.75","+2.75","12.5cm",24);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("60mm","12mm","+1.50","1.70","18-03-14","Adrian F. Cummings","2.50","-1.70","+1.50","14.5cm",25);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("12mm","40mm","+1.50","2.50","08-12-13","Herman U. Miranda","2.50","+2.75","-2.50","12.5cm",26);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("40mm","60mm","+1.70","2.75","27-04-14","Jolene C. Mueller","1.70","-1.70","+2.75","10.0cm",27);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("35mm","12mm","+1.70","2.75","23-11-15","Alyssa D. Dejesus","1.70","+1.50","-2.50","15.5cm",28);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("12mm","35mm","+1.50","2.75","28-04-13","Desiree W. Miller","2.50","-1.70","+1.50","12.5cm",29);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("31mm","31mm","+1.50","2.50","03-03-13","Tobias R. Hunter","2.75","+1.50","+2.75","12.5cm",30);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("12mm","31mm","+1.50","1.70","02-08-14","Kitra X. Vincent","1.70","+2.75","-1.70","10.0cm",31);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("35mm","40mm","+1.70","1.70","03-02-13","Alan W. Burton","2.50","+1.50","+2.75","14.5cm",32);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("40mm","40mm","+2.50","2.75","26-06-13","Keiko E. Howell","1.50","-2.50","+1.50","12.5cm",33);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("35mm","60mm","+1.50","1.50","03-08-13","Piper B. Salas","1.70","+2.75","+1.50","15.5cm",34);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("35mm","60mm","+2.75","1.50","20-06-14","Matthew T. Joyner","2.50","-1.70","-1.70","14.5cm",35);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("40mm","40mm","+2.50","1.50","24-07-14","Sharon X. Mccarty","2.75","-1.70","+1.50","15.5cm",36);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("60mm","40mm","+1.70","1.50","25-11-15","Barclay I. Mitchell","1.70","+2.75","+2.75","14.5cm",37);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("40mm","35mm","+2.50","2.75","04-07-14","Noble V. Joseph","2.75","-1.70","+1.50","12.5cm",38);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("35mm","31mm","+1.50","2.50","02-12-15","Ivy C. Humphrey","1.70","+1.50","+2.75","14.5cm",39);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("60mm","40mm","+1.70","2.75","11-09-13","Robert M. Paul","1.70","+2.75","+1.50","10.0cm",40);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("12mm","35mm","+2.50","2.75","31-03-13","Stuart F. Watson","2.50","-2.50","-1.70","15.5cm",41);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("12mm","35mm","+1.50","1.70","08-11-14","Lacota Z. Holloway","2.50","+2.75","-2.50","12.5cm",42);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("12mm","35mm","+1.70","1.50","24-08-14","Trevor S. Goff","2.75","+2.75","+1.50","14.5cm",43);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("40mm","12mm","+1.50","2.75","15-11-14","Sopoline U. Moon","1.70","+1.50","+1.50","14.5cm",44);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("35mm","12mm","+1.70","1.70","01-08-13","Thane Z. Atkins","2.75","+2.75","+1.50","15.5cm",45);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("31mm","35mm","+2.50","2.50","12-07-14","Dorothy I. Lowe","1.50","-1.70","-2.50","15.5cm",46);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("35mm","12mm","+1.50","2.75","30-05-14","Maxine M. Mejia","1.70","+2.75","+1.50","15.5cm",47);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("12mm","31mm","+2.50","2.75","27-05-14","Graiden B. Wise","2.75","-2.50","-2.50","10.0cm",48);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("60mm","31mm","+1.70","1.70","03-08-13","Daryl M. Nieves","2.50","+2.75","+1.50","14.5cm",49);
insert into prescriptions (OD, OS, presc_add, prism, date_RX, refferingDoctor, pupillaryDistance, seg, hts, frame_measurements, patient) values ("40mm","60mm","+2.50","2.75","22-09-15","Keith P. Frederick","2.75","-2.50","+2.75","12.5cm",50);

--Insert Patient information
--due to the legality around patient confidentiality, these values will be randomly generated for testing using 'http://www.generatedata.com/'

insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Jenette", "Blair","Ap #296-7098 Turpis Street","Ottawa","ON","(343) 705-0115","scelerisque.mollis@sodalesMaurisblandit.ca",NULL);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Ashely","Carpenter","3742 Vel Avenue","Owen Sound","ON","(647) 317-1883","habitant.morbi@risus.ca",99999);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Burton","Odonnell","Ap #622-6975 Dui Ave","Innisfail","AB","(603) 633-6182","in.aliquet@erosturpis.ca",99998);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Lynn","Heath","503-556 Non Rd.","Cobourg","ON","(343) 894-6910","massa.lobortis.ultrices@magnis.ca",99997);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Anastasia","Snyder","400 Ac Road","Dorval","QC","(450) 360-5931","et.ultrices@mauris.com",99996);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Catherine","Pennington","P.O. Box 995, 8566 Neque. Av.","Northumberland","ON","(289) 462-4955","dolor.vitae.dolor@auctor.co.uk",99995);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Bert","Stephens","P.O. Box 927, 7696 Velit St.","Argyle","NS","(902) 502-4615","egestas.Fusce@Morbi.ca",99994);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Amela","Noble","423-5586 Fringilla Road","Bruderheim","AB","(780) 871-3225","fringilla.euismod.enim@nonenimMauris.com",99993);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Elton","Bernard","7586 Mattis Av.","Lakeshore","ON","(416) 452-7735","gravida.non.sollicitudin@malesuadaiderat.edu",99992);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Shad","Carpenter","1214 Tempor Rd.","Chicoutimi","QC","(438) 564-5340","nulla@nonlacinia.edu",99991);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Adriaa","Ruiz","Ap #562-5699 In Road","Sparwood","BC","(205) 430-0541","magnis.dis.parturient@NullafacilisisSuspendisse.org",99990);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Tad","Meyer","P.O. Box 502, 767 Tristique Rd.","Maple Creek","SK","(306) 197-0598","molestie.tellus@dolorsitamet.co.uk",99989);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Drew","Key","Ap #418-7335 Cras St.","Cornwall","ON","(613) 996-3135","dui@malesuada.net",99988);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Jenna","Jarvis","Ap #919-8091 Non Ave","Cabano","QC","(819) 967-6662","vitae.odio.sagittis@Integervitaenibh.ca",99987);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Blake","Black","Ap #928-4712 Nunc Avenue","Sherbrooke","QC","(450) 257-2080","mollis.Duis.sit@estmaurisrhoncus.com",99986);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Rhoda","Hyde","P.O. Box 775, 7574 Mattis. Street","Pangnirtung","NU","(867) 648-0021","felis.Donec.tempor@aliquet.co.uk",99985);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Lysandra","Guy","8170 Lacus Av.","Murdochville","QC","(819) 695-3208","nonummy.ipsum.non@atarcuVestibulum.ca",99984);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Blaze","Cote","Ap #872-5379 Nulla Rd.","Oyen","AB","(603) 292-6286","Praesent@nisisem.net",99983);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Molly","Frederick","111-1946 Dignissim Avenue","Whitehorse","YT","(867) 432-6785","lorem.semper.auctor@mauris.com",99982);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Althea","Black","8596 Tellus. St.","Assiniboia","SK","(306) 627-8820","Fusce.diam.nunc@temporbibendumDonec.net",99981);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Oliver","Lynn","Ap #726-9965 Cursus St.","Merrickville-Wolford","ON","(647) 162-6352","arcu.vel.quam@Donecdignissim.com",99980);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Addison","Hardin","Ap #164-1046 Libero Avenue","Red Deer","AB","(780) 857-8029","amet@sociisnatoque.edu",99979);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Kitra","Davis","475-3733 Vitae Rd.","St. Paul","AB","(603) 605-2282","vitae.semper@urnaconvalliserat.ca",99978);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Hayfa","Giles","307 Facilisis, St.","Whitehorse","YT","(867) 560-8918","mi.lacinia@adipiscingfringillaporttitor.ca",99977);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Katelyn","Gillespie","Ap #553-9227 Sit Av.","Lang","SK","(306) 440-4920","elit.Nulla@sem.co.uk",99976);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Abel","Lang","5515 Donec Avenue","Welland","ON","(705) 971-2446","gravida.sagittis.Duis@odioEtiam.com",99975);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Cameran","Bates","Ap #299-8703 Nibh Av.","Ucluelet","BC","(778) 424-7951","Sed.eu@etlibero.org",99974);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Brett","Craft","Ap #332-2344 Tempus Road","Hull","QC","(450) 964-7481","vestibulum.Mauris@sollicitudin.com",99973);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Bryar","Bailey","Ap #414-4947 Praesent Street","Outremont","QC","(450) 204-1250","augue@tellusSuspendisse.edu",99972);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Bree","Aguilar","Ap #629-2049 Tristique Avenue","Kitscoty","AB","(587) 693-3224","pharetra.nibh.Aliquam@aptenttaciti.net",99971);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Kalia","Beasley","3421 Nulla Rd.","Stratford","PE","(867) 970-8816","ut.mi.Duis@nondui.edu",99970);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Cairo","Mcgee","9347 Vestibulum Avenue","Camrose","AB","(587) 999-8530","non@ullamcorpervelit.net",99969);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Adam","West","671-8070 Torquent Rd.","Pointe-aux-Trembles","QC","(450) 825-3881","mattis@Fusce.net",99968);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Colby","Tanner","Ap #130-7361 A Rd.","Drumheller","AB","(780) 824-7919","nunc.sed.pede@Nunc.org",99967);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Maggy","Battle","P.O. Box 478, 2788 Eu Rd.","Hudson's Hope","BC","(778) 576-9361","ullamcorper@antebibendum.org",99966);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Kay","Phelps","P.O. Box 517, 3935 Nec Avenue","Cariboo Regional District","BC","(604) 717-8893","iaculis@Namtempordiam.org",99965);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Kathleen","Roth","3230 Dolor Avenue","Price","QC","(579) 855-2278","diam@primis.co.uk",99964);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Brenna","Vaughan","P.O. Box 400, 4572 Tincidunt Avenue","Toronto","ON","(519) 704-0838","luctus.lobortis@felisDonec.net",99963);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Cadman","Everett","Ap #401-3448 Tellus. St.","Saint-L�onard","NB","(506) 350-9919","egestas.Aliquam@Vestibulumuteros.ca",99962);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Jessica","Russo","Ap #900-9652 Curabitur Rd.","Fogo","NL","(709) 760-9402","Aenean@Integertincidunt.co.uk",99961);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Quentin","Gonzalez","766-8989 Sagittis Rd.","Thorold","ON","(249) 571-1688","ipsum.Suspendisse.sagittis@maurisInteger.co.uk",99960);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Laurel","England","1609 Purus Ave","Langenburg","SK","(306) 714-9223","facilisis@ornarelibero.net",99959);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Xerxes","Case","P.O. Box 347, 2009 Non Rd.","Sainte-Flavie","QC","(581) 842-8686","sed.libero@velpedeblandit.org",99958);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Victor","Whitfield","P.O. Box 911, 5544 Odio. Rd.","Richmond Hill","ON","(705) 419-4215","ridiculus@eratin.co.uk",99957);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Jemima","Walter","P.O. Box 742, 6192 Pellentesque Rd.","Owen Sound","ON","(249) 877-7284","vitae.diam@eget.ca",99956);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Hayes","Mcclain","P.O. Box 853, 435 Aliquet Avenue","Regina","SK","(306) 157-8010","tristique@lorem.com",99955);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Tara","Glenn","791-1835 Netus Road","Ajax","ON","(807) 871-5985","dolor.quam@Nunclectuspede.org",99954);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Mason","Roy","Ap #921-9519 Vel, Road","Saint-Laurent","QC","(514) 764-8964","id@ipsumleo.co.uk",99953);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Ursula","Greene","Ap #364-4592 Ligula. Street","Stony Plain","AB","(587) 858-0617","erat.semper.rutrum@massarutrum.net",99952);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Michael","Greene","1170 Tincidunt, St.","Ottawa-Carleton","ON","(365) 997-4681","montes.nascetur.ridiculus@scelerisqueneque.edu",99951);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Mallory","Morrow","P.O. Box 542, 4262 Vel, Street","Lutsel K'e","NT","(867) 632-3196","felis.Nulla.tempor@sapienNunc.edu",99950);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Sybil","Rice","643-2084 Auctor, Rd.","Blind River","ON","(613) 145-5180","metus@nislarcuiaculis.edu",99949);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Yoko","Morse","P.O. Box 966, 9085 Magna St.","Rimbey","AB","(780) 531-7058","Donec.tempor@elitdictumeu.edu",99948);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Nero","Fuller","427-6916 Erat Rd.","Isle-aux-Coudres","QC","(819) 466-7218","amet@arcuimperdiet.edu",99947);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Desiree","Bradford","Ap #489-6883 Magna. St.","Vanier","ON","(705) 745-7437","feugiat@congueelit.com",99946);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Victoria","Barber","Ap #370-3892 Ullamcorper Ave","LaSalle","QC","(450) 126-2334","eget.metus.In@duiin.com",99945);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Ruby","James","2897 Proin Av.","Arviat","NU","(867) 664-8638","malesuada.fames.ac@sapienNuncpulvinar.ca",99944);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Blythe","Baxter","4049 Purus St.","Kingston","ON","(226) 357-6452","viverra.Donec@nec.edu",99943);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Sasha","Hood","552-4955 Urna. Rd.","Whitby","ON","(807) 932-2245","orci.sem.eget@risusNulla.net",99942);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Celeste","Velasquez","4232 Feugiat. Rd.","Annapolis County","NS","(902) 778-3920","dignissim@ametanteVivamus.com",99941);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Maryam","Powers","P.O. Box 498, 3104 Dolor, St.","Stonewall","MB","(204) 704-3123","sollicitudin.a.malesuada@bibendumfermentum.com",99940);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Donovan","Monroe","4294 Consequat, Road","Ottawa-Carleton","ON","(343) 745-7327","in.faucibus@dui.org",99939);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Mona","Gamble","P.O. Box 975, 509 Elit, Avenue","LaSalle","QC","(438) 640-9131","cursus.et.magna@egetdictumplacerat.org",99938);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Derek","Spence","P.O. Box 238, 5969 Volutpat Avenue","St. Catharines","ON","(905) 935-5803","imperdiet@elitCurabitur.com",99937);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Sydnee","Velez","876 Natoque St.","Red Deer","AB","(587) 734-6499","a@nonantebibendum.org",99936);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Dieter","Conner","326-8128 Ante Rd.","Saint-Laurent","QC","(418) 527-7056","Aenean.massa@nunc.ca",99935);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Reed","Bryant","Ap #276-6588 Dictum Ave","Minto","ON","(905) 761-7487","Nulla@adipiscingligula.com",99934);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Levi","Pate","2587 Cras Avenue","Baie-Comeau","QC","(819) 954-2332","urna@in.ca",99933);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Rama","Riley","Ap #984-6049 Sodales. St.","Nanaimo","BC","(778) 512-7972","egestas.a.scelerisque@Duiselementum.net",99932);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Sheila","Parsons","589-4509 Praesent St.","Fernie","BC","(778) 219-9905","quis.tristique@nonummyutmolestie.edu",99931);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Skyler","Wade","6049 Sem Street","Scarborough","ON","(416) 685-4441","egestas.a.scelerisque@ametrisusDonec.edu",99930);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Ian","Stevenson","Ap #513-4742 Leo. Rd.","Leamington","ON","(519) 359-0367","vulputate.velit@quis.ca",99929);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Ryder","Collins","8616 In Street","Beausejour","MB","(431) 557-9081","Mauris.ut@ipsum.org",99928);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Craig","Jackson","2921 Vitae Rd.","Barrie","ON","(343) 774-2448","id@aliquamiaculislacus.net",99927);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Angela","Dillard","3508 Lorem, Av.","Berwick","NS","(902) 307-6667","lectus.quis.massa@nibh.net",99926);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Stewart","Dillard","Ap #891-1811 Tempor St.","Gibbons","AB","(587) 150-5479","non@tincidunttempus.edu",99926);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Nigel","Dillard","Ap #319-2122 Lectus Av.","Gatineau","QC","(418) 103-6125","molestie@orcitincidunt.com",99926);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Myra","Dillard","Ap #526-6113 Sed Av.","Newmarket","ON","(249) 458-8798","a.malesuada.id@anteMaecenasmi.org",99926);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Gray","Blankenship","Ap #633-3790 Volutpat. Ave","Township of Minden Hills","ON","(519) 727-5453","Duis.dignissim.tempor@nequeMorbi.co.uk",99922);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Jesse","Koch","Ap #423-9981 Quis Av.","Newmarket","ON","(226) 348-0620","convallis.erat@nunc.edu",99921);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Vera","Nieves","P.O. Box 153, 5574 Luctus Av.","Burlington","ON","(343) 505-4465","aliquam@Aeneanmassa.co.uk",99920);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Glenna","Leblanc","996-1238 Montes, Rd.","Smoky Lake","AB","(587) 922-1987","aliquet.molestie@ligula.co.uk",99919);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Garrison","Francis","P.O. Box 485, 4987 Non Av.","Shipshaw","QC","(514) 245-1455","Vivamus.nibh.dolor@adipiscingenimmi.edu",99918);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Todd","Haney","8487 Orci Street","Roxboro","QC","(514) 868-4648","dis@Nulla.org",99917);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Arden","Adams","P.O. Box 316, 4400 Lacus. St.","Murdochville","QC","(418) 903-7530","eu@necmaurisblandit.co.uk",99916);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Portia","Rivers","426-8179 Sit Rd.","LaSalle","QC","(819) 728-9693","purus.accumsan@aliquetmolestietellus.org",99915);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Ezra","Powell","P.O. Box 660, 1950 Pede. St.","Thurso","QC","(418) 404-7088","Phasellus.dolor.elit@euismod.net",99914);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Whitney","Camacho","9635 Scelerisque Rd.","Chambord","QC","(581) 762-9110","eget.venenatis.a@egetvolutpatornare.org",99913);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Philip","Cherry","3410 Orci, Rd.","North Bay","ON","(343) 920-2620","eros.turpis@aliquamarcu.com",99912);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Iris","Carson","Ap #882-2813 Aliquet St.","Hearst","ON","(343) 793-8330","semper.cursus.Integer@feugiat.co.uk",99911);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Hilary","Sims","Ap #927-6538 Lacus Road","Township of Minden Hills","ON","(249) 753-0620","velit@nonummy.edu",99910);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Quail","Hester","Ap #874-283 Integer Road","Valcourt","QC","(579) 827-5096","tincidunt@arcuSedet.org",99909);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Harriet","Nolan","335-9309 Nec Rd.","Mount Pearl","NL","(709) 611-6797","nisi@estcongue.com",99908);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Conan","Glover","P.O. Box 843, 4020 Non, St.","Saint John","NB","(506) 980-5817","enim@feugiatSednec.net",99907);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Allen","Garner","453-3379 Sollicitudin Ave","King Township","ON","(807) 196-3123","mollis.Duis.sit@ProinvelitSed.com",99906);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Gannon","Kaufman","425-356 Ante Road","Pemberton","BC","(205) 186-4230","magna@rutrumjustoPraesent.co.uk",99905);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Cecilia","Olsen","967-5706 Pulvinar Street","Shipshaw","QC","(819) 651-2398","eu.erat.semper@blanditcongueIn.org",99904);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Ariana","Rich","198-8153 Mauris St.","Calder","SK","(306) 296-3395","Donec@ut.com",99903);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Christopher","Webster","Ap #725-3809 Velit Street","Cap-de-la-Madeleine","QC","(514) 111-1102","aliquet.magna.a@sodales.co.uk",99902);
insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, email, policy_no) values ("Carolyn","Navarro","747-3045 Bibendum Av.","Charny","QC","(581) 658-3042","libero.lacus@aaliquetvel.net",99901);

--Sale records
--sales are keyed on the primary key of each patient

insert into sales (date, patient, frame, lenses) values ("1994-08-31",1,2,55);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",2,20,80);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",5,23,4);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",4,39,40);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",5,37,93);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",6,35,63);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",7,18,86);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",8,12,17);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",9,9,22);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",10,38,28);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",11,8,66);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",12,39,83);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",13,26,5);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",14,15,73);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",15,16,89);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",16,24,72);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",17,36,46);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",18,22,21);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",19,14,17);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",20,13,43);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",21,5,25);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",22,2,14);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",23,18,23);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",24,13,54);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",25,8,30);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",26,37,51);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",27,31,96);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",28,36,50);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",29,37,40);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",50,9,84);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",51,38,48);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",52,2,51);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",53,26,97);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",54,20,85);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",55,41,14);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",56,41,26);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",57,19,88);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",58,29,98);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",59,14,14);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",40,17,12);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",41,15,62);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",42,25,50);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",43,34,16);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",44,41,86);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",45,20,61);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",46,36,72);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",47,38,16);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",48,39,89);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",49,15,35);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",50,37,2);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",51,18,61);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",52,17,29);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",53,30,11);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",54,24,6);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",55,25,57);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",56,37,65);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",57,5,27);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",58,37,42);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",59,19,11);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",60,4,62);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",61,20,7);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",62,37,77);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",63,29,5);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",64,31,53);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",65,35,85);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",66,29,5);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",67,4,81);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",68,12,38);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",69,36,42);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",70,14,49);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",71,6,11);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",72,34,29);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",73,29,52);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",74,14,70);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",75,7,3);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",76,13,9);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",77,40,88);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",78,7,31);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",79,37,58);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",80,28,87);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",81,5,10);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",82,25,11);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",83,1,79);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",84,27,19);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",85,22,53);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",86,30,92);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",87,41,7);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",88,4,38);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",89,5,68);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",90,7,71);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",91,31,97);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",92,33,3);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",93,3,59);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",94,25,81);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",95,24,51);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",96,22,17);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",97,4,11);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",98,2,83);
insert into sales (date, patient, frame, lenses) values ("2014-08-31",99,19,44);
insert into sales (date, patient, frame, lenses) values ("1994-08-31",100,26,83);
*/
end transaction;
