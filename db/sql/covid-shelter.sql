-- Covid Shelter Category
insert into categories (id, created_at, updated_at, name, top_level, vocabulary, featured) values 
(1000010, '04-OCT-20', '04-OCT-20', 'Covid-shelter', 'f', null, 'f');

insert into categories_services (category_id, service_id) values (1000010, 2559);
insert into categories_services (category_id, service_id) values (1000010, 2560);
insert into categories_services (category_id, service_id) values (1000010, 228);
insert into categories_services (category_id, service_id) values (1000010, 49);
insert into categories_services (category_id, service_id) values (1000010,2872);
insert into categories_services (category_id, service_id) values (1000010, 2032);
insert into categories_services (category_id, service_id) values (1000010, 2030);
insert into categories_services (category_id, service_id) values (1000010, 719);
insert into categories_services (category_id, service_id) values (1000010, 2781);
insert into categories_services (category_id, service_id) values (1000010, 306);
insert into categories_services (category_id, service_id) values (1000010, 2670);

--  Saw this in pathways and not sure if applicable for covid-shelter's eligibility
-- update eligibilities set name = 'We are a family and we need shelter' where name = 'Families';
-- update eligibilities set name = 'I am someone between 18-24 years old in need of shelter' where name = 'Youth';
-- update eligibilities set name = 'I am a single adult and I need shelter' where name = 'Single Adult';



