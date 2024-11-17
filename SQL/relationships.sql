create table creates (
    administration id_type,
    supplier id_type,
    primary key (administration, supplier),
    foreign key (administration) references administration(employeeid) on delete cascade,    
    foreign key (supplier) references supplier(supplier_id) on delete cascade
);

create table cooks (
    chef id_type,
    time_to_make time,
    meal id_type,
    primary key (meal, chef),
    foreign key (chef) references chef(employeeid) on delete cascade,  
    foreign key (meal) references meal(meal_name) on delete cascade
);

create table composed_of (
    menu_id id_type,
    meal_name name_type,
    primary key (menu_id, meal_name),
    foreign key (menu_id) references menu(menu_id) on delete cascade,  
    foreign key (meal_name) references meal(meal_name) on delete cascade
);

create table supplies (
    ingredient id_type,
    supplier id_type,
    supp_cost money_type not null,
    delivery_time time not null,
    contract_until date,
    primary key (ingredient, supplier),
    foreign key (ingredient) references ingredient(inventory_id) on delete cascade,  
    foreign key (supplier) references supplier(supplier_id) on delete cascade
);
