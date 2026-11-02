-- CREATE TABLE DIST_STUDENT_MASTER (
--     STUDENT_ID NUMBER PRIMARY KEY,
--     FULL_NAME VARCHAR2(50) NOT NULL,
--     PROGRAM VARCHAR2(50),
--     CAMPUS_LOC VARCHAR2(30),
--     SEMESTER_GPA NUMBER CHECK (SEMESTER_GPA BETWEEN 0.0 AND 10.0),
--     CREDITS_EARNED NUMBER CHECK (CREDITS_EARNED >= 0)
-- );

-- INSERT ALL
--     INTO DIST_STUDENT_MASTER VALUES (301, 'Aarav Sharma', 'MCA Data Science', 'Chandigarh', 8.7, 45)
--     INTO DIST_STUDENT_MASTER VALUES (302, 'Priya Verma', 'B.Tech CSE', 'Delhi', 9.2, 60)
--     INTO DIST_STUDENT_MASTER VALUES (303, 'Rohit Singh', 'MCA', 'Mohali', 7.5, 30)
--     INTO DIST_STUDent_MASTER VALUES (304, 'Ananya Gupta', 'MCA Data Science', 'Chandigarh', 9.5, 45)
--     INTO DIST_STUDENT_MASTER VALUES (305, 'Karan Malhotra', 'B.Tech ECE', 'Delhi', 6.8, 50)
-- SELECT * FROM DUAL;
-- COMMIT;

-- DECLARE
--     V_ID NUMBER := 306;
--     V_NAME VARCHAR2(50) := 'Neha Joshi';
--     V_PROG VARCHAR2(50) := 'MCA Data Science';
--     V_CAMPUS VARCHAR2(30) := 'Mohali';
--     V_GPA NUMBER := 8.9;
--     V_CREDITS NUMBER := 40;
-- BEGIN
--     INSERT INTO DIST_STUDENT_MASTER (STUDENT_ID, FULL_NAME, PROGRAM, CAMPUS_LOC, SEMESTER_GPA, CREDITS_EARNED)
--     VALUES (V_ID, V_NAME, V_PROG, V_CAMPUS, V_GPA, V_CREDITS);
--     COMMIT;
--     DBMS_OUTPUT.PUT_LINE('Student record inserted successfully via PL/SQL block.');
-- EXCEPTION
--     WHEN DUP_VAL_ON_INDEX THEN
--         ROLLBACK;
--         DBMS_OUTPUT.PUT_LINE('Error: Student ID already exists in the master table.');
--     WHEN OTHERS THEN
--         ROLLBACK;
--         DBMS_OUTPUT.PUT_LINE('Unexpected Database Error: ' || SQLERRM);
-- END;
-- /

-- SELECT * FROM DIST_STUDENT_MASTER ORDER BY STUDENT_ID;

-- SELECT * FROM DIST_STUDENT_MASTER WHERE STUDENT_ID = 301;

-- UPDATE DIST_STUDENT_MASTER 
-- SET SEMESTER_GPA = 9.0 
-- WHERE STUDENT_ID = 301;
-- COMMIT;
-- SELECT STUDENT_ID, FULL_NAME, SEMESTER_GPA FROM DIST_STUDENT_MASTER WHERE STUDENT_ID = 301;

-- DELETE FROM DIST_STUDENT_MASTER WHERE STUDENT_ID = 305;
-- COMMIT;
-- SELECT COUNT(*) AS TOTAL_ACTIVE_STUDENTS FROM DIST_STUDENT_MASTER;

-- SELECT * FROM DIST_STUDENT_MASTER WHERE CAMPUS_LOC = 'Chandigarh';

-- SELECT CAMPUS_LOC, COUNT(*) AS TOTAL_STUDENTS, AVG(SEMESTER_GPA) AS AVG_GPA
-- FROM DIST_STUDENT_MASTER
-- GROUP BY CAMPUS_LOC
-- ORDER BY CAMPUS_LOC;

-- SELECT 
--     MAX(SEMESTER_GPA) AS HIGHEST_GPA, 
--     MIN(SEMESTER_GPA) AS LOWEST_GPA, 
--     AVG(SEMESTER_GPA) AS INSTITUTION_AVG_GPA,
--     SUM(CREDITS_EARNED) AS TOTAL_CREDITS_AWARDED
-- FROM DIST_STUDENT_MASTER;

-- DECLARE
--     CURSOR STUDENT_CUR IS 
--         SELECT STUDENT_ID, FULL_NAME, PROGRAM, SEMESTER_GPA 
--         FROM DIST_STUDENT_MASTER 
--         ORDER BY STUDENT_ID;
    
--     V_ID DIST_STUDENT_MASTER.STUDENT_ID%TYPE;
--     V_NAME DIST_STUDENT_MASTER.FULL_NAME%TYPE;
--     V_PROG DIST_STUDENT_MASTER.PROGRAM%TYPE;
--     V_GPA DIST_STUDENT_MASTER.SEMESTER_GPA%TYPE;
-- BEGIN
--     DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
--     DBMS_OUTPUT.PUT_LINE('         DISTRIBUTED STUDENT ACADEMIC REPORT      ');
--     DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
    
--     OPEN STUDENT_CUR;
--     LOOP
--         FETCH STUDENT_CUR INTO V_ID, V_NAME, V_PROG, V_GPA;
--         EXIT WHEN STUDENT_CUR%NOTFOUND;
        
--         DBMS_OUTPUT.PUT_LINE('ID: ' || V_ID || ' | Name: ' || V_NAME || ' | Prog: ' || V_PROG || ' | GPA: ' || V_GPA);
--     END LOOP;
--     CLOSE STUDENT_CUR;
    
--     DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
-- EXCEPTION
--     WHEN OTHERS THEN
--         IF STUDENT_CUR%ISOPEN THEN
--             CLOSE STUDENT_CUR;
--         END IF;
--         DBMS_OUTPUT.PUT_LINE('Error encountered during cursor processing: ' || SQLERRM);
-- END;
-- /

-- DECLARE
--     V_ID NUMBER := 307;
--     V_NAME VARCHAR2(50) := 'Vikram Patel';
--     V_PROG VARCHAR2(50) := 'B.Tech IT';
--     V_CAMPUS VARCHAR2(30) := 'Chandigarh';
--     V_GPA NUMBER := 11.5; -- Invalid test GPA (> 10.0)
--     V_CREDITS NUMBER := 20;
-- BEGIN
--     IF V_GPA < 0.0 OR V_GPA > 10.0 THEN
--         RAISE_APPLICATION_ERROR(-20005, 'Invalid Semester GPA: Must be strictly between 0.0 and 10.0.');
--     END IF;

--     INSERT INTO DIST_STUDENT_MASTER (STUDENT_ID, FULL_NAME, PROGRAM, CAMPUS_LOC, SEMESTER_GPA, CREDITS_EARNED)
--     VALUES (V_ID, V_NAME, V_PROG, V_CAMPUS, V_GPA, V_CREDITS);
    
--     COMMIT;
--     DBMS_OUTPUT.PUT_LINE('Student added successfully.');
-- EXCEPTION
--     WHEN DUP_VAL_ON_INDEX THEN
--         ROLLBACK;
--         DBMS_OUTPUT.PUT_LINE('Error: Duplicate Student ID detected.');
--     WHEN OTHERS THEN
--         ROLLBACK;
--         DBMS_OUTPUT.PUT_LINE('Exception Caught: ' || SQLERRM);
-- END;
-- /

