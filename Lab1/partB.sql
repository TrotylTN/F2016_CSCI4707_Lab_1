-- B.1
SELECT Emp.ename, Emp.eid
FROM Emp
INNER JOIN 
(
    SELECT W1.eid AS eid1
    FROM
    (
        Works W1
        INNER JOIN Works W2
        ON W1.eid = W2.eid
    )
    WHERE W1.did = 1 AND W2.did = 2  
)
ON Emp.eid = eid1;

-- B.2
SELECT W.did, count(W.did) AS Num_of_Emp
FROM Works W
HAVING count(W.did) > 10
GROUP BY W.did
ORDER BY W.did;

-- B.3
SELECT E.ename as ename_for_B_3
FROM Emp E
INNER JOIN Works W
ON E.eid = W.eid
INNER JOIN Dept D
ON W.did = D.did
GROUP BY E.ename, E.eid, E.salary
HAVING E.salary > sum(D.budget);

-- B.4
SELECT DISTINCT managerid1 AS managerid_for_B_4
FROM
( -- set of > 50m
    SELECT DISTINCT D.managerid AS managerid1
    FROM Dept D
    WHERE D.budget > 50000000
)
MINUS
( -- set of < 50m
    SELECT DISTINCT D1.managerid AS managerid1
    FROM Dept D1
    WHERE D1.budget <= 50000000
);

-- B.5
SELECT E.ename AS ename_for_B_5
FROM 
(
    Emp E
    INNER JOIN 
    (
        SELECT DISTINCT managerid1
        FROM
        (
            ( -- name list
                SELECT DISTINCT D1.managerid AS managerid1, D1.budget as budget1
                FROM Dept D1
            )
            MINUS
            ( -- except largest one
                SELECT DISTINCT managerid3 AS managerid1, budget3 as budget1
                FROM
                (
                    (
                        SELECT D2.managerid AS managerid2, D2.budget AS budget2
                        FROM Dept D2
                    )
                    INNER JOIN
                    (
                        SELECT D3.managerid AS managerid3, D3.budget AS budget3
                        FROM Dept D3
                    )
                    ON budget2 > budget3
                )
            )
        )
    )
    ON E.eid = managerid1
)
ORDER BY managerid1;

-- B.6
SELECT DISTINCT managerid1 AS managerid_for_B_6
FROM
( -- name list
    SELECT D1.managerid AS managerid1, sum(D1.budget) as budget1
    FROM Dept D1
    GROUP BY D1.managerid
)
WHERE budget1 > 50000000
ORDER BY managerid_for_B_6;

-- B.7
SELECT DISTINCT managerid1 AS managerid_for_B_7
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
ORDER BY managerid_for_B_7;

-- B.8
SELECT E.ename AS ename_for_B_8
FROM Emp E
INNER JOIN
(
    ( -- manage only departments budgets > 30m
        (
            SELECT DISTINCT managerid
            FROM Dept
            WHERE budget > 30000000
        )
        MINUS
        (
            SELECT DISTINCT managerid
            FROM Dept
            WHERE budget <= 30000000
        )
    )
    INTERSECT
    ( -- manage department budgets < 50m
        SELECT DISTINCT managerid
        FROM Dept
        WHERE budget < 50000000
    )
)
ON E.eid = managerid
ORDER BY E.eid;
