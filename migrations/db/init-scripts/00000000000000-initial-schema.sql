-- migrate:up

-- Set up realtime
-- defaults to empty publication
create publication khulnasoft_realtime;

-- Khulnasoft super admin
create user khulnasoft_admin;
alter user  khulnasoft_admin with superuser createdb createrole replication bypassrls;

-- Khulnasoft replication user
create user khulnasoft_replication_admin with login replication;

-- Khulnasoft read-only user
create role khulnasoft_read_only_user with login bypassrls;
grant pg_read_all_data to khulnasoft_read_only_user;

-- Extension namespacing
create schema if not exists extensions;
create extension if not exists "uuid-ossp"      with schema extensions;
create extension if not exists pgcrypto         with schema extensions;
create extension if not exists pgjwt            with schema extensions;

-- Set up auth roles for the developer
create role anon                nologin noinherit;
create role authenticated       nologin noinherit; -- "logged in" user: web_user, app_user, etc
create role service_role        nologin noinherit bypassrls; -- allow developers to create JWT's that bypass their policies

create user authenticator noinherit;
grant anon              to authenticator;
grant authenticated     to authenticator;
grant service_role      to authenticator;
grant khulnasoft_admin    to authenticator;

grant usage                     on schema public to postgres, anon, authenticated, service_role;
alter default privileges in schema public grant all on tables to postgres, anon, authenticated, service_role;
alter default privileges in schema public grant all on functions to postgres, anon, authenticated, service_role;
alter default privileges in schema public grant all on sequences to postgres, anon, authenticated, service_role;

-- Allow Extensions to be used in the API
grant usage                     on schema extensions to postgres, anon, authenticated, service_role;

-- Set up namespacing
alter user khulnasoft_admin SET search_path TO public, extensions; -- don't include the "auth" schema

-- These are required so that the users receive grants whenever "khulnasoft_admin" creates tables/function
alter default privileges for user khulnasoft_admin in schema public grant all
    on sequences to postgres, anon, authenticated, service_role;
alter default privileges for user khulnasoft_admin in schema public grant all
    on tables to postgres, anon, authenticated, service_role;
alter default privileges for user khulnasoft_admin in schema public grant all
    on functions to postgres, anon, authenticated, service_role;

-- Set short statement/query timeouts for API roles
alter role anon set statement_timeout = '3s';
alter role authenticated set statement_timeout = '8s';

-- migrate:down
