CREATE OR REPLACE FUNCTION password_checker()
    RETURNS TRIGGER
    AS
    $$
    BEGIN
        IF NEW.password IS NULL OR NEW.password = '' THEN
            NEW.password = generate_password();
        END IF;
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION generate_password()
    RETURNS CHAR(8)
    AS
    $$
    DECLARE
        generate_password VARCHAR;
    BEGIN
        FOR chr IN 1..8 LOOP
            IF chance_for_letter() = TRUE THEN
                generate_password := CONCAT(generate_password,  get_random_char(true));
            ELSE
                generate_password := CONCAT(generate_password,get_random_char(false));
            END IF;
            END LOOP;
        RETURN generate_password;
    END;
    $$ language plpgsql;


CREATE OR REPLACE FUNCTION chance_for_letter()
    RETURNS boolean
    AS
    $$
    BEGIN
        RETURN floor(random()* (2));
    END;
    $$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION get_random_char(is_letter boolean)
    RETURNS CHAR(1)
    AS
    $$
    DECLARE
        range_from SMALLINT;
        range_to SMALLINT;
        random_number SMALLINT;
    BEGIN
        IF is_letter THEN
            range_from:= 63;
            range_to:= 122;
        ELSE
            range_from:=48;
            range_to:=57;
        END IF;
        random_number := floor(random()* (range_to-range_from+1)+range_from);
        RETURN CHR(random_number);
    END;
    $$ LANGUAGE PLPGSQL;


CREATE TRIGGER IU_password_check
    BEFORE INSERT OR UPDATE
    ON "user"
    FOR EACH ROW
    EXECUTE PROCEDURE password_checker();






