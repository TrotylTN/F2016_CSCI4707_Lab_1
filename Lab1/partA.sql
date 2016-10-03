CREATE TABLE Emp(eid integer,
                 ename VARCHAR(15),
                 age integer,
                 salary integer,
                 PRIMARY KEY (eid)
                 );
CREATE TABLE Dept(did integer,
                  budget integer,
                  managerid integer,
                  FOREIGN KEY (managerid) REFERENCES Emp(eid),
                  PRIMARY KEY (did)
                  );
CREATE TABLE Works(eid integer,
                   did integer,
                   PRIMARY KEY (eid, did),
                   FOREIGN KEY (eid) REFERENCES Emp(eid),
                   FOREIGN KEY (did) REFERENCES Dept(did)
                   );