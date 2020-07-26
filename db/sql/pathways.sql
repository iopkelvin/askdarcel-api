Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1000001, '06-JUN-20', '06-JUN-20', 'Covid-food', 'f', null, 'f');

insert into eligibilities_services (eligibility_id, service_id) 
values (1054, 305);
insert into eligibilities_services (eligibility_id, service_id) 
values (1054, 441);
insert into eligibilities_services (eligibility_id, service_id) 
values (1054, 1871);

insert into eligibilities_services (eligibility_id, service_id) 
values (1008, 2783);
insert into eligibilities_services (eligibility_id, service_id) 
values (1008, 2784);
insert into eligibilities_services (eligibility_id, service_id) 
values (1008, 1871);

insert into eligibilities_services (eligibility_id, service_id) 
values (1020, 2784);
insert into eligibilities_services (eligibility_id, service_id) 
values (1020, 1871);

insert into eligibilities_services (eligibility_id, service_id) 
values (1049, 2759);
insert into eligibilities_services (eligibility_id, service_id) 
values (1049, 291);

insert into categories_services (category_id, service_id) values (1000001, 305);
insert into categories_services (category_id, service_id) values (1000001, 441);
insert into categories_services (category_id, service_id) values (1000001, 86);
insert into categories_services (category_id, service_id) values (1000001, 1871);
insert into categories_services (category_id, service_id) values (1000001, 2783);
insert into categories_services (category_id, service_id) values (1000001, 2784);
insert into categories_services (category_id, service_id) values (1000001, 2579);
insert into categories_services (category_id, service_id) values (1000001, 291);
insert into categories_services (category_id, service_id) values (1000001, 2461);

delete from eligibilities_services where service_id = 441 and eligibility_id = 1001;

delete from eligibilities_services where service_id = 1871 and eligibility_id in (1001,1003,1004,1058,1048,1050);

delete from eligibilities_services where service_id = 2461 and eligibility_id=1058;

delete from eligibilities_services where service_id = 86 and eligibility_id=1058;


Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1000002, '14-JUN-20', '14-JUN-20', 'Covid-hygiene', 'f', null, 'f');

insert into categories (id, created_at, updated_at, name, top_level, 
vocabulary, featured) values 
(1100001, '14-JUN-20', '14-JUN-20', 'Portable Toilents and Hand-Washing Stations', 'f', null, 'f');

insert into categories (id, created_at, updated_at, name, top_level, 
vocabulary, featured) values 
(1100002, '14-JUN-20', '14-JUN-20', 'Hygeine kits', 'f', null, 'f');

insert into categories (id, created_at, updated_at, name, top_level, 
vocabulary, featured) values 
(1100003, '14-JUN-20', '14-JUN-20', 'Showers', 'f', null, 'f');

insert into categories (id, created_at, updated_at, name, top_level, 
vocabulary, featured) values 
(1100004, '14-JUN-20', '14-JUN-20', 'Laundry', 'f', null, 'f');

insert into categories (id, created_at, updated_at, name, top_level, 
vocabulary, featured) values 
(1100005, '14-JUN-20', '14-JUN-20', 'Clothing', 'f', null, 'f');

insert into categories (id, created_at, updated_at, name, top_level, 
vocabulary, featured) values 
(1100006, '14-JUN-20', '14-JUN-20', 'Diaper Bank', 'f', null, 'f');

insert into category_relationships (parent_id, child_id) values 
(1000002,1100001);

insert into category_relationships (parent_id, child_id) values 
(1000002,1100002);

insert into category_relationships (parent_id, child_id) values 
(1000002,1100003);

insert into category_relationships (parent_id, child_id) values 
(1000002,1100004);

insert into category_relationships (parent_id, child_id) values 
(1000002,1100005);

insert into category_relationships (parent_id, child_id) values 
(1000002,1100006);


insert into categories_services (category_id, service_id) values 
(1100002,1278);

insert into categories_services (category_id, service_id) values 
(1100002,1290);

insert into categories_services (category_id, service_id) values 
(1100003,2443);

insert into categories_services (category_id, service_id) values 
(1100003,152);

insert into categories_services (category_id, service_id) values 
(1100004,2444);

insert into categories_services (category_id, service_id) values 
(1100005,310);

insert into categories_services (category_id, service_id) values 
(1100006,2679);



insert into categories_services (category_id, service_id) values 
(1000002,1278);

insert into categories_services (category_id, service_id) values 
(1000002,1290);

insert into categories_services (category_id, service_id) values 
(1000002,2443);

insert into categories_services (category_id, service_id) values 
(1000002,152);

insert into categories_services (category_id, service_id) values 
(1000002,2444);

insert into categories_services (category_id, service_id) values 
(1000002,310);

insert into categories_services (category_id, service_id) values 
(1000002,2679);


Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1000003, '14-JUN-20', '14-JUN-20', 'Covid-finance', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100007, '14-JUN-20', '14-JUN-20', 'Emergency Financial Assistance', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100008, '14-JUN-20', '14-JUN-20', 'Financial assistance for living expenses', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100009, '14-JUN-20', '14-JUN-20', 'Unemployment Insurance-based Benefit Payments', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100010, '14-JUN-20', '14-JUN-20', 'Job Assistance', 'f', null, 'f');

insert into category_relationships (parent_id, child_id) values 
(1000003,1100007);

insert into category_relationships (parent_id, child_id) values 
(1000003,1100008);

insert into category_relationships (parent_id, child_id) values 
(1000003,1100009);

insert into category_relationships (parent_id, child_id) values 
(1000003,1100010);


insert into categories_services (category_id, service_id) values 
(1100007,2666);

insert into categories_services (category_id, service_id) values 
(1100007,2788);

insert into categories_services (category_id, service_id) values 
(1100007,2459);

insert into categories_services (category_id, service_id) values 
(1100008,2751);

insert into categories_services (category_id, service_id) values 
(1100008,2217);

insert into categories_services (category_id, service_id) values 
(1100008,2822);

insert into categories_services (category_id, service_id) values 
(1100008,2002);

insert into categories_services (category_id, service_id) values 
(1100009,2734);

insert into categories_services (category_id, service_id) values 
(1100009,2824);

insert into categories_services (category_id, service_id) values 
(1100010,1070);


insert into categories_services (category_id, service_id) values 
(1000003,2666);

insert into categories_services (category_id, service_id) values 
(1000003,2788);

insert into categories_services (category_id, service_id) values 
(1000003,2459);

insert into categories_services (category_id, service_id) values 
(1000003,2751);

insert into categories_services (category_id, service_id) values 
(1000003,2217);

insert into categories_services (category_id, service_id) values 
(1000003,2822);

insert into categories_services (category_id, service_id) values 
(1000003,2002);

insert into categories_services (category_id, service_id) values 
(1000003,2734);

insert into categories_services (category_id, service_id) values 
(1000003,2824);

insert into categories_services (category_id, service_id) values 
(1000003,1070);





Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1000004, '14-JUN-20', '14-JUN-20', 'Covid-housing', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100011, '14-JUN-20', '14-JUN-20', 'I Received a Written Eviction Notice from my Landlord', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100012, '14-JUN-20', '14-JUN-20', 'I received a Non-Written Eviction Notice from my Landlord and I Want to Know My Rights', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100013, '14-JUN-20', '14-JUN-20', 'Unemployment Insurance-based Benefit Payments', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100014, '14-JUN-20', '14-JUN-20', 'I Missed the Last Rent Payment and I Need Help Paying it', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100015, '14-JUN-20', '14-JUN-20', 'Our Family is Experiencing Homelessness and I Need Subsidies', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100031, '14-JUN-20', '14-JUN-20', 'I am HIV/AIDS Positive and I Need Financial Assistance to Prevent Eviction', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100016, '14-JUN-20', '14-JUN-20', 'I am a Veteran and I Need Financial Assistance for Rent', 'f', null, 'f');



insert into category_relationships (parent_id, child_id) values 
(1000004,1100011);

insert into category_relationships (parent_id, child_id) values 
(1000004,1100012);

insert into category_relationships (parent_id, child_id) values 
(1000004,1100013);

insert into category_relationships (parent_id, child_id) values 
(1000004,1100014);

insert into category_relationships (parent_id, child_id) values 
(1000004,1100015);

insert into category_relationships (parent_id, child_id) values 
(1000004,1100016);

insert into category_relationships (parent_id, child_id) values 
(1000004,1100031);



insert into categories_services (category_id, service_id) values 
(1100011,2215);

insert into categories_services (category_id, service_id) values 
(1100012,959);

insert into categories_services (category_id, service_id) values 
(1100012,2209);

insert into categories_services (category_id, service_id) values 
(1100012,1134);

insert into categories_services (category_id, service_id) values 
(1100012,2833);

insert into categories_services (category_id, service_id) values 
(1100012,922);

insert into categories_services (category_id, service_id) values 
(1100013,2217);

insert into categories_services (category_id, service_id) values 
(1100014,2822);

insert into categories_services (category_id, service_id) values 
(1100014,2833);

insert into categories_services (category_id, service_id) values 
(1100014,2217);

insert into categories_services (category_id, service_id) values 
(1100015,1186);

insert into categories_services (category_id, service_id) values 
(1100031,2029);

insert into categories_services (category_id, service_id) values 
(1100031,2751);

insert into categories_services (category_id, service_id) values 
(1100031,2782);

insert into categories_services (category_id, service_id) values 
(1100016,298);

insert into categories_services (category_id, service_id) values 
(1100016,1039);

insert into categories_services (category_id, service_id) values 
(1100016,325);

insert into categories_services (category_id, service_id) values 
(1000004,2215);

insert into categories_services (category_id, service_id) values 
(1000004,959);

insert into categories_services (category_id, service_id) values 
(1000004,2209);

insert into categories_services (category_id, service_id) values 
(1000004,1134);

insert into categories_services (category_id, service_id) values 
(1000004,2833);

insert into categories_services (category_id, service_id) values 
(1000004,922);

insert into categories_services (category_id, service_id) values 
(1000004,2217);

insert into categories_services (category_id, service_id) values 
(1000004,2822);

insert into categories_services (category_id, service_id) values 
(1000004,2833);

insert into categories_services (category_id, service_id) values 
(1000004,2217);

insert into categories_services (category_id, service_id) values 
(1000004,1186);

insert into categories_services (category_id, service_id) values 
(1000004,2029);

insert into categories_services (category_id, service_id) values 
(1000004,2751);

insert into categories_services (category_id, service_id) values 
(1000004,2782);

insert into categories_services (category_id, service_id) values 
(1000004,298);

insert into categories_services (category_id, service_id) values 
(1000004,1039);

insert into categories_services (category_id, service_id) values 
(1000004,325);






Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1000005, '14-JUN-20', '14-JUN-20', 'Covid-health', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100017, '14-JUN-20', '14-JUN-20', 'Coronavirus (COVID-19) Testing', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100018, '14-JUN-20', '14-JUN-20', 'Coronavirus-Related Urgent Care', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100019, '14-JUN-20', '14-JUN-20', 'Other Medical Services', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100020, '14-JUN-20', '14-JUN-20', 'Mental Health Urgent Care', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100021, '14-JUN-20', '14-JUN-20', 'Other Mental Health Services', 'f', null, 'f');

insert into category_relationships (parent_id, child_id) values 
(1000005,1100017);

insert into category_relationships (parent_id, child_id) values 
(1000005,1100018);

insert into category_relationships (parent_id, child_id) values 
(1000005,1100019);

insert into category_relationships (parent_id, child_id) values 
(1000005,1100020);

insert into category_relationships (parent_id, child_id) values 
(1000005,1100021);

insert into categories_services (category_id, service_id) values 
(1100017,2841);

insert into categories_services (category_id, service_id) values 
(1100017,2843);

insert into categories_services (category_id, service_id) values 
(1100017,2845);

insert into categories_services (category_id, service_id) values 
(1100017,2846);

insert into categories_services (category_id, service_id) values 
(1100017,2847);

insert into categories_services (category_id, service_id) values 
(1100017,1455);

insert into categories_services (category_id, service_id) values 
(1100017,2848);

insert into categories_services (category_id, service_id) values 
(1100018,1323);

insert into categories_services (category_id, service_id) values 
(1100019,199);

insert into categories_services (category_id, service_id) values 
(1100019,2842);

insert into categories_services (category_id, service_id) values 
(1100020,2844);

insert into categories_services (category_id, service_id) values 
(1100020,101);

insert into categories_services (category_id, service_id) values 
(1100020,236);

insert into categories_services (category_id, service_id) values 
(1100021,2564);

insert into categories_services (category_id, service_id) values 
(1100021,889);

insert into categories_services (category_id, service_id) values 
(1000005,2841);

insert into categories_services (category_id, service_id) values 
(1000005,2843);

insert into categories_services (category_id, service_id) values 
(1100005,2845);

insert into categories_services (category_id, service_id) values 
(1000005,2846);

insert into categories_services (category_id, service_id) values 
(1000005,2847);

insert into categories_services (category_id, service_id) values 
(1000005,1455);

insert into categories_services (category_id, service_id) values 
(1000005,2848);

insert into categories_services (category_id, service_id) values 
(1000005,1323);

insert into categories_services (category_id, service_id) values 
(1000005,199);

insert into categories_services (category_id, service_id) values 
(1000005,2842);

insert into categories_services (category_id, service_id) values 
(1000005,2844);

insert into categories_services (category_id, service_id) values 
(1000005,101);

insert into categories_services (category_id, service_id) values 
(1000005,236);

insert into categories_services (category_id, service_id) values 
(1000005,2564);

insert into categories_services (category_id, service_id) values 
(1000005,889);








Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1000006, '14-JUN-20', '14-JUN-20', 'Covid-domesticviolence', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100022, '14-JUN-20', '14-JUN-20', 'Temporary Shelter for Women', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100023, '14-JUN-20', '14-JUN-20', 'Transitional Housing for Women', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100024, '14-JUN-20', '14-JUN-20', 'Legal Assistance', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100025, '14-JUN-20', '14-JUN-20', 'Domestic Violence Counseling', 'f', null, 'f');

insert into category_relationships (parent_id, child_id) values 
(1000006,1100022);

insert into category_relationships (parent_id, child_id) values 
(1000006,1100023);

insert into category_relationships (parent_id, child_id) values 
(1000006,1100024);

insert into category_relationships (parent_id, child_id) values 
(1000006,1100025);


insert into categories_services (category_id, service_id) values 
(1100022,194);

insert into categories_services (category_id, service_id) values 
(1100022,36);

insert into categories_services (category_id, service_id) values 
(1100022,239);

insert into categories_services (category_id, service_id) values 
(1100022,569);


insert into categories_services (category_id, service_id) values 
(1100023,1593);

insert into categories_services (category_id, service_id) values 
(1100023,1753);

insert into categories_services (category_id, service_id) values 
(1100024,2623);

insert into categories_services (category_id, service_id) values 
(1100024,2849);

insert into categories_services (category_id, service_id) values 
(1100024,2850);

insert into categories_services (category_id, service_id) values 
(1100025,2792);

insert into categories_services (category_id, service_id) values 
(1100025,230);

insert into categories_services (category_id, service_id) values 
(1100025,2510);


insert into categories_services (category_id, service_id) values 
(1000006,194);

insert into categories_services (category_id, service_id) values 
(1000006,36);

insert into categories_services (category_id, service_id) values 
(1000006,239);

insert into categories_services (category_id, service_id) values 
(1000006,569);


insert into categories_services (category_id, service_id) values 
(1000006,1593);

insert into categories_services (category_id, service_id) values 
(1000006,1753);

insert into categories_services (category_id, service_id) values 
(1000006,2623);

insert into categories_services (category_id, service_id) values 
(1000006,2849);

insert into categories_services (category_id, service_id) values 
(1000006,2850);

insert into categories_services (category_id, service_id) values 
(1000006,2792);

insert into categories_services (category_id, service_id) values 
(1000006,230);

insert into categories_services (category_id, service_id) values 
(1000006,2510);



Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1000007, '14-JUN-20', '14-JUN-20', 'Covid-internet', 'f', null, 'f');






Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1000008, '14-JUN-20', '14-JUN-20', 'Covid-lgbtqa', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100026, '14-JUN-20', '14-JUN-20', 'Housing Assistance', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100027, '14-JUN-20', '14-JUN-20', 'Legal Assistance ', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100028, '14-JUN-20', '14-JUN-20', 'Youth Services', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100029, '14-JUN-20', '14-JUN-20', 'Counseling Assistance', 'f', null, 'f');

Insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1100030, '14-JUN-20', '14-JUN-20', 'General Help', 'f', null, 'f');

insert into category_relationships (parent_id, child_id) values 
(1000008,1100026);

insert into category_relationships (parent_id, child_id) values 
(1000008,1100027);

insert into category_relationships (parent_id, child_id) values 
(1000008,1100028);

insert into category_relationships (parent_id, child_id) values 
(1000008,1100029);

insert into category_relationships (parent_id, child_id) values 
(1000008,1100030);

insert into categories_services (category_id, service_id) values 
(1100026,2028);

insert into categories_services (category_id, service_id) values 
(1100026,2751);

insert into categories_services (category_id, service_id) values 
(1100027,2855);

insert into categories_services (category_id, service_id) values 
(1100027,935);

insert into categories_services (category_id, service_id) values 
(1100028,2856);

insert into categories_services (category_id, service_id) values 
(1100028,2780);

insert into categories_services (category_id, service_id) values 
(1100028,2094);

insert into categories_services (category_id, service_id) values 
(1100029,2094);

insert into categories_services (category_id, service_id) values 
(1100029,2510);

insert into categories_services (category_id, service_id) values 
(1100029,1901);

insert into categories_services (category_id, service_id) values 
(1100030,1387);

insert into categories_services (category_id, service_id) values 
(1100030,2857);

insert into categories_services (category_id, service_id) values 
(1100030,1718);

insert into categories_services (category_id, service_id) values 
(1000008,2028);

insert into categories_services (category_id, service_id) values 
(1000008,2751);

insert into categories_services (category_id, service_id) values 
(1000008,2855);

insert into categories_services (category_id, service_id) values 
(1000008,935);

insert into categories_services (category_id, service_id) values 
(1000008,2856);

insert into categories_services (category_id, service_id) values 
(1000008,2780);

insert into categories_services (category_id, service_id) values 
(1000008,2094);

insert into categories_services (category_id, service_id) values 
(1000008,2094);

insert into categories_services (category_id, service_id) values 
(1000008,2510);

insert into categories_services (category_id, service_id) values 
(1000008,1901);

insert into categories_services (category_id, service_id) values 
(1000008,1387);

insert into categories_services (category_id, service_id) values 
(1000008,2857);

insert into categories_services (category_id, service_id) values 
(1000008,1718);

insert into categories_services (category_id, service_id) values (1000007, 106);

update eligibilities set name = 'I am someone with disabilities' where name = 'Physical Disability';

update eligibilities set name = 'I am a Senior' where name = 'Seniors (55+ years old)';

update eligibilities set name = 'I am someone experiencing homelessness' where name = 'Homeless';

update eligibilities set name = 'I live with someone under 18 years of age' where name = 'Families';








