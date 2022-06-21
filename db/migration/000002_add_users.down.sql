alter table if EXISTS "accounts" DROP constraint IF  EXISTS "owner_currency_key";
alter table if EXISTS "accounts" DROP constraint IF  EXISTS "accounts_owner_fkey";

DROP table if EXISTS "users";
