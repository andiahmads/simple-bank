CREATE TABLE "users" (
  "username" varchar PRIMARY KEY,
  "hashed_password" VARCHAR not null,
  "full_name" varchar NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "password_changed_at" timestamptz NOT NULL default '0001-01-01 00:00:0Z',
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

alter table "accounts" ADD FOREIGN KEY ("owner") REFERENCES "users" ("username");

/* create UNIQUE index on "accounts" ("owner","currency"); */

ALTER table "accounts" ADD CONSTRAINT "owner_currency_key" UNIQUE ("owner","currency");
 