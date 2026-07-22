# Database Implementation Log

## Phase 1 – Core Business Entities

Status: Completed

Implemented Tables:
- Clients
- Payers
- Reviewers
- Patients
- Providers
- Facilities

### Decisions
- Used PostgreSQL 18.
- Used GENERATED ALWAYS AS IDENTITY for primary keys.
- Used BIGINT for all primary keys.
- Added created_at and updated_at timestamps.
- Added COMMENT ON TABLE for documentation.
- Used explicit PRIMARY KEY, FOREIGN KEY and UNIQUE constraints.

### Notes
These tables represent the foundational business entities required before implementing healthcare claims.
## Phase 2 – Claims

Status: Completed

Implemented Table:
- Claims

### Key Design Decisions

- Claims act as the root entity of the Healthcare Claims Intelligence Platform.
- Business entities are linked using foreign keys.
- Claim Type and Encounter Type are modeled as separate concepts.
- Industry-standard values are stored in the database.
- Operational terminology will be handled by the application layer.
- Composite uniqueness is enforced using (client_id, claim_control_number).
- Business rules are enforced through CHECK constraints.
## Claim Lines

### Key Design Decisions

- Claim Lines represent the primary grain for financial and clinical investigation.
- Financial lifecycle (billed, allowed, paid) is tracked at the line level.
- Diagnosis codes are intentionally excluded from the Claim Lines table.
- A future Claim Diagnoses table and Claim Line Diagnosis Pointers mapping table will model the many-to-many relationship between diagnoses and billed procedures.
- This design maintains normalization, supports AI explainability, and aligns with enterprise healthcare data modeling principles.
### Medical Records

#### Key Design Decisions

- Medical Records store document metadata only.
- Physical files are stored outside PostgreSQL (referenced using `storage_uri`).
- Medical Records belong to Claims rather than individual Claim Lines.
- `document_type` preserves the original value supplied by the source system or uploader.
- Standardization and document categorization will be performed later by an AI classification layer.
- The platform follows an "Extract, Load, Transform" philosophy to preserve source truth and improve interoperability across different healthcare organizations.