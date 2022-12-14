SELECT * FROM vendors ORDER BY vendor_id;
SELECT * FROM parts ORDER BY part_id;
SELECT * FROM vendor_parts;

-- blob
/*
Standard SQL defines BLOB as the binary large object for storing binary data in the database. 
With the BLOB data type, you can store the content of a picture, a document, etc. into the table.
PostgreSQL does not support BLOB but you can use the BYTEA data type for storing the binary data.
*/
SELECT * FROM part_drawings;

-- function
CREATE OR REPLACE FUNCTION get_parts_by_vendor(id integer)
  RETURNS TABLE(part_id INTEGER, part_name VARCHAR) AS
$$
BEGIN
 RETURN QUERY

 SELECT parts.part_id, parts.part_name
 FROM parts
 INNER JOIN vendor_parts on vendor_parts.part_id = parts.part_id
 WHERE vendor_id = id;

END; $$

LANGUAGE plpgsql;


SELECT get_parts_by_vendor(1);


-- procedure
CREATE OR REPLACE PROCEDURE add_new_part(
	new_part_name varchar,
	new_vendor_name varchar
) 
AS $$
DECLARE
	v_part_id INT;
	v_vendor_id INT;
BEGIN
	-- insert into the parts table
	INSERT INTO parts(part_name) 
	VALUES(new_part_name) 
	RETURNING part_id INTO v_part_id;
	
	-- insert a new vendor
	INSERT INTO vendors(vendor_name)
	VALUES(new_vendor_name)
	RETURNING vendor_id INTO v_vendor_id;
	
	-- insert into vendor_parts
	INSERT INTO vendor_parts(part_id, vendor_id)
	VALUEs(v_part_id,v_vendor_id);
	
END;
$$
LANGUAGE PLPGSQL;
