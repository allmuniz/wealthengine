CREATE TABLE tb_users
(
    id BIGSERIAL PRIMARY KEY,

    name VARCHAR(150) NOT NULL,

    email VARCHAR(255) NOT NULL UNIQUE,

    password VARCHAR(255) NOT NULL,

    created_at TIMESTAMPTZ NOT NULL,

    updated_at TIMESTAMPTZ
);

CREATE TABLE tb_accounts
(
    id BIGSERIAL PRIMARY KEY,

    user_id BIGINT NOT NULL UNIQUE,

    available_balance NUMERIC(19,2) NOT NULL DEFAULT 0,

    blocked_balance NUMERIC(19,2) NOT NULL DEFAULT 0,

    created_at TIMESTAMPTZ NOT NULL,

    updated_at TIMESTAMPTZ,

    CONSTRAINT fk_account_user
        FOREIGN KEY (user_id)
            REFERENCES tb_users(id)
            ON DELETE RESTRICT,

    CONSTRAINT chk_available_balance
        CHECK (available_balance >= 0),

    CONSTRAINT chk_blocked_balance
        CHECK (blocked_balance >= 0)
);

CREATE TABLE tb_assets
(
    id BIGSERIAL PRIMARY KEY,

    ticker VARCHAR(10) NOT NULL UNIQUE,

    name VARCHAR(150) NOT NULL,

    type VARCHAR(30) NOT NULL,

    isin VARCHAR(20) UNIQUE,

    active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL
);

CREATE TABLE tb_quotes
(
    id BIGSERIAL PRIMARY KEY,

    asset_id BIGINT NOT NULL,

    trading_date DATE NOT NULL,

    opening_price NUMERIC(19,4) NOT NULL,

    closing_price NUMERIC(19,4) NOT NULL,

    minimum_price NUMERIC(19,4) NOT NULL,

    maximum_price NUMERIC(19,4) NOT NULL,

    average_price NUMERIC(19,4),

    traded_quantity BIGINT,

    traded_volume NUMERIC(19,2),

    number_of_trades BIGINT,

    created_at TIMESTAMPTZ NOT NULL,


    CONSTRAINT fk_quote_asset
        FOREIGN KEY (asset_id)
            REFERENCES tb_assets(id)
            ON DELETE RESTRICT,


    CONSTRAINT uk_quote_asset_date
        UNIQUE(asset_id, trading_date),


    CONSTRAINT chk_quote_prices
        CHECK (
            opening_price > 0
                AND closing_price > 0
                AND minimum_price > 0
                AND maximum_price > 0
            )
);

CREATE TABLE tb_positions
(
    id BIGSERIAL PRIMARY KEY,

    account_id BIGINT NOT NULL,

    asset_id BIGINT NOT NULL,

    quantity NUMERIC(19,8) NOT NULL,

    average_price NUMERIC(19,4) NOT NULL,

    invested_amount NUMERIC(19,2) NOT NULL,

    created_at TIMESTAMPTZ NOT NULL,

    updated_at TIMESTAMPTZ,


    CONSTRAINT fk_position_account
        FOREIGN KEY(account_id)
            REFERENCES tb_accounts(id)
            ON DELETE RESTRICT,


    CONSTRAINT fk_position_asset
        FOREIGN KEY(asset_id)
            REFERENCES tb_assets(id)
            ON DELETE RESTRICT,


    CONSTRAINT uk_position_account_asset
        UNIQUE(account_id, asset_id),


    CONSTRAINT chk_position_quantity
        CHECK(quantity >= 0)
);

CREATE TABLE tb_strategies
(
    id BIGSERIAL PRIMARY KEY,

    account_id BIGINT NOT NULL,

    name VARCHAR(100) NOT NULL,

    type VARCHAR(30) NOT NULL,

    amount NUMERIC(19,2) NOT NULL,

    active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL,

    updated_at TIMESTAMPTZ,


    CONSTRAINT fk_strategy_account
        FOREIGN KEY(account_id)
            REFERENCES tb_accounts(id)
            ON DELETE RESTRICT,


    CONSTRAINT chk_strategy_amount
        CHECK(amount > 0)
);

CREATE TABLE tb_orders
(
    id BIGSERIAL PRIMARY KEY,

    account_id BIGINT NOT NULL,

    asset_id BIGINT NOT NULL,

    strategy_id BIGINT,

    type VARCHAR(20) NOT NULL,

    quantity NUMERIC(19,8) NOT NULL,

    unit_price NUMERIC(19,4) NOT NULL,

    total_amount NUMERIC(19,2) NOT NULL,

    status VARCHAR(30) NOT NULL,

    executed_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL,


    CONSTRAINT fk_order_account
        FOREIGN KEY(account_id)
            REFERENCES tb_accounts(id)
            ON DELETE RESTRICT,


    CONSTRAINT fk_order_asset
        FOREIGN KEY(asset_id)
            REFERENCES tb_assets(id)
            ON DELETE RESTRICT,


    CONSTRAINT fk_order_strategy
        FOREIGN KEY(strategy_id)
            REFERENCES tb_strategies(id)
            ON DELETE SET NULL,


    CONSTRAINT chk_order_quantity
        CHECK(quantity > 0),


    CONSTRAINT chk_order_price
        CHECK(unit_price > 0),


    CONSTRAINT chk_order_total
        CHECK(total_amount > 0)
);

CREATE TABLE tb_account_transactions
(
    id BIGSERIAL PRIMARY KEY,


    account_id BIGINT NOT NULL,


    type VARCHAR(30) NOT NULL,


    amount NUMERIC(19,2) NOT NULL,


    description VARCHAR(255),


    reference_type VARCHAR(50),


    reference_id BIGINT,


    created_at TIMESTAMPTZ NOT NULL,


    CONSTRAINT fk_transaction_account
        FOREIGN KEY(account_id)
            REFERENCES tb_accounts(id)
            ON DELETE RESTRICT,


    CONSTRAINT chk_transaction_amount
        CHECK(amount > 0)
);

CREATE INDEX idx_users_email
    ON tb_users(email);


CREATE INDEX idx_assets_ticker
    ON tb_assets(ticker);


CREATE INDEX idx_quotes_asset_date
    ON tb_quotes(asset_id, trading_date DESC);


CREATE INDEX idx_positions_account
    ON tb_positions(account_id);


CREATE INDEX idx_positions_asset
    ON tb_positions(asset_id);


CREATE INDEX idx_orders_account
    ON tb_orders(account_id);


CREATE INDEX idx_orders_status
    ON tb_orders(status);


CREATE INDEX idx_orders_created_at
    ON tb_orders(created_at DESC);


CREATE INDEX idx_transactions_account
    ON tb_account_transactions(account_id);


CREATE INDEX idx_transactions_reference
    ON tb_account_transactions(reference_type, reference_id);


CREATE INDEX idx_transactions_created_at
    ON tb_account_transactions(created_at DESC);


CREATE INDEX idx_strategies_account
    ON tb_strategies(account_id);