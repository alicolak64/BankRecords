USE databasegroupproject;
SELECT * FROM CUSTOMER_INFO cus LEFT JOIN ACCOUNT_INFO acc ON cus.ID = acc.ID
LEFT JOIN TRANSFER_DATA tra ON tra.transfer_from = acc.iban 
LEFT JOIN VIRMAN_DATA vir ON vir.virman_from = acc.iban 
LEFT JOIN BRANCH_INFO bra ON bra.branch_No = acc.branch
LEFT JOIN CURRENCY_INFO cur ON cur.currency_code = acc.currency_code
LEFT JOIN DEBIT_CARD_INFO deb ON deb.iban = acc.iban
LEFT JOIN CREDIT_CARD_INFO cre ON cre.ID = acc.ID 
;