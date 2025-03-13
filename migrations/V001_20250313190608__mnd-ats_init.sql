-- Run this Script as an admin user - suresh@mndsys.com 
-- use this command to get the token once logged into az portal
-- az account get-access-token --resource https://ossrdbms-aad.database.windows.net
-- Set that Bearer token as password in pgAdmin
BEGIN ;

CREATE SEQUENCE IF NOT EXISTS public.contactus_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE TABLE IF NOT EXISTS public.contactus
(
    id integer NOT NULL DEFAULT nextval('contactus_id_seq'::regclass),
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    email character varying(255) COLLATE pg_catalog."default" NOT NULL,
    message text COLLATE pg_catalog."default" NOT NULL,
    createddate TIMESTAMP WITH TIME ZONE DEFAULT (now() AT TIME ZONE 'UTC'),
    CONSTRAINT contactus_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER SEQUENCE public.contactus_id_seq OWNED BY public.contactus.id;


-- SEQUENCE: public.postedjob_id_seq

-- DROP SEQUENCE IF EXISTS public.postedjob_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.postedjob_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE TABLE IF NOT EXISTS public.postedjob
(
    id integer NOT NULL DEFAULT nextval('postedjob_id_seq'::regclass),
    title character varying(255) COLLATE pg_catalog."default" NOT NULL,
    location character varying(255) COLLATE pg_catalog."default" NOT NULL,
    contactname character varying(255) COLLATE pg_catalog."default" NOT NULL,
    phone character varying(50) COLLATE pg_catalog."default",
    email character varying(255) COLLATE pg_catalog."default",
    description text COLLATE pg_catalog."default",
	createddate TIMESTAMP WITH TIME ZONE DEFAULT (now() AT TIME ZONE 'UTC'),
    CONSTRAINT postedjob_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER SEQUENCE public.postedjob_id_seq OWNED BY public.postedjob.id;


CREATE SEQUENCE IF NOT EXISTS public.uploadedfiles_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;


CREATE TABLE IF NOT EXISTS public.uploadedfiles
(
    id integer NOT NULL DEFAULT nextval('uploadedfiles_id_seq'::regclass),
    filename character varying(255) COLLATE pg_catalog."default" NOT NULL,
    filepath character varying(500) COLLATE pg_catalog."default" NOT NULL,
    createddate TIMESTAMP WITH TIME ZONE DEFAULT (now() AT TIME ZONE 'UTC'),
    CONSTRAINT uploadedfiles_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;	

ALTER SEQUENCE public.uploadedfiles_id_seq     OWNED BY public.uploadedfiles.id;




CREATE SEQUENCE IF NOT EXISTS public.useranalytics_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE TABLE IF NOT EXISTS public.useranalytics
(
    id integer NOT NULL DEFAULT nextval('useranalytics_id_seq'::regclass),
    ip character varying(45) COLLATE pg_catalog."default" NOT NULL,
    network character varying(100) COLLATE pg_catalog."default",
    version character varying(10) COLLATE pg_catalog."default",
    city character varying(100) COLLATE pg_catalog."default",
    region character varying(100) COLLATE pg_catalog."default",
    regioncode character varying(10) COLLATE pg_catalog."default",
    country character varying(100) COLLATE pg_catalog."default",
    countryname character varying(100) COLLATE pg_catalog."default",
    countrycode character varying(10) COLLATE pg_catalog."default",
    countrycodeiso3 character varying(10) COLLATE pg_catalog."default",
    countrycapital character varying(100) COLLATE pg_catalog."default",
    countrytld character varying(10) COLLATE pg_catalog."default",
    continentcode character varying(10) COLLATE pg_catalog."default",
    ineu boolean DEFAULT false,
    postal character varying(20) COLLATE pg_catalog."default",
    latitude double precision,
    longitude double precision,
    timezone character varying(50) COLLATE pg_catalog."default",
    utcoffset character varying(10) COLLATE pg_catalog."default",
    countrycallingcode character varying(10) COLLATE pg_catalog."default",
    currency character varying(10) COLLATE pg_catalog."default",
    currencyname character varying(50) COLLATE pg_catalog."default",
    languages character varying(255) COLLATE pg_catalog."default",
    countryarea double precision,
    countrypopulation bigint,
    asn character varying(50) COLLATE pg_catalog."default",
    org character varying(255) COLLATE pg_catalog."default",
    createddate TIMESTAMP WITH TIME ZONE DEFAULT (now() AT TIME ZONE 'UTC'),
    homepageduration integer DEFAULT 0,
    CONSTRAINT useranalytics_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;
	

ALTER SEQUENCE public.useranalytics_id_seq OWNED BY public.useranalytics.id;

CREATE OR REPLACE PROCEDURE public.insertcontactus(
    p_name VARCHAR,
    p_email VARCHAR,
    p_message TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO public.contactus (name, email, message, createddate)
    VALUES (p_name, p_email, p_message, NOW());

    -- Optional: Explicitly commit the transaction
    COMMIT;
END;
$$;

CREATE OR REPLACE PROCEDURE public.insertpostjobs(
    p_title VARCHAR,
    p_location VARCHAR,
    p_contactname VARCHAR,
    p_phone VARCHAR DEFAULT NULL,
    p_email VARCHAR DEFAULT NULL,
    p_description TEXT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO public.postedjob (title, location, contactname, phone, email, description, createddate)
    VALUES (p_title, p_location, p_contactname, p_phone, p_email, p_description, NOW());

    -- Optional: Explicitly commit the transaction
    COMMIT;
END;
$$;

CREATE OR REPLACE PROCEDURE public.insertuseranalytics(
    p_ip VARCHAR,
    p_network VARCHAR DEFAULT NULL,
    p_version VARCHAR DEFAULT NULL,
    p_city VARCHAR DEFAULT NULL,
    p_region VARCHAR DEFAULT NULL,
    p_regioncode VARCHAR DEFAULT NULL,
    p_country VARCHAR DEFAULT NULL,
    p_countryname VARCHAR DEFAULT NULL,
    p_countrycode VARCHAR DEFAULT NULL,
    p_countrycodeiso3 VARCHAR DEFAULT NULL,
    p_countrycapital VARCHAR DEFAULT NULL,
    p_countrytld VARCHAR DEFAULT NULL,
    p_continentcode VARCHAR DEFAULT NULL,
    p_ineu BOOLEAN DEFAULT false,
    p_postal VARCHAR DEFAULT NULL,
    p_latitude DOUBLE PRECISION DEFAULT NULL,
    p_longitude DOUBLE PRECISION DEFAULT NULL,
    p_timezone VARCHAR DEFAULT NULL,
    p_utcoffset VARCHAR DEFAULT NULL,
    p_countrycallingcode VARCHAR DEFAULT NULL,
    p_currency VARCHAR DEFAULT NULL,
    p_currencyname VARCHAR DEFAULT NULL,
    p_languages VARCHAR DEFAULT NULL,
    p_countryarea DOUBLE PRECISION DEFAULT NULL,
    p_countrypopulation BIGINT DEFAULT NULL,
    p_asn VARCHAR DEFAULT NULL,
    p_org VARCHAR DEFAULT NULL,
    p_homepageduration INTEGER DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO public.useranalytics 
        (ip, network, version, city, region, regioncode, country, countryname, countrycode, 
         countrycodeiso3, countrycapital, countrytld, continentcode, ineu, postal, latitude, longitude, 
         timezone, utcoffset, countrycallingcode, currency, currencyname, languages, 
         countryarea, countrypopulation, asn, org, createddate, homepageduration)
    VALUES 
        (p_ip, p_network, p_version, p_city, p_region, p_regioncode, p_country, p_countryname, p_countrycode, 
         p_countrycodeiso3, p_countrycapital, p_countrytld, p_continentcode, p_ineu, p_postal, p_latitude, p_longitude, 
         p_timezone, p_utcoffset, p_countrycallingcode, p_currency, p_currencyname, p_languages, 
         p_countryarea, p_countrypopulation, p_asn, p_org, NOW(), p_homepageduration);

    -- Optional: Explicitly commit the transaction
    COMMIT;
END;
$$;

CREATE OR REPLACE PROCEDURE public.savefilepath(
	p_filename varchar,
	p_filepath varchar	
)
LANGUAGE plpgsql
as $$
BEGIN
INSERT INTO public.uploadedfiles(
	filename, filepath, createddate)
	VALUES (p_filename, p_filepath , NOW());
End;
$$;

GRANT EXECUTE ON PROCEDURE public.insertcontactus TO mndats;

GRANT EXECUTE ON PROCEDURE public.insertpostjobs TO mndats;

GRANT EXECUTE ON PROCEDURE public.insertuseranalytics TO mndats;

GRANT EXECUTE ON PROCEDURE public.savefilepath TO mndats;

GRANT ALL ON SEQUENCE public.contactus_id_seq TO mndats;

GRANT ALL ON SEQUENCE public.postedjob_id_seq TO mndats;

GRANT ALL ON SEQUENCE public.uploadedfiles_id_seq TO mndats;

GRANT ALL ON SEQUENCE public.useranalytics_id_seq TO mndats;

GRANT ALL ON TABLE public.contactus TO mndats;

GRANT ALL ON TABLE public.postedjob TO mndats;

GRANT ALL ON TABLE public.uploadedfiles TO mndats;

GRANT ALL ON TABLE public.useranalytics TO mndats;

GRANT USAGE ON SCHEMA public TO mndats;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO mndats;


COMMIT;