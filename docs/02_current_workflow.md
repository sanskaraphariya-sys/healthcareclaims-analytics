# Current Workflow

## Objective

The objective of the healthcare claims investigation workflow is to ensure that billed healthcare services are supported by sufficient clinical documentation and comply with applicable payer guidelines before reimbursement decisions are finalized.

The workflow combines automated claim preprocessing with human clinical review to maintain accuracy, compliance, and consistency while processing a high volume of claims.

## Actors

- Medical Coders
- Non-Clinical Investigators (NCI)
- Clinical Investigators (CI)
- Senior Clinical Investigators
- Clinical Appeals
- Non-Clinical Appeals
- Subject Matter Experts (SMEs)

## Systems Involved

The workflow requires investigators to interact with multiple independent systems throughout a single claim review.

Examples include:

- Electronic Health Record (EHR)
- Claim Management System
- Medical Coding Reference System
- AI-assisted Medical Record Search Tool
- Clinical Guideline Repository
- Internal Workflow Application

## End-to-End Workflow

### Stage 1 - Claim Submission

A patient receives healthcare services from a provider.

Clinical documentation is created throughout the patient's episode of care within the Electronic Health Record (EHR).

Medical coders assign diagnosis, procedure, and billing codes based on the documented services.

Once coding is completed, a healthcare claim is generated and submitted to the insurance organization for review.

### Stage 2 - Claim Allocation

Claims are allocated to investigators according to business-specific routing rules.

Allocation may consider:

- Client
- Region
- Claim type
- Primary analytic category

Investigators receive assigned claims through the internal workflow system before beginning review.

### Stage 3 - Non-Clinical Investigation

The Non-Clinical Investigator prepares the claim for clinical review.

Typical activities include:

- Creating or registering the claim within the internal workflow system.
- Associating the correct medical documentation with the claim.
- Organizing supporting records.
- Assigning the prepared claim to the appropriate Clinical Investigator.

### Stage 4 - AI Pre-processing

#### Objective

Reduce manual effort by automatically analyzing incoming claims before they reach the Clinical Investigator.

#### Inputs

- Claim information
- Claim lines
- CPT codes
- HCPCS codes
- Medical documentation
- Client-specific review configuration

#### Current Workflow

Once the Non-Clinical Investigator completes claim preparation, automated analytical processes identify claim lines requiring manual investigation.

Current capabilities generally include:

- Identifying analytic hits
- Extracting billed procedure codes
- Organizing claim information
- Making medical documentation searchable

The generated review package is then forwarded to the assigned Clinical Investigator.

#### Current Limitations

- Primarily rule-based analysis
- Limited contextual understanding
- No evidence extraction
- No clinical reasoning
- Keyword-based document search
- Reviewers still manually locate supporting documentation

#### Product Opportunity

Future AI capabilities should:

- Automatically organize medical records into a clinical timeline
- Surface documentation relevant to each billed service
- Summarize lengthy medical records
- Link evidence directly to individual claim lines
- Highlight missing documentation
- Estimate review complexity

### Stage 5 - Clinical Investigation

#### Objective

Determine whether billed healthcare services are adequately supported by clinical documentation according to applicable payer guidelines.

#### Inputs

- Assigned claim
- Medical records
- Claim lines
- CPT/HCPCS codes
- Analytic hits
- Client guidelines

#### Current Workflow

The Clinical Investigator performs the following activities:

1. Verify patient information.
2. Review claim lines requiring investigation.
3. Understand billed procedures using coding reference tools.
4. Search medical documentation.
5. Review relevant clinical evidence including:

   - Medication Administration Records
   - Procedure Notes
   - Imaging Reports
   - Laboratory Reports
   - Emergency Department Notes
   - Service Notes
   - Transfer Notes
   - Clinical Timelines
   - Other supporting documentation

6. Compare documentation against payer guidelines.
7. Determine whether sufficient evidence supports each reviewed claim line.

#### Current Limitations

- Heavy dependence on manual document review
- Multiple application switching
- Manual code lookup
- Hundreds of pages of documentation
- Evidence scattered across different note types
- Guideline interpretation remains manual

#### Product Opportunity

The platform should assist investigators by:

- Building an intelligent clinical timeline
- Automatically locating evidence
- Grouping evidence by billed procedure
- Summarizing documentation
- Displaying supporting and missing evidence
- Providing configurable guideline assistance
- Prioritizing reviewer attention while preserving human decision-making

### Stage 6 - Decision

#### Objective

Produce a well-supported reimbursement decision for each reviewed claim line.

#### Possible Outcomes

- Allow
- Deny
- Escalate for additional review

#### Current Workflow

If documentation supports the billed service:

- Allow the claim line.
- Record no adverse findings.

If documentation does not support the billed service:

- Select the appropriate denial category.
- Document the clinical rationale.
- Provide detailed justification referencing applicable guidelines and available evidence.

#### Current Limitations

- Manual documentation
- Repetitive denial statements
- Time-consuming rationale preparation
- Variable wording between reviewers

#### Product Opportunity

Future capabilities include:

- AI-assisted denial draft generation
- Automatic evidence citation
- Consistent guideline-based language
- Reviewer-editable recommendations

### Stage 7 - Appeals

#### Objective

Ensure previously reviewed claims receive a fair and consistent reassessment when challenged.

#### Inputs

- Original claim
- Previous investigation
- Appeal documentation
- Additional clinical evidence

#### Current Workflow

Appealed claims are reassigned for review.

Depending on complexity, reviews may involve:

- Clinical Appeals teams
- Non-Clinical Appeals teams
- Senior Clinical Investigators
- Subject Matter Experts

The reviewer reassesses the available evidence and issues an updated determination where appropriate.

#### Current Limitations

- Repeated manual review
- Duplicate evidence retrieval
- Time-intensive reassessment

#### Product Opportunity

Future enhancements may include:

- Automatic comparison between original and appealed reviews
- Identification of newly submitted evidence
- AI-generated review summaries
- Evidence change tracking

## Workflow Summary
Patient receives care
        │
        ▼
Medical documentation created
        │
        ▼
Medical coding
        │
        ▼
Claim submission
        │
        ▼
Claim allocation
        │
        ▼
Non-Clinical Investigation
        │
        ▼
AI Pre-processing
        │
        ▼
Clinical Investigation
        │
        ▼
Decision
        │
        ▼
Appeals (if required)
        │
        ▼
Final Outcome