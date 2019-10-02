-- Q1
SELECT * 
FROM department;

-- Q2
SELECT * 
FROM dependent;

-- Q3
SELECT * 
FROM dept_locations;

-- Q4
SELECT * 
FROM employee;

-- Q5
SELECT * 
FROM project;

-- Q6
SELECT * 
FROM works_on;

-- Q7
SELECT fname, lname 
FROM employee 
WHERE sex = 'M';

-- Q8
SELECT fname 
FROM employee 
WHERE sex = 'M' AND superssn IS NULL;

-- Q9
SELECT E.fname AS funcionario, S.Fname AS supervisor 
FROM employee AS E, employee AS S 
WHERE E.superssn IS NOT NULL AND E.superssn = S.ssn;

-- Q10
SELECT E.fname AS funcionario 
FROM employee AS E, employee AS S  
WHERE E.superssn IS NOT NULL AND E.superssn = S.ssn AND S.fname = 'Franklin';

-- Q11
SELECT D.dname AS departamento, L.dlocation AS localizacao 
FROM department AS D, dept_locations AS L 
WHERE D.dnumber = L.dnumber;

-- Q12
SELECT D.dname AS departamento 
FROM department AS D, dept_locations AS L 
WHERE D.dnumber = L.dnumber AND dlocation LIKE 'S%';

-- Q13
SELECT E.fname, E.lname, D.dependent_name 
FROM employee AS E, dependent AS D 
WHERE E.ssn = D.essn;

-- Q14
SELECT (fname || ' ' || minit || '. ' || lname) AS full_name, salary 
FROM employee 
WHERE salary > 50000;

-- Q15
SELECT P.pname, D.dname 
FROM department AS D, project AS P 
WHERE P.dnum=D.dnumber;

-- Q16
SELECT P.pname AS Projeto_nome, E.fname AS gerente 
FROM department AS D, project AS P, employee AS E 
WHERE P.dnum=D.dnumber AND P.pnumber > 30 AND D.mgrssn = E.ssn;

-- Q17
SELECT P.pname AS Projeto_nome, E.fname AS funcionario 
FROM project AS P, employee AS E, works_on AS W 
WHERE E.ssn = w.essn AND w.pno = P.pnumber;

-- Q18
SELECT E.fname, D.dependent_name, D.relationship 
FROM employee AS E, dependent AS D, works_on as W 
WHERE E.ssn = W.essn AND W.pno = 91 AND E.ssn = D.essn;
