CREATE TABLE IF NOT EXISTS public.test_flyway
(
    test character varying(100) COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.test_flyway
    OWNER to mndats;

GRANT ALL ON TABLE public.test_flyway TO mndats;

COMMENT ON TABLE public.test_flyway
    IS 'Testing Flyway migration';