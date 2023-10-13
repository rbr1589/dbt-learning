CREATE OR REPLACE FUNCTION convert_to_integer(year_value text, component_value text)
RETURNS INTEGER AS $$
DECLARE v_int_value INTEGER DEFAULT NULL;
BEGIN
IF (year_value is NULL) THEN
    RETURN NULL
END;
ELSE
    BEGIN
	    v_int_value := year_value::INTEGER;
    	EXCEPTION WHEN OTHERS THEN
            RAISE NOTICE 'Invalid integer value: "%".  Returning component value for year.', year_value;
            RETURN convert_to_integer(component_value, NULL);
        END;
    RETURN year_value;
    END IF;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION get_component(text,text, text);

CREATE OR REPLACE FUNCTION get_component(year_value text, component_value text, network_value text)
RETURNS VARCHAR AS $$
DECLARE v_int_value INTEGER DEFAULT NULL;
BEGIN
IF (component_value is NULL) THEN
        RETURN NULL
    END;
ELSE
    BEGIN
        v_int_value := year_value::INTEGER;
        EXCEPTION WHEN OTHERS THEN
            RAISE NOTICE 'Invalid integer value: "%".  Returning network value for component.', year_value;
            RETURN network_value;
        END;
    RETURN component_value;
    END IF;
END;
$$ LANGUAGE plpgsql;


DROP FUNCTION get_network(text,text);

CREATE OR REPLACE FUNCTION get_network(year_value text, network_value text)
RETURNS VARCHAR AS $$
DECLARE v_int_value INTEGER DEFAULT NULL;
BEGIN
IF (network_value is NULL) THEN
        RETURN NULL
    END;
ELSE
    BEGIN
        v_int_value := year_value::INTEGER;
        EXCEPTION WHEN OTHERS THEN
            RAISE NOTICE 'Invalid integer value: "%".  Returning year value for network.', year_value;
            RETURN year_value;
        END;
    RETURN network_value;
    END IF;
END;
$$ LANGUAGE plpgsql;