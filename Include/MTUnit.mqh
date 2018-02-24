/**
 * @file MTUnit.mqh
 * @author Rodrigo Haller
 * @date 09/02/2018
 * @brief File containing a Unit Test library developed for MQL5
 * This file was based on this article: https://www.mql5.com/ru/articles/1579
 */

#property copyright "Copyright © 2018, Rodrigo Haller"
#property link      "https://www.linkedin.com/in/rodrigohaller/"
#property version   "1.00"
#property strict

#include "MTUnitCfg.mqh"
#include "MTUnitAllTests.mqh"

class MyMTUnit;
class MTUnit;

MTUnit *g_mtUnit;
MTUnitAllTests *g_mtUnitAllTests;

/**
 * @brief OnInit method of the MTUnit.
 * @details This method should be called by the EA's OnInit method
 */
void UT_OnInit()
{
    if(!g_unitTesting)
        return;

    g_mtUnit = new MTUnit();
    g_mtUnitAllTests = new MTUnitAllTests();

    if(g_unitTestingOnInit)
        g_mtUnitAllTests.runAllTests();
    
//    if(g_mtUnitingOnLoop) //Disabled for now...
//    {
//        datetime prev_time = TimeLocal();
//        while(true)
//        {
//            if((TimeLocal() - prev_time) >= 1) //Do stuff once per second
//            {
//                prev_time = TimeLocal();
//                g_mtUnitAllTests.runAllTests();
//            }
//            Sleep(g_loopMS);
//        }
//    }
}
 
void UT_OnDeinit()
{
    delete g_mtUnitAllTests;
    delete g_mtUnit;
}
 
void UT_OnTick()
{ //Disabled for now... 
//    if(g_mtUniting && g_mtUnitingOnTick)
//        g_mtUnitAllTests.onTickTests();
}


#define UT_SPACE_TESTCASE "  "
#define UT_SPACE_ASSERT "[TEST] "
#define UT_SEP " - "
#define UT_COMP_EXP_ACT "%s: expected is <%s> but <%s>"
#define UT_COMP_ARR_EXP_ACT "%s: expected array[%d] is <%s> but <%s>"
#define UT_DEFAULT_ASSERT_MESSAGE "Assert should succeed"

class MTUnit
{
public:
    MTUnit();
    ~MTUnit();
    
    //Inits and deinits
    void initTests();
    void endTests();

    void initTestSuite(string testSuiteName);
    void endTestSuite();
    
    void initTestCase(string testCaseName);
    void endTestCase();
    
    //Basic asserts
    void assertTrue(bool actual, string message);
    void assertFalse(bool actual, string message);
    
    void assertEquals(bool actual, bool expected, string message);
    void assertEquals(char actual, char expected, string message);
    void assertEquals(uchar actual, uchar expected, string message);
    void assertEquals(short actual, short expected, string message);
    void assertEquals(ushort actual, ushort expected, string message);
    void assertEquals(int actual, int expected, string message);
    void assertEquals(uint actual, uint expected, string message);
    void assertEquals(long actual, long expected, string message);
    void assertEquals(ulong actual, ulong expected, string message);
    void assertEquals(float actual, float expected, string message);
    void assertEquals(double actual, double expected, string message);
    void assertEquals(string actual, string expected, string message);
    void assertEquals(datetime actual, datetime expected, string message);
    void assertEquals(color actual, color expected, string message);
    
    //Arrays asserts
    void assertEquals(const bool &expected[], const bool &actual[], string message);
    void assertEquals(const char &expected[], const char &actual[], string message);
    void assertEquals(const uchar &expected[], const uchar &actual[], string message);
    void assertEquals(const short &expected[], const short &actual[], string message);
    void assertEquals(const ushort &expected[], const ushort &actual[], string message);
    void assertEquals(const int &expected[], const int &actual[], string message);
    void assertEquals(const uint &expected[], const uint &actual[], string message);
    void assertEquals(const long &expected[], const long &actual[], string message);
    void assertEquals(const ulong &expected[], const ulong &actual[], string message);
    void assertEquals(const float &expected[], const float &actual[], string message);
    void assertEquals(const double &expected[], const double &actual[], string message);
    void assertEquals(const string &expected[], const string &actual[], string message);
    void assertEquals(const datetime &expected[], const datetime &actual[], string message);
    void assertEquals(const color &expected[], const color &actual[], string message);
     
private:
    int m_unitTestTests;
    int m_unitTestTestsFail;
    
    int m_unitTestAsserts;
    int m_unitTestAssertsFail;

    int m_testSuiteTests;
    int m_testSuiteTestsFail;

    int m_testSuiteAsserts;
    int m_testSuiteAssertsFail;

    int m_testCaseAsserts;
    int m_testCaseAssertsFail;

    unsigned long m_elapsedTimeTestUnit;
    unsigned long m_elapsedTimeTestSuite;
    unsigned long m_elapsedTimeTestCase;

    string m_currentTestCaseName;
    string m_currentTestSuiteName;

    void addAssert();

    void setAssertSuccess(string message);
    void setAssertFailure(string message);

    void assertTrueFalse(bool actual, bool expected, string message);
    bool assertArraySize(const int actualSize, const int expectedSize, string message);
    
    void printMTUnitSummary();
    void printTestSuiteSummary();        
    void printTestCaseSummary();
    string summary(int count, int countFail);
};
 
MTUnit::MTUnit()
{
}
 
MTUnit::~MTUnit()
{
}
 
void MTUnit::initTests()
{
    Comment("");
    Print("Running Tests");
    Print("================================================================================================");
    
    m_unitTestTests = 0;
    m_unitTestTestsFail = 0;
    m_unitTestAsserts = 0;
    m_unitTestAssertsFail = 0;

    m_testSuiteTests = 0;
    m_testSuiteTestsFail = 0;
    m_testSuiteAsserts = 0;
    m_testSuiteAssertsFail = 0;
    
    m_testCaseAsserts = 0;
    m_testCaseAssertsFail = 0;
    
    m_elapsedTimeTestUnit = GetMicrosecondCount();
}

void MTUnit::endTests()
{
    printMTUnitSummary();
}

void MTUnit::initTestSuite(string testSuiteName)
{
    Print("Test Suite: ", testSuiteName);
    m_currentTestSuiteName = testSuiteName;
    m_testSuiteTests = 0;
    m_testSuiteTestsFail = 0;
    m_testSuiteAsserts = 0;
    m_testSuiteAssertsFail = 0;
    m_elapsedTimeTestSuite = GetMicrosecondCount();
}
 
void MTUnit::endTestSuite()
{
    printTestSuiteSummary();
}
 
void MTUnit::initTestCase(string testCaseName)
{
    Print("-> Running Test Case: ", testCaseName);
    m_currentTestCaseName = testCaseName;
    m_testCaseAsserts = 0;
    m_testCaseAssertsFail = 0;
    m_unitTestTests += 1;
    m_testSuiteTests += 1;
    m_elapsedTimeTestCase = GetMicrosecondCount();
}
 
void MTUnit::endTestCase()
{
    printTestCaseSummary();
    if(m_testCaseAssertsFail != 0 || m_testCaseAsserts == 0)
    {
        m_unitTestTestsFail += 1;
        m_testSuiteTestsFail += 1;
    }
}

void MTUnit::printMTUnitSummary()
{
    Print("================================================================================================");
    Print("Overall Summary:");
    Print("Total Elapsed Time: ", GetMicrosecondCount() - m_elapsedTimeTestUnit, "us");
    string strAsserts = "Asserts: " + summary(m_unitTestAsserts, m_unitTestAssertsFail);
    string strTests =   "Tests:   " + summary(m_unitTestTests, m_unitTestTestsFail) + UT_SEP + "Final Result: " +
                        getOKFail(m_unitTestTestsFail == 0);

    Print(strAsserts);
    Print(strTests);
    Print("================================================================================================");
    Comment(strTests + "\n" + strAsserts);
}
 
void MTUnit::printTestSuiteSummary()
{
    Print("------------------------------------------------------------------------------------------------");
    Print(m_currentTestSuiteName, " Summary:");
    Print("Elapsed Time: " + StringFormat("%d", GetMicrosecondCount() - m_elapsedTimeTestSuite) + "us");
    string strAsserts = "Asserts: " + summary(m_testSuiteAsserts, m_testSuiteAssertsFail);
    string strTests =   "Tests:   " + summary(m_testSuiteTests, m_testSuiteTestsFail) + UT_SEP + "Final Result: " +
                        getOKFail(m_testSuiteTestsFail == 0);

    Print(strAsserts);
    Print(strTests);
    Print("------------------------------------------------------------------------------------------------");
}

void MTUnit::printTestCaseSummary()
{
    string s = "RESULT: " + 
            getOKFail(m_testCaseAssertsFail == 0) + UT_SEP + 
            summary(m_testCaseAsserts, m_testCaseAssertsFail) +
            " - Elapsed Time: " + StringFormat("%d", GetMicrosecondCount() - m_elapsedTimeTestCase) + "us";
    
    Print(s);
}

string MTUnit::summary(int count, int countFail)
{
    int countSuccess = count-countFail;
    double countSuccessPercent;
    double countFailurePercent;
    if(count != 0)
    {
        countSuccessPercent = 100.0 * countSuccess/count;
        countFailurePercent = 100.0 * countFail/count;
    }
    else
    {
        countSuccessPercent = 100.0;
        countFailurePercent = 0.0;
    }
    
    string s = StringFormat("Total: %d, Success: %d (%.2f%%), Failure: %d (%.2f%%)", 
                          count, countSuccess, countSuccessPercent, 
                          countFail, countFailurePercent);
    return(s);
}

string getOKFail(bool ok)
{
    if(ok)
        return("    OK    ");
    else
        return("***FAIL***");
}
 
void MTUnit::addAssert()
{
    m_testCaseAsserts += 1;
    m_testSuiteAsserts += 1;
    m_unitTestAsserts += 1;
}
 
void MTUnit::setAssertSuccess(string message)
{
    Print(UT_SPACE_ASSERT, message, UT_SEP, getOKFail(true));
}

void MTUnit::setAssertFailure(string message)
{
    m_testCaseAssertsFail += 1;
    m_testSuiteAssertsFail += 1;
    m_unitTestAssertsFail += 1;
    Print(UT_SPACE_ASSERT, message, UT_SEP, getOKFail(false));
    if(g_alertWhenFailed)
        Alert(getOKFail(false), UT_SEP, message);
}
 
void MTUnit::assertTrueFalse(bool actual, bool expected, string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    
    if(actual == expected)
        setAssertSuccess(message);
    else
    {
        message = StringFormat(UT_COMP_EXP_ACT, message, boolToString(expected), boolToString(actual));
        setAssertFailure(message);
    }
}
 
void MTUnit::assertTrue(bool actual, string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    assertTrueFalse(true, actual, message);
}
 
void MTUnit::assertFalse(bool actual, string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    assertTrueFalse(false, actual, message);
}
 
void MTUnit::assertEquals(char actual, char expected, string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    
    if(actual == expected)
        setAssertSuccess(message);
    else
    {
        message = StringFormat(UT_COMP_EXP_ACT, message, CharToString(expected), CharToString(actual));
        setAssertFailure(message);
    }
}
 
void MTUnit::assertEquals(uchar actual, uchar expected, string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    
    if(actual == expected)
        setAssertSuccess(message);
    else
    {
        message = StringFormat(UT_COMP_EXP_ACT, message, CharToString(expected), CharToString(actual));
        setAssertFailure(message);
    }
}
 
void MTUnit::assertEquals(short actual, short expected, string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    
    if(actual == expected)
        setAssertSuccess(message);
    else
    {
        message = StringFormat(UT_COMP_EXP_ACT, message, IntegerToString(expected), IntegerToString(actual));
        setAssertFailure(message);
    }
}
 
void MTUnit::assertEquals(ushort actual, ushort expected, string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    
    if(actual == expected)
        setAssertSuccess(message);
    else
    {
        message = StringFormat(UT_COMP_EXP_ACT, message, IntegerToString(expected), IntegerToString(actual));
        setAssertFailure(message);
    }
}
 
void MTUnit::assertEquals(int actual, int expected, string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    
    if(actual == expected)
        setAssertSuccess(message);
    else
    {
        message = StringFormat(UT_COMP_EXP_ACT, message, IntegerToString(expected), IntegerToString(actual));
        setAssertFailure(message);
    }
}
 
void MTUnit::assertEquals(uint actual, uint expected, string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    
    if(actual == expected)
        setAssertSuccess(message);
    else
    {
        message = StringFormat(UT_COMP_EXP_ACT, message, IntegerToString(expected), IntegerToString(actual));
        setAssertFailure(message);
    }
}
 
void MTUnit::assertEquals(long actual, long expected, string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    
    if(actual == expected)
        setAssertSuccess(message);
    else
    {
        message = StringFormat(UT_COMP_EXP_ACT, message, IntegerToString(expected), IntegerToString(actual));
        setAssertFailure(message);
    }
}
 
void MTUnit::assertEquals(ulong actual, ulong expected, string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    
    if(actual == expected)
        setAssertSuccess(message);
    else
    {
        message = StringFormat(UT_COMP_EXP_ACT, message, IntegerToString(expected), IntegerToString(actual));
        setAssertFailure(message);
    }
}
 
void MTUnit::assertEquals(float actual, float expected, string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    
    if(actual == expected)
        setAssertSuccess(message);
    else
    {
        message = StringFormat(UT_COMP_EXP_ACT, message, DoubleToString(expected), DoubleToString(actual));
        setAssertFailure(message);
    }
}
 
void MTUnit::assertEquals(double actual, double expected, string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    
    if(actual == expected)
        setAssertSuccess(message);
    else
    {
        message = StringFormat(UT_COMP_EXP_ACT, message, DoubleToString(expected), DoubleToString(actual));
        setAssertFailure(message);
    }
}
 
void MTUnit::assertEquals(string actual, string expected, string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    
    if(actual == expected)
        setAssertSuccess(message);
    else
    {
        message = StringFormat(UT_COMP_EXP_ACT, message, expected, actual);
        setAssertFailure(message);
    }
}
 
void MTUnit::assertEquals(datetime actual, datetime expected, string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    
    if(actual == expected)
        setAssertSuccess(message);
    else
    {
        message = StringFormat(UT_COMP_EXP_ACT, message, TimeToString(expected), TimeToString(actual));
        setAssertFailure(message);
    }
}
 
void MTUnit::assertEquals(color actual, color expected, string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    
    if(actual == expected)
        setAssertSuccess(message);
    else
    {
        message = StringFormat(UT_COMP_EXP_ACT, message, ColorToString(expected), ColorToString(actual));
        setAssertFailure(message);
    }
}

//Array asserts
void MTUnit::assertEquals(const bool &actual[], const bool &expected[], string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    const int expectedSize = ArraySize(expected);
    const int actualSize = ArraySize(actual);
    
    if(!assertArraySize(expectedSize, actualSize, message))
        return;
    
    for(int i = 0; i < actualSize; i++)
    {
        if(expected[i] != actual[i])
        {
            message = StringFormat(UT_COMP_ARR_EXP_ACT, message, 
                                   i, boolToString(expected[i]), boolToString(actual[i]));
            setAssertFailure(message);
            return;
        }
    }
    
    setAssertSuccess(message);
}
 
void MTUnit::assertEquals(const char &actual[], const char &expected[], string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    const int expectedSize = ArraySize(expected);
    const int actualSize = ArraySize(actual);
    
    if(!assertArraySize(expectedSize, actualSize, message))
        return;
    
    for(int i = 0; i < actualSize; i++)
    {
        if(expected[i] != actual[i])
        {
            message = StringFormat(UT_COMP_ARR_EXP_ACT, message, 
                                   i, CharToString(expected[i]), CharToString(actual[i]));
            setAssertFailure(message);
            return;
        }
    }
    
    setAssertSuccess(message);
}
 
void MTUnit::assertEquals(const uchar &actual[], const uchar &expected[], string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    const int expectedSize = ArraySize(expected);
    const int actualSize = ArraySize(actual);
    
    if(!assertArraySize(expectedSize, actualSize, message))
        return;
    
    for(int i = 0; i < actualSize; i++)
    {
        if(expected[i] != actual[i])
        {
            message = StringFormat(UT_COMP_ARR_EXP_ACT, message, 
                                   i, CharToString(expected[i]), CharToString(actual[i]));
            setAssertFailure(message);
            return;
        }
    }
    
    setAssertSuccess(message);
}
 
void MTUnit::assertEquals(const short &actual[], const short &expected[], string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    const int expectedSize = ArraySize(expected);
    const int actualSize = ArraySize(actual);
    
    if(!assertArraySize(expectedSize, actualSize, message))
        return;
    
    for(int i = 0; i < actualSize; i++)
    {
        if(expected[i] != actual[i])
        {
            message = StringFormat(UT_COMP_ARR_EXP_ACT, message, 
                                   i, IntegerToString(expected[i]), IntegerToString(actual[i]));
            setAssertFailure(message);
            return;
        }
    }
    
    setAssertSuccess(message);
}
 
void MTUnit::assertEquals(const ushort &actual[], const ushort &expected[], string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    const int expectedSize = ArraySize(expected);
    const int actualSize = ArraySize(actual);
    
    if(!assertArraySize(expectedSize, actualSize, message))
        return;
    
    for(int i = 0; i < actualSize; i++)
    {
        if(expected[i] != actual[i])
        {
            message = StringFormat(UT_COMP_ARR_EXP_ACT, message, 
                                   i, IntegerToString(expected[i]), IntegerToString(actual[i]));
            setAssertFailure(message);
            return;
        }
    }
    
    setAssertSuccess(message);
}
 
void MTUnit::assertEquals(const int &actual[], const int &expected[], string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    const int expectedSize = ArraySize(expected);
    const int actualSize = ArraySize(actual);
    
    if(!assertArraySize(expectedSize, actualSize, message))
        return;
    
    for(int i = 0; i < actualSize; i++)
    {
        if(expected[i] != actual[i])
        {
            message = StringFormat(UT_COMP_ARR_EXP_ACT, message, 
                                   i, IntegerToString(expected[i]), IntegerToString(actual[i]));
            setAssertFailure(message);
            return;
        }
    }
    
    setAssertSuccess(message);
}
 
void MTUnit::assertEquals(const uint &actual[], const uint &expected[], string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    const int expectedSize = ArraySize(expected);
    const int actualSize = ArraySize(actual);
    
    if(!assertArraySize(expectedSize, actualSize, message))
        return;
    
    for(int i = 0; i < actualSize; i++)
    {
        if(expected[i] != actual[i])
        {
            message = StringFormat(UT_COMP_ARR_EXP_ACT, message, 
                                   i, IntegerToString(expected[i]), IntegerToString(actual[i]));
            setAssertFailure(message);
            return;
        }
    }
    
    setAssertSuccess(message);
}
 
void MTUnit::assertEquals(const long &actual[], const long &expected[], string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    const int expectedSize = ArraySize(expected);
    const int actualSize = ArraySize(actual);
    
    if(!assertArraySize(expectedSize, actualSize, message))
        return;
    
    for(int i = 0; i < actualSize; i++)
    {
        if(expected[i] != actual[i])
        {
            message = StringFormat(UT_COMP_ARR_EXP_ACT, message, 
                                   i, IntegerToString(expected[i]), IntegerToString(actual[i]));
            setAssertFailure(message);
            return;
        }
    }
    
    setAssertSuccess(message);
}
 
void MTUnit::assertEquals(const ulong &actual[], const ulong &expected[], string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    const int expectedSize = ArraySize(expected);
    const int actualSize = ArraySize(actual);
    
    if(!assertArraySize(expectedSize, actualSize, message))
        return;
    
    for(int i = 0; i < actualSize; i++)
    {
        if(expected[i] != actual[i])
        {
            message = StringFormat(UT_COMP_ARR_EXP_ACT, message, 
                                   i, IntegerToString(expected[i]), IntegerToString(actual[i]));
            setAssertFailure(message);
            return;
        }
    }
    
    setAssertSuccess(message);
}
 
void MTUnit::assertEquals(const float &actual[], const float &expected[], string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    const int expectedSize = ArraySize(expected);
    const int actualSize = ArraySize(actual);
    
    if(!assertArraySize(expectedSize, actualSize, message))
        return;
    
    for(int i = 0; i < actualSize; i++)
    {
        if(expected[i] != actual[i])
        {
            message = StringFormat(UT_COMP_ARR_EXP_ACT, message, 
                                   i, DoubleToString(expected[i]), DoubleToString(actual[i]));
            setAssertFailure(message);
            return;
        }
    }
    
    setAssertSuccess(message);
}
 
void MTUnit::assertEquals(const double &actual[], const double &expected[], string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    const int expectedSize = ArraySize(expected);
    const int actualSize = ArraySize(actual);
    
    if(!assertArraySize(expectedSize, actualSize, message))
        return;
    
    for(int i = 0; i < actualSize; i++)
    {
        if(expected[i] != actual[i])
        {
            message = StringFormat(UT_COMP_ARR_EXP_ACT, message, 
                                   i, DoubleToString(expected[i]), DoubleToString(actual[i]));
            setAssertFailure(message);
            return;
        }
    }
    
    setAssertSuccess(message);
}

void MTUnit::assertEquals(const datetime &actual[], const datetime &expected[], string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    const int expectedSize = ArraySize(expected);
    const int actualSize = ArraySize(actual);
    
    if(!assertArraySize(expectedSize, actualSize, message))
        return;
    
    for(int i = 0; i < actualSize; i++)
    {
        if(expected[i] != actual[i])
        {
            message = StringFormat(UT_COMP_ARR_EXP_ACT, message, 
                                   i, TimeToString(expected[i]), TimeToString(actual[i]));
            setAssertFailure(message);
            return;
        }
    }
    
    setAssertSuccess(message);
}
 
void MTUnit::assertEquals(const color &actual[], const color &expected[], string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    const int expectedSize = ArraySize(expected);
    const int actualSize = ArraySize(actual);
    
    if(!assertArraySize(expectedSize, actualSize, message))
        return;
    
    for(int i = 0; i < actualSize; i++)
    {
        if(expected[i] != actual[i])
        {
            message = StringFormat(UT_COMP_ARR_EXP_ACT, message, 
                                   i, ColorToString(expected[i]), ColorToString(actual[i]));
            setAssertFailure(message);
            return;
        }
    }
    
    setAssertSuccess(message);
}

bool MTUnit::assertArraySize(const int expectedSize, const int actualSize, string message = UT_DEFAULT_ASSERT_MESSAGE)
{
    addAssert();
    if(actualSize == expectedSize)
        return true;
    else
    {
        message = StringFormat("%s: expected array size is <%s> but <%s>", message, 
                             IntegerToString(expectedSize), IntegerToString(actualSize));
        setAssertFailure(message);
        return false;
    }
}
 
string boolToString(bool b)
{
    if(b)
        return("true");
    else
        return("false");
}
