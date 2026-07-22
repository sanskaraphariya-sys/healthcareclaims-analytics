CREATE TABLE claim_lines (
    -- Surrogate Primary Key
    claim_line_id BIGINT GENERATED ALWAYS AS IDENTITY,
    
    -- Foreign Key to the Claim Header
    claim_id BIGINT NOT NULL,
    
    -- Line sequencing and identification
    line_number INTEGER NOT NULL,
    
    -- Clinical Service Identifiers
    procedure_code VARCHAR(20) NOT NULL,
    place_of_service VARCHAR(10),
    
    -- Temporal Encounter Data
    service_start_date DATE NOT NULL,
    service_end_date DATE NOT NULL,
    
    -- Service Utilization
    units NUMERIC(10, 2) NOT NULL DEFAULT 1,
    
    -- Financial Data
    billed_amount NUMERIC(15, 2) NOT NULL,
    allowed_amount NUMERIC(15, 2),
    paid_amount NUMERIC(15, 2),
    
    -- Audit Timestamps
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT pk_claim_lines PRIMARY KEY (claim_line_id),
    
    CONSTRAINT fk_claim_lines_claim FOREIGN KEY (claim_id) 
        REFERENCES claims(claim_id) ON DELETE CASCADE,
        
    -- Ensure a claim cannot have duplicate line numbers
    CONSTRAINT uq_claim_lines_number UNIQUE (claim_id, line_number),
    
    -- Business Logic Checks
    CONSTRAINT chk_claim_lines_service_dates CHECK (service_end_date >= service_start_date),
    CONSTRAINT chk_claim_lines_units CHECK (units > 0),
    CONSTRAINT chk_claim_lines_billed_amount CHECK (billed_amount >= 0),
    CONSTRAINT chk_claim_lines_allowed_amount CHECK (allowed_amount >= 0),
    CONSTRAINT chk_claim_lines_paid_amount CHECK (paid_amount >= 0)
);

-- Table Comment
COMMENT ON TABLE claim_lines IS 'Stores the individual billed services (lines) associated with a healthcare claim. This is the primary level for clinical investigation and AI-assisted analysis.';

-- Column Comments
COMMENT ON COLUMN claim_lines.claim_id IS 'References the parent claim header.';
COMMENT ON COLUMN claim_lines.line_number IS 'The sequence number of the line as received from the source system (e.g., 1, 2, 3). Vital for mapping decisions back to the client.';
COMMENT ON COLUMN claim_lines.procedure_code IS 'The primary CPT, HCPCS, or Revenue Code billed on this line.';
COMMENT ON COLUMN claim_lines.place_of_service IS 'The CMS Place of Service (POS) code indicating exactly where this specific service occurred (mostly used on Professional claims).';
COMMENT ON COLUMN claim_lines.service_start_date IS 'The date this specific service or procedure began.';
COMMENT ON COLUMN claim_lines.service_end_date IS 'The date this specific service or procedure concluded.';
COMMENT ON COLUMN claim_lines.units IS 'The number of times the procedure was performed, or the quantity of items/drugs dispensed. Supports decimals for precise anesthesia or pharmaceutical dosing.';
COMMENT ON COLUMN claim_lines.billed_amount IS 'The monetary amount the provider requested for this specific line.';
COMMENT ON COLUMN claim_lines.allowed_amount IS 'The amount payable according to the patient''s contract/policy, prior to any clinical investigation or denial.';
COMMENT ON COLUMN claim_lines.paid_amount IS 'The final amount paid to the provider (if the claim has already been partially or fully adjudicated externally).';