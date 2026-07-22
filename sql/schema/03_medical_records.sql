CREATE TABLE medical_records (
    -- Surrogate Primary Key
    medical_record_id BIGINT GENERATED ALWAYS AS IDENTITY,
    
    -- Foreign Key to the Claim Header
    claim_id BIGINT NOT NULL,
    
    -- Document Identification & Classification
    file_name VARCHAR(255) NOT NULL,
    original_document_type VARCHAR(255) NOT NULL,
    standardized_document_type VARCHAR(50),
    
    -- Clinical Temporal Data
    document_date DATE,
    
    -- Storage and Technical Metadata
    storage_uri VARCHAR(1024) NOT NULL,
    mime_type VARCHAR(100) NOT NULL DEFAULT 'application/pdf',
    page_count INTEGER,
    
    -- Audit Timestamps
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT pk_medical_records PRIMARY KEY (medical_record_id),
    
    CONSTRAINT fk_medical_records_claim FOREIGN KEY (claim_id) 
        REFERENCES claims(claim_id) ON DELETE CASCADE,
        
    -- Prevent the exact same file from being attached to the same claim multiple times
    CONSTRAINT uq_medical_records_storage UNIQUE (claim_id, storage_uri),
    
    -- Business Logic Checks
    CONSTRAINT chk_medical_records_pages CHECK (page_count > 0),
    
    -- Enforce strict taxonomy ONLY on the AI output
    CONSTRAINT chk_medical_records_std_type CHECK (
        standardized_document_type IN (
            'MAR',                  -- Medication Administration Record
            'ED_NOTE',              -- Emergency Department Note
            'NURSING_NOTE',         -- General Nursing Note
            'PROCEDURE_NOTE',       -- Operative / Procedure Note
            'IMAGING_REPORT',       -- X-Ray, MRI, CT Scan
            'LABORATORY_REPORT',    -- Bloodwork, Pathology
            'SERVICE_NOTE',         -- Physician Progress Note
            'TRANSFER_NOTE',        -- Transfer between units
            'DISCHARGE_SUMMARY',    -- Patient Discharge Info
            'UNCLASSIFIED'          -- Explicit state if AI fails to classify
        )
    )
);

-- Table Comment
COMMENT ON TABLE medical_records IS 'Stores metadata and storage pointers for medical documentation. Implements an ELT pattern allowing raw heterogeneous document names to be ingested alongside strict AI-standardized categories.';

-- Column Comments
COMMENT ON COLUMN medical_records.claim_id IS 'References the parent claim. In V1, medical records are scoped to the claim investigation, not the longitudinal patient record.';
COMMENT ON COLUMN medical_records.file_name IS 'The original name of the uploaded file, useful for investigator reference.';
COMMENT ON COLUMN medical_records.original_document_type IS 'The raw, unstructured document category provided by the upstream client or uploader (e.g., ER Consult v2). Never mutated. Serves as the immutable source of truth.';
COMMENT ON COLUMN medical_records.standardized_document_type IS 'The sanitized, AI-classified document type. Nullable to support asynchronous processing. Used by the UI for filtering and by the AI for semantic search bounding.';
COMMENT ON COLUMN medical_records.document_date IS 'The actual date the clinical event occurred or was recorded, NOT the upload date. Helps investigators build mental timelines.';
COMMENT ON COLUMN medical_records.storage_uri IS 'The secure cloud storage path (e.g., S3 URI) where the actual file payload resides.';
COMMENT ON COLUMN medical_records.mime_type IS 'The file format (e.g., application/pdf, image/tiff). Helps the frontend UI know how to render the document viewer.';
COMMENT ON COLUMN medical_records.page_count IS 'The number of pages in the document. Helps the Clinical Investigator estimate cognitive load and review time.';