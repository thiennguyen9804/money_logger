# Data Model: Standardized Category List and Slide-Up Add Transaction Flow

**Feature**: 009-enhance-add-transaction-categories  
**Date**: 2026-11-11  
**Status**: Complete

---

## Entity: TransactionType

**Description**: Enumeration representing the type of a financial transaction.

**Fields**:
| Field | Type | Required | Description | Validation |
|-------|------|----------|-------------|------------|
| N/A | Enum | Yes | Transaction type | Must be one of: `income`, `expense` |

**Values**:
- `income` - Represents money received
- `expense` - Represents money spent

**State Transitions**:
- Type can change based on user selection
- Changing type may clear incompatible category selection

---

## Entity: ExpenseCategory

**Description**: A predefined category for tracking expense transactions.

**Fields**:
| Field | Type | Required | Description | Validation |
|-------|------|----------|-------------|------------|
| id | String | Yes | Unique identifier | Non-empty, unique within expense categories |
| label | String | Yes | Display label | Non-empty, English-only, max 50 chars |
| icon | IconData | Yes | Material Icon | Must be a valid Material Icon |
| type | TransactionType | Yes | Category type | Must be `expense` |

**Predefined Instances** (18 total):
1. Fuel - `local_gas_station`
2. Transportation - `commute`
3. Food & Beverage - `restaurant`
4. Rent - `home`
5. Lending - `account_balance_wallet`
6. Debt Repayment - `receipt_long`
7. Vehicle Repair - `car_repair`
8. Phone Bills - `phone_iphone`
9. Haircut - `content_cut`
10. Healthcare - `local_hospital`
11. Entertainment & Leisure - `movie`
12. Other Expenses - `category`
13. Online Services - `public`
14. Shopping - `shopping_bag`
15. Transfer Out - `compare_arrows`
16. Gifts - `redeem`
17. Vehicle Maintenance - `build`
18. Personal Care - `face`

**Relationships**:
- Belongs to: TransactionType.expense
- Used by: Transaction (via category field)
- Displayed in: CategorySelectionScreen (Expense tab)

**Validation Rules**:
- Label must match exactly one of the 18 predefined labels
- Icon must match the specified Material Icon for that label
- Type must always be `expense`

---

## Entity: IncomeCategory

**Description**: A predefined category for tracking income transactions.

**Fields**:
| Field | Type | Required | Description | Validation |
|-------|------|----------|-------------|------------|
| id | String | Yes | Unique identifier | Non-empty, unique within income categories |
| label | String | Yes | Display label | Non-empty, English-only, max 50 chars |
| icon | IconData | Yes | Material Icon | Must be a valid Material Icon |
| type | TransactionType | Yes | Category type | Must be `income` |

**Predefined Instances** (6 total):
1. Transfer In - `compare_arrows`
2. Salary - `work`
3. Other Income - `category`
4. Gifts Received - `redeem`
5. Borrowing - `money`
6. Debt Collection - `credit_card`

**Relationships**:
- Belongs to: TransactionType.income
- Used by: Transaction (via category field)
- Displayed in: CategorySelectionScreen (Income tab)

**Validation Rules**:
- Label must match exactly one of the 6 predefined labels
- Icon must match the specified Material Icon for that label
- Type must always be `income`

---

## Entity: Category

**Description**: Abstract base type for all categories (ExpenseCategory and IncomeCategory).

**Fields**:
| Field | Type | Required | Description | Validation |
|-------|------|----------|-------------|------------|
| id | String | Yes | Unique identifier | Non-empty, globally unique |
| label | String | Yes | Display label | Non-empty, English-only, max 50 chars |
| icon | IconData | Yes | Material Icon | Must be a valid Material Icon |
| type | TransactionType | Yes | Category type | Must be either `income` or `expense` |

**Relationships**:
- Inherited by: ExpenseCategory, IncomeCategory
- Used by: TransactionDraft, Transaction

**Validation Rules**:
- All 24 categories (18 Expense + 6 Income) must be defined
- No duplicate labels across all categories
- Each category must have exactly one type

---

## Entity: TransactionDraft

**Description**: The in-progress transaction being composed by the user.

**Fields**:
| Field | Type | Required | Description | Validation |
|-------|------|----------|-------------|------------|
| type | TransactionType | No | Transaction type (income/expense) | Must be either `income` or `expense` |
| category | Category | No | Selected category | Must be compatible with type, or null |
| amount | double | No | Transaction amount | >= 0 if income, can be any if expense |
| description | String | No | Optional description | Max 255 chars |
| date | DateTime | No | Transaction date | Default: current date |

**State Transitions**:
1. **Type Change**: When type changes, if current category is incompatible, clear category
2. **Category Change**: When category changes, update type to match category.type
3. **Navigation**: Draft state persists across navigation (e.g., to Category Selection and back)

**Relationships**:
- Contains: TransactionType (type field)
- Contains: Category (category field)
- Managed by: AddTransactionBloc (from spec 008)

**Validation Rules**:
- If type is set, category must either be null or match the type
- If category is set, type must match category.type
- Amount must be a valid number

---

## Entity: CategorySelectionSession

**Description**: Manages the active tab and selected category during the category selection flow.

**Fields**:
| Field | Type | Required | Description | Validation |
|-------|------|----------|-------------|------------|
| activeTab | TransactionType | Yes | Currently selected tab | Must be either `income` or `expense` |
| selectedCategory | Category | No | Currently selected category | Must be compatible with activeTab, or null |
| filter | TransactionType | Yes | Current filter for category list | Must be either `income` or `expense` |

**State Transitions**:
1. **Tab Change**: When tab changes, update filter and clear selectedCategory if incompatible
2. **Category Selection**: When category is selected, update selectedCategory and activeTab to match
3. **Back Navigation**: When returning to Add Transaction, persist selectedCategory

**Relationships**:
- Contains: TransactionType (activeTab, filter)
- Contains: Category (selectedCategory)
- Managed by: CategorySelectionBloc (new or existing)

**Validation Rules**:
- activeTab must match filter
- selectedCategory must either be null or match filter type

---

## Data Flow Diagrams

### Category Selection Flow

```
AddTransactionScreen
    │
    ▼ (user taps category selector)
CategorySelectionScreen
    │
    ├─► TabBar (Expense/Income)
    │        │
    │        ▼
    │    filter categories by type
    │
    ▼
CategoryList (filtered by type)
    │
    ▼ (user selects category)
selectedCategory → AddTransactionScreen
    │
    ▼
Update TransactionDraft.category and type
```

### Type-Category Synchronization Flow

```
User Action: Change Type (Expense → Income)
    │
    ▼
Check TransactionDraft.category
    │
    ├─► If category is Expense category
    │        │
    │        ▼
    │    Clear TransactionDraft.category
    │
    ▼
Update TransactionDraft.type to Income
    │
    ▼
UI updates to reflect new type

User Action: Select Category (Expense category)
    │
    ▼
Check category.type
    │
    ▼
Update TransactionDraft.category
    │
    ▼
Update TransactionDraft.type to match category.type
    │
    ▼
UI updates to reflect new type and category
```

---

## Implementation Notes

1. **Static Category List**: All 24 categories are predefined and static. No user configuration in this version.
2. **Icon Consistency**: Material Icons are specified in this document and must be used exactly as defined.
3. **Label Consistency**: Category labels must match exactly (case-sensitive) as specified.
4. **Type Safety**: Use enums for TransactionType to ensure type safety.
5. **Immutability**: Category objects should be immutable (const or frozen).

---

## Validation Checklist

- [ ] All 18 ExpenseCategory instances defined with correct labels and icons
- [ ] All 6 IncomeCategory instances defined with correct labels and icons
- [ ] All category labels are English-only
- [ ] All category icons are valid Material Icons
- [ ] No duplicate labels across all categories
- [ ] TransactionType enum has exactly 2 values: income, expense
- [ ] TransactionDraft can hold null for type and category
- [ ] Bi-directional synchronization logic implemented in BLoC
- [ ] Category filtering by type works correctly
- [ ] Navigation persistence for TransactionDraft works correctly
