#!/bin/bash
set e
            cd build &&
            ./ConditionCoverageTest &&       
            cd .. && pwd && ls &&
            ## search for all *.gcno and *.gcda files, "xargs" is used to call "gcov" on every file that is found
            find . -iname "*.gcno" -o -iname "*.gcda" | xargs gcov &&
            ## user with sonar.cxx.coverage.reportPath
            gcovr -r . --branches --xml-pretty > ./build/Report-Gcov.xml
            cat ./build/Report-Gcov.xml

            ## user with sonar.coverageReportPaths
            #gcovr -r . --branches --sonarqube > ./build/sonar-Report-Gcov.xml
            #cat ./build/sonar-Report-Gcov.xml

            ls
            