BEGIN;

-- Update current records in t_clients where country is not specified to Canada
UPDATE t_clients SET cl_country = 'Canada' WHERE cl_country IS NULL;

-- Add default value of 'Canada' to country domain
ALTER DOMAIN country SET DEFAULT 'Canada';
