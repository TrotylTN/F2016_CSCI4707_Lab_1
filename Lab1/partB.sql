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
GROUP BY D.managerid
HAVING count(D.did) = 1 AND sum(D.budget) > 50000000;

-- B.5
SELECT E.ename
FROM Emp E
INNER JOIN 
    (
        SELECT DISTINCT managerid1
        FROM
        (
            ( -- name list
                SELECT D1.managerid AS managerid1, sum(D1.budget) as budget1
                FROM Dept D1
                GROUP BY D1.managerid
            )
            MINUS
            ( -- except largest one
                SELECT DISTINCT managerid3 AS managerid1, budget3 as budget1
                FROM
                (
                    (
                        SELECT D2.managerid AS managerid2, sum(D2.budget) AS budget2
                        FROM Dept D2
                        GROUP BY D2.managerid
                    )
                    INNER JOIN
                    (
                        SELECT D3.managerid AS managerid3, sum(D3.budget) AS budget3
                        FROM Dept D3
                        GROUP BY D3.managerid
                    )
                    ON budget2 > budget3
                )
            )
        )
    )
ON E.eid = managerid1;

-- B.6