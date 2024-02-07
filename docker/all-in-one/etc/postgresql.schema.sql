\set admin_pass `echo "${KHULNASOFT_ADMIN_PASSWORD:-$POSTGRES_PASSWORD}"`
\set pgrst_pass `echo "${AUTHENTICATOR_PASSWORD:-$POSTGRES_PASSWORD}"`
\set pgbouncer_pass `echo "${PGBOUNCER_PASSWORD:-$POSTGRES_PASSWORD}"`
\set auth_pass `echo "${KHULNASOFT_AUTH_ADMIN_PASSWORD:-$POSTGRES_PASSWORD}"`
\set storage_pass `echo "${KHULNASOFT_STORAGE_ADMIN_PASSWORD:-$POSTGRES_PASSWORD}"`
\set replication_pass `echo "${KHULNASOFT_REPLICATION_ADMIN_PASSWORD:-$POSTGRES_PASSWORD}"`
\set read_only_pass `echo "${KHULNASOFT_READ_ONLY_USER_PASSWORD:-$POSTGRES_PASSWORD}"`

ALTER USER khulnasoft_admin WITH PASSWORD :'admin_pass';
ALTER USER authenticator WITH PASSWORD :'pgrst_pass';
ALTER USER pgbouncer WITH PASSWORD :'pgbouncer_pass';
ALTER USER khulnasoft_auth_admin WITH PASSWORD :'auth_pass';
ALTER USER khulnasoft_storage_admin WITH PASSWORD :'storage_pass';
ALTER USER khulnasoft_replication_admin WITH PASSWORD :'replication_pass';
ALTER ROLE khulnasoft_read_only_user WITH PASSWORD :'read_only_pass';
ALTER ROLE khulnasoft_admin SET search_path TO "$user",public,auth,extensions;
