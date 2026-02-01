-- Створюємо базу даних
create database SaratovcevL21;

-- Вибираємо створену базу даних
use SaratovcevL21;

-- Створюємо таблицю customers в базі даних SaratovcevL21
create table customers (
-- INT: Ціле число, ідеальне для ідентифікаторів.
id int primary key auto_increment,

-- VARCHAR(50): Оптимально для імен. Економить місце, бо займає стільки байтів, скільки літер у слові.
full_name varchar(50) not null,

-- VARCHAR(255): Стандартна довжина для URL та Email
email varchar(255) not null unique,

-- VARCHAR(20): Номери телефонів не є числами для математичних операцій,
phone varchar(20),

-- TEXT: На відміну від VARCHAR, дозволяє зберігати дуже довгі описи адреси без жорстких обмежень.
address text,

-- VARCHAR(10): Поштовий індекс може містити літери, тому тип INT тут не підходить.
zip_code varchar(10),

-- VARCHAR(50): Достатньо для назви будь-якої країни світу.
country varchar(50),

-- ENUM: Вибрав для полів з чітким переліком варіантів. Забороняє введення будь-яких інших значень, крім вказаних.
gender ENUM('Чоловік', 'Жінка', 'Інша'),

-- DATE: Зберігає лише рік-місяць-день. Найбільш ефективний тип для дат реєстрації чи днів народження.
registered_on date not null,

-- BOOLEAN: Зберігає лише 0 або 1 (так/ні).
is_active boolean not null default true
);

-- Додаємо 10 записів
insert into customers (full_name, email, phone, address, zip_code, country, gender, registered_on, is_active) value
	('Олексій Петренко', 'oleksii@example.com', '+380501112233', 'вул. Хрещатик, 1', '01001', 'Україна', 'Чоловік', '2023-01-15', true),
	('Марія Коваленко', 'mariya@example.com', '+380671112233', 'пр-т Перемоги, 12', '02000', 'Україна', 'Жінка', '2023-02-10', true),
	('Іван Сидоренко', 'ivan@example.com', '+380931112233', 'вул. Сумська, 5', '61000', 'Україна', 'Чоловік', '2023-03-05', false),
	('Олена Мельник', 'olena@example.com', '+380502223344', 'вул. Дерибасівська, 10', '65000', 'Україна', 'Жінка', '2023-04-20', true),
	('Дмитро Бондар', 'dmytro@example.com', '+380672223344', 'вул. Соборна, 44', '21000', 'Україна', 'Чоловік', '2023-05-12', true),
	('Анна Ткаченко', 'anna@example.com', '+380932223344', 'вул. Галицька, 3', '79000', 'Україна', 'Жінка', '2023-06-01', false),
	('Сергій Кравченко', 'sergiy@example.com', '+380503334455', 'вул. Миру, 21', '49000', 'Україна', 'Чоловік', '2023-07-18', true),
	('Тетяна Шевченко', 'tetyana@example.com', '+380673334455', 'вул. Лесі Українки, 7', '43000', 'Україна', 'Жінка', '2023-08-25', true),
	('Андрій Мороз', 'andriy@example.com', '+380933334455', 'пр-т Свободи, 15', '79001', 'Україна', 'Чоловік', '2023-09-30', true),
	('Наталія Павленко', 'natali@example.com', '+380504445566', 'вул. Полтавська, 8', '36000', 'Україна', 'Жінка', '2024-01-05', false);

-- Виводимо усі дані
select * from customers;

-- Створюємо таблицю orders в базі даних SaratovcevL21
create table orders (
-- INT: Ціле число. AUTO_INCREMENT дозволяє не думати про нумерацію замовлень вручну.
id int primary key auto_increment,

-- INT: Це поле зв'язку. Воно має бути того ж типу, що і id в таблиці customers.
customer_id int not null,

-- DATETIME: щоб бачити і дату, і точний час покупки
order_date datetime not null,

-- VARCHAR(255): оптимально для повної адреси доставки
shipping_address VARCHAR(255) NOT NULL,

-- DECIMAL(10,2): Для грошей тип INT (цілі числа) не підходить, бо не дозволяє копійки. 10 — це загальна кількість цифр, 2 — цифри після коми.
total_amount decimal(10, 2) not null,

-- ENUM: Обмежує статус замовлення конкретним списком, що виключає помилки вводу.
-- DEFAULT 'new': Кожне нове замовлення автоматично стає "новим".
status ENUM('new', 'in progress', 'completed', 'cancelled') NOT NULL DEFAULT 'new',

-- FOREIGN KEY: Встановлює зв'язок між таблицями. 
-- Якщо видалити клієнта, ми можемо автоматично обробити його замовлення (наприклад, заборонити видалення).
foreign key(customer_id) references customers(id) on delete cascade
);

-- Додаємо 10 замовлень
insert into orders (customer_id, order_date, total_amount, shipping_address, status) value
	(1, '2023-11-01 10:30:00', 1250.50, 'Київ, вул. Хрещатик, 1', 'completed'), -- Олексій (1-ше замовлення)
	(1, '2023-12-05 14:20:00', 450.00, 'Київ, вул. Хрещатик, 1', 'completed'), -- Олексій (2-ге замовлення)
	(2, '2023-11-10 09:15:00', 2100.00, 'Київ, пр-т Перемоги, 12', 'completed'), -- Марія (1-ше замовлення)
	(2, '2024-01-12 18:45:00', 890.30, 'Київ, пр-т Перемоги, 12', 'new'),      -- Марія (2-ге замовлення)
	(4, '2023-11-20 11:00:00', 3200.99, 'Одеса, вул. Дерибасівська, 10', 'completed'), -- Олена (1-ше замовлення)
	(4, '2023-12-15 15:30:00', 150.00, 'Одеса, вул. Дерибасівська, 10', 'cancelled'),   -- Олена (2-ге замовлення)
	(4, '2024-01-20 12:00:00', 550.00, 'Одеса, вул. Дерибасівська, 10', 'in progress'),-- Олена (3-тє замовлення)
	(5, '2023-12-25 20:10:00', 120.00, 'Вінниця, вул. Соборна, 44', 'completed'),
	(7, '2024-01-05 16:40:00', 999.99, 'Дніпро, вул. Миру, 21', 'in progress'),
	(9, '2024-01-22 10:00:00', 4500.00, 'Львів, пр-т Свободи, 15', 'new');

-- Виводимо просто всі дані з таблиці orders
select * from orders;

-- Додаємо поле city до customers
alter table customers add column city varchar(50);

-- Оновлюємо поле city та заповнюємо його
update customers set city = 'Київ' where id in (1, 2);
update customers set city = 'Харків' where id = 3;
update customers set city = 'Одеса' where id = 4;
update customers set city = 'Вінниця' where id = 5;
update customers set city = 'Івано-Франківськ' where id = 6;
update customers set city = 'Дніпро' where id = 7;
update customers set city = 'Луцьк' where id = 8;
update customers set city = 'Львів' where id = 9;
update customers set city = 'Полтава' where id = 10;

-- Виведемо основні поля разом із новим полем city, щоб переконатися, що все заповнено вірно.
select id, full_name, email, city, country from customers;

-- Додаємо поле birthday в таблицю customers
alter table customers add column birthday date;

-- Оновимо дані для трьох різних клієнтів, щоб протестувати різні дати
update customers set birthday = '1990-05-15' where id = 1;
update customers set birthday = '1995-10-20' where id = 2;
update customers set birthday = '1988-03-08' where id = 4;

-- Виводимо всі дані, щоб побачити нову колонку та заповнені значення.
select * from customers;

-- Додаємо нове поле payment_method в таблицю orders
alter table orders add column payment_method varchar(20);

-- Використовуємо варіант 'credit_card'
update orders set payment_method = 'credit_card' where id in (1, 3, 5);

-- Використовуємо варіант 'cash'
update orders set payment_method = 'cash' where id in (2, 8);

-- Використовуємо варіант 'paypal'
update orders set payment_method = 'paypal' where id in (4, 10);

-- Виводимо лише ідентифікатор замовлення та метод оплати,
select id as order_id, payment_method from orders;