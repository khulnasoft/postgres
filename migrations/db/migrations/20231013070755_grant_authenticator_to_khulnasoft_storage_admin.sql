-- migrate:up
grant authenticator to khulnasoft_storage_admin;
revoke anon, authenticated, service_role from khulnasoft_storage_admin;

-- migrate:down
