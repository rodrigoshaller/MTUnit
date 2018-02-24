/**
 * @file BasicTestSuite_Test.mqh
 * @author Rodrigo Haller
 * @date 09/02/2018
 * @brief File containing the implementation of all Unit Test methods
 */

#property copyright "Copyright © 2018, Rodrigo Haller"
#property link      "https://www.linkedin.com/in/rodrigohaller/"
#property version   "1.00"
#property strict

#include "../Include/MTUnit.mqh"
#include "../Include/SampleClassToTest.mqh" //SampleClass to demonstrate Inheritance testing

/**
 * @brief Example of Test Suite
 * @details Run some basic assertions
 */
class MyBasicTestSuite// : public BaseClassWeWannaTest
{
public:
    /**
     * @brief Initializes each test case
     * @details This is called before each test case runs
     */
    void setUp()
    {
    }
    /**
     * @brief Terminate each test case
     * @details This is called after each test case runs
     */
    void tearDown()
    {
    }

    void test_bool_assertTrue_succeed()
    {
        g_mtUnit.assertTrue(true, "assertTrue 1 should succeed");
        //g_mtUnit.assertTrue(false, "assertTrue should fail"); //comment this line to pass this test case
        g_mtUnit.assertTrue(true, "assertTrue 2 should succeed");
    }

    void test_bool_assertFalse_succeed()
    {
        g_mtUnit.assertFalse(false, "assertFalse should succeed");
        //g_mtUnit.assertFalse(true, "assertFalse should fail"); //comment this line to pass this test case
    }

    void test_integers_int_assertEquals_succeed()
    {
        int intValue = 23;
        g_mtUnit.assertEquals(intValue, 23, "assertEquals with 2 integers should succeed");
        intValue = 24;
        //g_mtUnit.assertEquals(intValue, 23, "assertEquals with 2 integers should fail"); //comment this line to pass this test case
        intValue = 2147483647;
        intValue++;
        g_mtUnit.assertEquals(intValue, int(-2147483648), "assertEquals overflow of an integer should succeed");
    }

    void test_integers_long_assertEquals_succeed()
    {
        long longValue = 2147483648;
        g_mtUnit.assertEquals(longValue, long(2147483648), "assertEquals with 2 longs should succeed");
        longValue = 2147483649;
        //g_mtUnit.assertEquals(longValue, long(2147483648), "assertEquals with 2 integers should fail"); //comment this line to pass this test case
        longValue = 9223372036854775807;
        longValue++;
        g_mtUnit.assertEquals(longValue, long(-9223372036854775808), "assertEquals overflow of a long should succeed");
    }

    void test_float_assertEquals_succeed()
    { 
        float floatVal = 42.0;
        g_mtUnit.assertEquals(floatVal, 42.0f, "assertEquals with 2 floats should succeed");
        floatVal = 43.0;
        //g_mtUnit.assertEquals(floatVal, expected, "assertEquals with 2 floats should fail"); //comment this line to pass this test case
    }

    void test_double_assertEquals_succeed()
    { 
        double doubleVal = 42.0;
        g_mtUnit.assertEquals(doubleVal, 42.0, "assertEquals with 2 doubles should succeed");
        doubleVal = 43.0;
        //g_mtUnit.assertEquals(doubleVal, expected, "assertEquals with 2 doubles should fail"); //comment this line to pass this test case
    }

    void test_string_assertEquals_succeed()
    {
        string actual, expected;
        expected = "abc";
        actual = "abc";
        g_mtUnit.assertEquals(actual, expected, "assertEquals with 2 strings should succeed");
        actual = "abA";
        //g_mtUnit.assertEquals(actual, expected, "assertEquals with 2 strings should fail"); //comment this line to pass this test case
    }
};

/**
 * @brief Example of Test Suite
 * @details Run some tests within a global scope
 */
class MyGlobalScopeTestSuite// : public BaseClassWeWannaTest
{
public:
    /**
     * @brief Initializes each test case
     * @details This is called before each test case runs
     */
    void setUp()
    {
    }
    /**
     * @brief Terminate each test case
     * @details This is called after each test case runs
     */
    void tearDown()
    {
    }

    void test_GetMA_shoudReturnSMA()
    {
        const double actual = getMA(3);
        const double expected = iMA(NULL, 0, 13, 3, MODE_SMA, PRICE_CLOSE);

        g_mtUnit.assertEquals(actual, expected, "MA must be SMA and 3 bars shifted");
        //g_mtUnit.assertTrue(false, "assertTrue should fail"); //comment this line to pass this test case
    }

    void test_GetMAArray_shoudReturnCoupleOfSMA()
    {
        const int shifts[] = {4, 5};
        double actual[2];
        getMAArray(shifts, actual);

        double expected[2];
        expected[0] = iMA(NULL, 0, 13, 4, MODE_SMA, PRICE_CLOSE);
        expected[1] = iMA(NULL, 0, 13, 5, MODE_SMA, PRICE_CLOSE);

        g_mtUnit.assertEquals(actual, expected, "MA array must contains a couple of SMA");
        //g_mtUnit.assertTrue(false, "assertTrue should fail"); //comment this line to pass this test case
    }
};


/**
 * @brief Example of Test Suite
 * @details Run some tests using direct object casting
 */
class MyClassTestingTestSuite
{
public:
    /**
     * @brief Initializes each test case
     * @details This is called before each test case runs
     */
    void setUp()
    {
        m_obj = new SampleClassToTest(); //This object is instantiated before each testCase
    }
    /**
     * @brief Terminate each test case
     * @details This is called after each test case runs
     */
    void tearDown()
    {
        delete m_obj; //This object is deleted after each testCase
    }

    void test_publicMethods()
    {
        //It is possible to test public methods using a class private object m_obj
        g_mtUnit.assertTrue(m_obj.samplePublicMethod(), "Test a Public Method using a class private object");
        //m_obj is created on setUp() and deleted on tearDown() automatically.

        //Or the object can be created right away
        SampleClassToTest *obj = new SampleClassToTest();
        g_mtUnit.assertTrue(obj.samplePublicMethod(), "Test a Public Method using a new object");
        delete obj; //Do not forget to delete the object;
    }

    void test_staticMethods()
    {
        g_mtUnit.assertTrue(SampleClassToTest::sampleStaticMethod(), "Test a Static Method using a direct call");
    }

//    void test_protectedMethods()
//    {
//        g_mtUnit.assertTrue(m_obj.sampleProtectedMethod(), "Test a Protected Method");  //Cannot access protected members directly
//    }

    void test_privateMethods()
    {
        //g_mtUnit.assertTrue(m_obj.samplePrivateMethod(), "Test a Private Method"); //Cannot access private members directly
        g_mtUnit.assertTrue(m_obj.samplePublicMethodToTestPrivateMethods(), "Test a Private Method"); //So a public or protected method can be used to call the private one
    }

private:
    SampleClassToTest *m_obj;
};

/**
 * @brief Example of Test Suite
 * @details Run some tests inherited from a parent class
 */
class MyInheritedTestSuite : public SampleClassToTest
{
public:
    /**
     * @brief Initializes each test case
     * @details This is called before each test case runs
     */
    void setUp()
    {
    }
    /**
     * @brief Terminate each test case
     * @details This is called after each test case runs
     */
    void tearDown()
    {
    }

    void test_publicInheritedMethods()
    {
        g_mtUnit.assertTrue(samplePublicMethod(), "Test a Public Inherited Method");
    }

    void test_protectedInheritedMethods()
    {
        g_mtUnit.assertTrue(sampleProtectedMethod(), "Test a Protected Inherited Method");
    }

    void test_privateInheritedMethods()
    {
        //g_mtUnit.assertTrue(samplePrivateMethod(), "Test a Private Inherited Method"); //Cannot access private members directly
        g_mtUnit.assertTrue(sampleProtectedMethodToTestPrivateMethods(), "Test a Private Inherited Method"); //So a public or protected method can be used to call the private one
    }

};