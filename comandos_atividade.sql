-- Mostrar os dados inseridos:
SELECT * FROM especialidade;
SELECT * FROM medico;

-- ---------- QUESTAO 3 ----------
INSERT INTO medico_especialidade (id_medico, id_especialidade) VALUES
  (1, 1),
  (2, 2),
  (3, 2),
  (4, 3),
  (5, 3),
  (6, 3),
  (7, 4),
  (8, 5),
  (9, 1),
  (10, 4);

SELECT * FROM medico_especialidade;

-- ---------- QUESTAO 4 ----------
-- a) Nome(s) dos medicos que sao oftalmologistas
SELECT m.nome
FROM medico m
JOIN medico_especialidade me ON me.id_medico = m.id
JOIN especialidade e ON e.id = me.id_especialidade
WHERE e.nome = 'Oftamologia';

-- b) Quantos medicos tem apenas uma especialidade
SELECT COUNT(*) AS medicos_com_uma_especialidade
FROM (
  SELECT id_medico
  FROM medico_especialidade
  GROUP BY id_medico
  HAVING COUNT(*) = 1
);

-- c) Especialidade com o maior numero de medicos
SELECT e.nome, COUNT(*) AS total_medicos
FROM especialidade e
JOIN medico_especialidade me ON me.id_especialidade = e.id
GROUP BY e.id, e.nome
HAVING COUNT(*) = (
  SELECT MAX(qtd) FROM (
    SELECT COUNT(*) AS qtd FROM medico_especialidade GROUP BY id_especialidade
  )
);

-- d) Nome do dermatologista da clinica
SELECT m.nome
FROM medico m
JOIN medico_especialidade me ON me.id_medico = m.id
JOIN especialidade e ON e.id = me.id_especialidade
WHERE e.nome = 'Dermatologia';
