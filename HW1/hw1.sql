--B.1a
CREATE TABLE Customer (custid CHAR(20),
                       PRIMARY KEY (custid)
                       )
CREATE TABLE Product (pid CHAR(20),
                      PRIMARY KEY (pid)
                      )
CREATE TABLE Transaction (tid CHAR(20),
                          PRIMARY KEY (tid)
                          )
CREATE TABLE Purchase (custid CHAR(20),
                       pid CHAR(20),
                       tid CHAR(20),
                       PRIMARY KEY (tid),
                       --Every Purchase has a unique transaction id
                       FOREIGN KEY (custid) REFERENCES Customer,
                       FOREIGN KEY (pid) REFERENCES Product
                       FOREIGN KEY (tid) REFERENCES Transaction
                       )

--B.1b
CREATE TABLE Customer (custid CHAR(20),
                       PRIMARY KEY (custid)
                       )
CREATE TABLE Product (pid CHAR(20),
                      PRIMARY KEY (pid)
                      )
CREATE TABLE Transaction (tid CHAR(20),
                          PRIMARY KEY (tid)
                          )
CREATE TABLE Purchase (custid CHAR(20),
                       pid CHAR(20),
                       tid CHAR(20),
                       PRIMARY KEY (tid),
                       --Every Purchase has a unique transaction id
                       FOREIGN KEY (custid) REFERENCES Customer,
                       FOREIGN KEY (pid) REFERENCES Product
                       FOREIGN KEY (tid) REFERENCES Transaction
                       )

--B.1c
CREATE TABLE Customer (custid CHAR(20),
                       PRIMARY KEY (custid)
                       )
CREATE TABLE Product (pid CHAR(20),
                      PRIMARY KEY (pid)
                      )
CREATE TABLE Purchase (custid CHAR(20),
                       pid CHAR(20),
                       PRIMARY KEY (custid, pid),
                       FOREIGN KEY (custid) REFERENCES Customer,
                       FOREIGN KEY (pid) REFERENCES Product
                       )

--B.1d
CREATE TABLE Customer (custid CHAR(20),
                       PRIMARY KEY (custid)
                       )
CREATE TABLE Product (pid CHAR(20),
                      PRIMARY KEY (pid)
                      )
CREATE TABLE Purchase (custid CHAR(20),
                       pid CHAR(20),
                       PRIMARY KEY (custid), 
                       --Every Customer only can buy exactly one product
                       FOREIGN KEY (custid) REFERENCES Customer,
                       FOREIGN KEY (pid) REFERENCES Product
                       )

--B.2
CREATE TABLE book (ISBN CHAR(20),
                   name CHAR(20),
                   PRIMARY KEY (ISBN)
                   )
CREATE TABLE author (ID CHAR(20),
                     aname CHAR(20),
                     PRIMARY KEY (ID)
                     )
CREATE TABLE publisher (pid CHAR(20),
                        pname CHAR(20),
                        PRIMARY KEY (pid)
                        )
CREATE TABLE category (cname CHAR(20),
                       PRIMARY KEY (cname)
                       )
CREATE TABLE subcategory (scname CHAR(20),
                          cname CHAR(20),
                          PRIMARY KEY (scname),
                          FOREIGN (cname) REFERENCES category(cname) ON DELETE CASCADE
                          --each subcategory has at most one parent category.
                          )
CREATE TABLE wrote (ISBN CHAR(20),
                    ID CHAR(20),
                    PRIMARY KEY (ISBN, ID),
                    FOREIGN KEY (ISBN) REFERENCES book,
                    FOREIGN KEY (ID) REFERENCES author
                    )
CREATE TABLE publish (ISBN CHAR(20),
                      pid CHAR(20),
                      PRIMARY KEY (ISBN), 
                      --a book just has exactly one publisher
                      FOREIGN KEY (ISBN) REFERENCES book,
                      FOREIGN KEY (pid) REFERENCES publisher
                      )
CREATE TABLE belong_to (ISBN CHAR(20),
                        cname CHAR(20),
                        PRIMARY KEY (ISBN, cname),
                        FOREIGN KEY (ISBN) REFERENCES book,
                        FOREIGN KEY (cname) REFERENCES category
                        )

--B.3
CREATE TABLE employee (netID CHAR(20) NOT NULL,
                       name CHAR(20),
                       PRIMARY KEY (netID)
                       )
CREATE TABLE professor (netID CHAR(20) NOT NULL,
                        name CHAR(20),
                        --professor is a employee
                        Office_number CHAR(20),
                        PRIMARY KEY (netID),
                        FOREIGN KEY (netID, name) REFERENCES employee(netID, name) ON DELETE CASCADE
                        )
CREATE TABLE TA (netID CHAR(20) NOT NULL,
                 name CHAR(20),
                 --TA is a employee
                 PRIMARY KEY (netID),
                 FOREIGN KEY (netID, name) REFERENCES employee(netID, name) ON DELETE CASCADE
                 )
CREATE TABLE course (title CHAR(20),
                     courseID CHAR(20),
                     PRIMARY KEY (courseID)
                     )
CREATE TABLE section_ (meeting_time CHAR(20),
                      meeting_room CHAR(20)
                      )
CREATE TABLE homework (topic CHAR(20),
                       hw_number INTEGER,
                       PRIMARY KEY (hw_number)
                       )
CREATE TABLE associated_with(courseID CHAR(20),
                             meeting_time CHAR(20),
                             meeting_room CHAR(20),
                             PRIMARY KEY (courseID, meeting_time, meeting_room),
                             FOREIGN KEY (courseID) REFERENCES course,
                             FOREIGN KEY (meeting_time, meeting_room) REFERENCES section_
                             )
CREATE TABLE teach (netID CHAR(20),
                    courseID CHAR(20),
                    PRIMARY KEY (netID, courseID),
                    FOREIGN KEY (netID) REFERENCES professor,
                    FOREIGN KEY (courseID) REFERENCES course
                    )
CREATE TABLE cover (netID CHAR(20),
                    meeting_time CHAR(20),
                    meeting_room CHAR(20),
                    PRIMARY KEY (netID, meeting_time, meeting_room),
                    FOREIGN KEY (netID) REFERENCES TA,
                    FOREIGN KEY (meeting_time, meeting_room) REFERENCES section_
                    )
CREATE TABLE create_hw (hw_number INTEGER,
                        netID CHAR(20),
                        PRIMARY KEY (hw_number),
                        --a homework has a unique homework number
                        FOREIGN KEY (netID) REFERENCES employee,
                        FOREIGN KEY (hw_number) REFERENCES homework
                        )

--B.4
CREATE TABLE artist (name CHAR(20),
                     birthplace CHAR(20),
                     style CHAR(20),
                     age INTEGER,
                     PRIMARY KEY (name)
                     )
CREATE TABLE artwork (title CHAR(20),
                      type CHAR(20),
                      year INTEGER,
                      price REAL,
                      PRIMARY KEY (title)
                      )
CREATE TABLE group_of_kind (groupname CHAR(20))
CREATE TABLE customer (spent REAL,
                       cname CHAR(20),
                       address CHAR(50),
                       PRIMARY KEY (cname)
                       )
CREATE TABLE created (name CHAR(20),
                      title CHAR(20),
                      PRIMARY KEY (name, title),
                      FOREIGN KEY (name) REFERENCES artist,
                      FOREIGN KEY (title) REFERENCES artwork
                      )
CREATE TABLE like_group (cname CHAR(20),
                         groupname CHAR(20),
                         PRIMARY KEY (cname, groupname),
                         FOREIGN KEY (cname) REFERENCES customer,
                         FOREIGN KEY (groupname) REFERENCES group_of_kind
                         )
CREATE TABLE like_artist (cname CHAR(20),
                          name CHAR(20),
                          PRIMARY KEY (cname, name),
                          FOREIGN KEY (cname) REFERENCES customer,
                          FOREIGN KEY (name) REFERENCES artist
                          )
CREATE TABLE classified_into (title CHAR(20),
                              groupname CHAR(20),
                              PRIMARY KEY (title, groupname),
                              FOREIGN KEY (title) REFERENCES artwork,
                              FOREIGN KEY (groupname) REFERENCES group_of_kind
                              )
