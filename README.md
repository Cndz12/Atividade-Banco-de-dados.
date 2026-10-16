# Atividade Individual – Banco de Dados (Clínica Médica)

UC: Banco de Dados – Prof.ª Silvia Soares

Arquivo do banco: `Atividade Clinica.db` (SQLite, aberto no DB Browser for SQLite).

## Estrutura

- `especialidade` (id, nome)
- `medico` (id, nome, crm)
- `medico_especialidade` (id, id_medico, id_especialidade)

## Questão 2 – Dados inseridos

```sql
INSERT INTO especialidade (nome) VALUES
  ('Oftamologia'), ('Clínica Medica'), ('Pediatria'), ('Cardiologia'), ('Dermatologia');

INSERT INTO medico (nome, crm) VALUES
  ('João Cleber', '43532'),
  ('Tarcisio do Arcodeon', '43632'),
  ('Barões da Pisadinha', '47632'),
  ('Tierry Henri', '47832'),
  ('Rafinha BigLove', '49832'),
  ('Pablo DoArrocha', '47862'),
  ('Nenho Henrique', '47062'),
  ('Heitor Oliveira', '47022'),
  ('Elton Motta', '47012'),
  ('Devinho Novaes', '47016');

SELECT * FROM especialidade;
SELECT * FROM medico;
```

## Questão 3 – Tabela medico_especialidade

```sql
INSERT INTO medico_especialidade (id_medico, id_especialidade) VALUES
  (1, 1), (2, 2), (3, 2), (4, 3), (5, 3),
  (6, 3), (7, 4), (8, 5), (9, 1), (10, 4);

SELECT * FROM medico_especialidade;
```

## Questão 4 – Consultas SQL

### a) Qual o(s) nome(s) dos médicos que são oftalmologistas?

```sql
SELECT m.nome
FROM medico m
JOIN medico_especialidade me ON me.id_medico = m.id
JOIN especialidade e ON e.id = me.id_especialidade
WHERE e.nome = 'Oftamologia';
```

**Resposta:** João Cleber e Elton Motta.

### b) Quantos médicos têm apenas uma especialidade?

```sql
SELECT COUNT(*) AS medicos_com_uma_especialidade
FROM (
  SELECT id_medico
  FROM medico_especialidade
  GROUP BY id_medico
  HAVING COUNT(*) = 1
);
```

**Resposta:** 10 médicos.

### c) Qual a especialidade tem o maior número de médicos?

```sql
SELECT e.nome, COUNT(*) AS total_medicos
FROM especialidade e
JOIN medico_especialidade me ON me.id_especialidade = e.id
GROUP BY e.id, e.nome
HAVING COUNT(*) = (
  SELECT MAX(qtd) FROM (
    SELECT COUNT(*) AS qtd FROM medico_especialidade GROUP BY id_especialidade
  )
);
```

**Resposta:** Pediatria, com 3 médicos.

### d) Qual o nome do dermatologista da clínica?

```sql
SELECT m.nome
FROM medico m
JOIN medico_especialidade me ON me.id_medico = m.id
JOIN especialidade e ON e.id = me.id_especialidade
WHERE e.nome = 'Dermatologia';
```

**Resposta:** Heitor Oliveira.
