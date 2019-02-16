
CREATE or replace FUNCTION validatePesel(pesel varchar(11)) RETURNS boolean AS $$
DECLARE
  i INTEGER ;
  isValid boolean := false ;
  letter varchar(1) ;
  sum INTEGER := 0;
  number INTEGER ;
BEGIN
  IF LENGTH(pesel) = 11 THEN
    FOR i IN 1..10 LOOP
      letter := SUBSTRING(pesel, i, 1) ;
      number := TO_NUMBER(letter, '9');
      WHILE i > 4 LOOP
      i := i - 4;
      END LOOP ;
      CASE i
        WHEN 1 then
          sum := sum + number;
        WHEN 2 THEN
          sum := sum + number * 3;
        when 3 then
          sum := sum + number * 7;
        when 4 then
          sum := sum + number * 9;
      END CASE;
    END LOOP;
    letter := SUBSTRING(pesel, 11, 1);
    number := TO_NUMBER(letter, '9');
    sum := sum % 10;
    if sum = 0 AND sum = number then
        isValid := true;
    elsif number = 10 - sum then
      isValid := true;
    else
      isValid := false;
    end if;
  end if;
    return isValid;
END; $$
LANGUAGE PLPGSQL;
