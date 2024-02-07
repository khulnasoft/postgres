-- migrate:up
alter function pg_catalog.lo_export owner to khulnasoft_admin;
alter function pg_catalog.lo_import(text) owner to khulnasoft_admin;
alter function pg_catalog.lo_import(text, oid) owner to khulnasoft_admin;

-- migrate:down
