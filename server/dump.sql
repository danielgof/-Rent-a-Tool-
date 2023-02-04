BEGIN;


CREATE TABLE IF NOT EXISTS public.offer
(
    id integer NOT NULL DEFAULT 'nextval('offer_id_seq'::regclass)',
    tool_name character varying COLLATE pg_catalog."default" NOT NULL,
    tool_description character varying COLLATE pg_catalog."default" NOT NULL,
    location character varying COLLATE pg_catalog."default" NOT NULL,
    price character varying COLLATE pg_catalog."default" NOT NULL,
    date_start date NOT NULL,
    date_finish date NOT NULL,
    owner_name character varying COLLATE pg_catalog."default" NOT NULL,
    phone_number character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT offer_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.people_offers
(
    user_id integer,
    offer_id integer
);

CREATE TABLE IF NOT EXISTS public.users
(
    id integer NOT NULL DEFAULT 'nextval('users_id_seq'::regclass)',
    username character varying COLLATE pg_catalog."default" NOT NULL,
    phone character varying COLLATE pg_catalog."default" NOT NULL,
    email character varying COLLATE pg_catalog."default" NOT NULL,
    password character varying COLLATE pg_catalog."default" NOT NULL,
    confirmed character(1) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT users_pkey PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.people_offers
    ADD CONSTRAINT people_offers_offer_id_fkey FOREIGN KEY (offer_id)
    REFERENCES public.offer (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.people_offers
    ADD CONSTRAINT people_offers_user_id_fkey FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;

INSERT INTO public.offer VALUES (
    1,
    "tool_name",
    "some description",
    "test location",
    "9000",
    date(2023, 1, 1),
    date(2023, 2, 12),
    "owner name",
    "owner phone number"
);
INSERT INTO public.offer VALUES (
    2,
    "tool_name2",
    "some description2",
    "test location2",
    "1200",
    date(2022, 1, 1),
    date(2022, 2, 12),
    "owner name2",
    "owner phone number2"
);
END;