-- B.1
SELECT Emp.ename, Emp.eid
FROM Emp
INNER JOIN Works W1
ON Emp.eid = W1.eid
INNER JOIN Works W2
ON Emp.eid = W2.eid
WHERE W1.did = 1 AND W2.did = 2;

-- B.2
SELECT W.did, count(W.did) AS Num_of_Emp
FROM Works W
HAVING count(W.did) > 10
GROUP BY W.did
ORDER BY W.did;

-- B.3
SELECT E.ename
FROM Emp E
INNER JOIN Works W
ON E.eid = W.eid
INNER JOIN Dept D
ON W.did = D.did
GROUP BY E.ename, E.eid, E.salary
HAVING E.salary > sum(D.budget);

-- B.4
SELECT D.managerid
FROM Dept D
WHERE D.budget > 50000000;