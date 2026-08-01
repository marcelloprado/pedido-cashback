-- =====================================================
-- Projeto: Pedido Cashback
-- Banco: PostgreSQL / Supabase
-- =====================================================

-- Extensão para gerar UUID
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

---------------------------------------------------------
-- Tabela: clientes
---------------------------------------------------------

CREATE TABLE clientes (

    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    nome TEXT NOT NULL,

    cpf VARCHAR(11) UNIQUE NOT NULL,

    email TEXT NOT NULL,

    saldo NUMERIC(10,2) DEFAULT 0,

    created_at TIMESTAMPTZ DEFAULT NOW()

);

---------------------------------------------------------
-- Tabela: transacoes
---------------------------------------------------------

CREATE TABLE transacoes (

    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    created_at TIMESTAMPTZ DEFAULT NOW(),

    cliente_id UUID NOT NULL REFERENCES clientes(id),

    valor NUMERIC(10,2) NOT NULL,

    tipo TEXT NOT NULL,

    descricao TEXT,

    status TEXT DEFAULT 'confirmado'

);

---------------------------------------------------------
-- Constraint do tipo
---------------------------------------------------------

ALTER TABLE transacoes

ADD CONSTRAINT transacoes_tipo_allowed_check

CHECK (

    tipo IN (

        'compras',

        'cashback',

        'resgate'

    )

);

---------------------------------------------------------
-- View
---------------------------------------------------------

CREATE VIEW vw_cliente_gastos AS

SELECT

    c.id,

    c.nome,

    c.email,

    c.saldo,

    COALESCE(SUM(t.valor),0) AS total_gasto

FROM clientes c

LEFT JOIN transacoes t

ON t.cliente_id = c.id

GROUP BY

c.id,
c.nome,
c.email,
c.saldo;