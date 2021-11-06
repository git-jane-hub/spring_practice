CREATE TABLE pay_tbl(
    merchant_uid VARCHAR(100) NOT NULL PRIMARY KEY,
    itemName VARCHAR(100) NOT NULL,
    amount NUMBER NOT NULL  
);

SELECT * FROM pay_tbl;

COMMIT;