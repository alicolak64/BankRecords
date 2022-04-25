use databasegroupproject ;
CREATE TABLE CUSTOMER_INFO ( 
id VARCHAR(11) NOT NULL ,
name VARCHAR(50) NOT NULL,
surname VARCHAR(50) NOT NULL,
phone CHAR(10) ,
email VARCHAR(50) CHECK (email LIKE '%@%.%') ,
city VARCHAR(50) NOT NULL ,
findex int DEFAULT 1 NOT NULL CHECK (findex >= 1 AND findex <= 1900) ,
UNIQUE (phone,email) ,
PRIMARY KEY (id) 
) ;

use databasegroupproject ;
CREATE TABLE BRANCH_INFO ( 
branch_no CHAR(4) CHECK (branch_no LIKE 'B%') ,
name VARCHAR(50) ,
daily_money int CHECK (daily_money > 100000) ,
PRIMARY KEY (branch_no) 
) ;


use databasegroupproject ;
CREATE TABLE CURRENCY_INFO (
currency_code CHAR(3) ,
currency_name VARCHAR(50) NOT NULL ,
UNIQUE (currency_name) ,
PRIMARY KEY (currency_code)
) ;



use databasegroupproject ;
CREATE TABLE ACCOUNT_INFO (
iban CHAR(5) CHECK (iban LIKE 'TR%') , 
id VARCHAR(11) NOT NULL ,
account_num VARCHAR(7) NOT NULL CHECK (account_num LIKE 'P%' OR account_num LIKE 'C%') ,
balance int NOT NULL DEFAULT 0 CHECK (balance >= 0) ,
currency_code CHAR(3) NOT NULL ,
branch CHAR(4) NOT NULL CHECK (branch LIKE 'B%') ,
time_deposit CHAR(1) NOT NULL DEFAULT 'F' CHECK (time_deposit = 'T' OR time_deposit = 'F') ,
FOREIGN KEY (id) REFERENCES customer_info(id) ,
FOREIGN KEY (currency_code) REFERENCES currency_info(currency_code) ,
FOREIGN KEY (branch) REFERENCES branch_info(branch_no) ,
PRIMARY KEY (iban)
) ;


use databasegroupproject ;
CREATE TABLE DEPOSIT_DATA (
deposit_code CHAR(4) CHECK (deposit_code LIKE 'D%') ,
amount int CHECK (amount > 0) , 
atm CHAR(3) ,
date DATETIME ,
branch CHAR (5) CHECK (branch LIKE 'B%') ,
PRIMARY KEY (deposit_code) 
) ;


use databasegroupproject ;
CREATE TABLE WITHDRAW_DATA (
withdraw_code CHAR(4) CHECK (withdraw_code LIKE 'W%') ,
amount int CHECK (amount > 0) , 
atm CHAR(3) ,
branch CHAR (5) CHECK (branch LIKE 'B%') ,
date DATETIME ,
PRIMARY KEY (withdraw_code) 
) ;


CREATE TABLE TRANSFER_DATA (
transfer_code CHAR(4) CHECK (transfer_code LIKE 'T%') ,
transfer_from CHAR(5) CHECK (transfer_from LIKE 'TR%'),
transfer_to CHAR(5) CHECK (transfer_to LIKE 'TR%'),
amount int CHECK (amount > 0),
date DATETIME,
type VARCHAR(50) CHECK (type IN ('Residence','E-Commerce Payment','Other Rents','Workplace Rent','Other Payments')), 
FOREIGN KEY (transfer_from) REFERENCES account_info(iban) ON DELETE CASCADE,
FOREIGN KEY (transfer_to) REFERENCES account_info(iban) ON DELETE CASCADE,
PRIMARY KEY (transfer_code) 
) ;


use databasegroupproject ;
CREATE TABLE VIRMAN_DATA (
virman_code CHAR(4) CHECK (virman_code LIKE 'V%')  ,
virman_from CHAR(5) CHECK (virman_from LIKE 'TR%') ,
virman_to CHAR(5) CHECK (virman_to LIKE 'TR%') ,
amount int CHECK (amount > 0) ,
date DATETIME,
FOREIGN KEY (virman_from) REFERENCES account_info(iban) ON DELETE CASCADE,
FOREIGN KEY (virman_to) REFERENCES account_info(iban) ON DELETE CASCADE,
PRIMARY KEY (virman_code) 
) ;


use databasegroupproject ;
CREATE TABLE DEBIT_CARD_INFO (
card_no CHAR(16) ,
iban CHAR(5) CHECK (iban LIKE 'TR%') , 
valid_thru DATE ,
cvv CHAR(3) ,
nfc_no CHAR(11) CHECK (nfc_no LIKE '__:__:__:__'),
FOREIGN KEY (iban) REFERENCES account_info(iban) ,
PRIMARY KEY (card_no)
) ;


use databasegroupproject ;
CREATE TABLE CREDIT_CARD_INFO (
card_no CHAR(16) ,
id VARCHAR(11) NOT NULL ,
valid_thru DATE ,
cvv CHAR(3) ,
nfc_no CHAR(11) CHECK (nfc_no LIKE '__:__:__:__'),
card_limit int DEFAULT 1000 CHECK (card_limit > 250) ,
FOREIGN KEY (id) REFERENCES account_info(id) ,
PRIMARY KEY (card_no)
) ;