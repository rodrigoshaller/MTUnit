/**
* @file MTUnitAllTests.mqh
* @author Rodrigo Haller
* @date 24/02/2018
* @brief This file is auto generated. It contains all tests that the
* unit test will run.
*/

#property copyright "Copyright © 2018, Rodrigo Haller"
#property link      "https://www.linkedin.com/in/rodrigohaller/"
#property version   "1.00"
#property strict

#include "../Include/MTUnit.mqh"
#include "../Include/MTUnitCfg.mqh"

//Includes will be added here automatically (from Test folder)
#include "../Test/BasicTestSuite_Test.mqh"

class MTUnitAllTests
{
public:
    MTUnitAllTests() {}
    ~MTUnitAllTests() {}
    void runAllTests()
    {
        g_mtUnit.initTests();

        //Auto generated tests for MyBasicTestSuite Class:
        MyBasicTestSuite* myBasicTestSuite = new MyBasicTestSuite();
        g_mtUnit.initTestSuite("MyBasicTestSuite");
        g_mtUnit.initTestCase("test_bool_assertTrue_succeed"); myBasicTestSuite.setUp(); myBasicTestSuite.test_bool_assertTrue_succeed(); myBasicTestSuite.tearDown(); g_mtUnit.endTestCase();
        g_mtUnit.initTestCase("test_bool_assertFalse_succeed"); myBasicTestSuite.setUp(); myBasicTestSuite.test_bool_assertFalse_succeed(); myBasicTestSuite.tearDown(); g_mtUnit.endTestCase();
        g_mtUnit.initTestCase("test_integers_int_assertEquals_succeed"); myBasicTestSuite.setUp(); myBasicTestSuite.test_integers_int_assertEquals_succeed(); myBasicTestSuite.tearDown(); g_mtUnit.endTestCase();
        g_mtUnit.initTestCase("test_integers_long_assertEquals_succeed"); myBasicTestSuite.setUp(); myBasicTestSuite.test_integers_long_assertEquals_succeed(); myBasicTestSuite.tearDown(); g_mtUnit.endTestCase();
        g_mtUnit.initTestCase("test_float_assertEquals_succeed"); myBasicTestSuite.setUp(); myBasicTestSuite.test_float_assertEquals_succeed(); myBasicTestSuite.tearDown(); g_mtUnit.endTestCase();
        g_mtUnit.initTestCase("test_double_assertEquals_succeed"); myBasicTestSuite.setUp(); myBasicTestSuite.test_double_assertEquals_succeed(); myBasicTestSuite.tearDown(); g_mtUnit.endTestCase();
        g_mtUnit.initTestCase("test_string_assertEquals_succeed"); myBasicTestSuite.setUp(); myBasicTestSuite.test_string_assertEquals_succeed(); myBasicTestSuite.tearDown(); g_mtUnit.endTestCase();
        g_mtUnit.endTestSuite();
        delete myBasicTestSuite;

        //Auto generated tests for MyClassTestingTestSuite Class:
        MyClassTestingTestSuite* myClassTestingTestSuite = new MyClassTestingTestSuite();
        g_mtUnit.initTestSuite("MyClassTestingTestSuite");
        g_mtUnit.initTestCase("test_publicMethods"); myClassTestingTestSuite.setUp(); myClassTestingTestSuite.test_publicMethods(); myClassTestingTestSuite.tearDown(); g_mtUnit.endTestCase();
        g_mtUnit.initTestCase("test_staticMethods"); myClassTestingTestSuite.setUp(); myClassTestingTestSuite.test_staticMethods(); myClassTestingTestSuite.tearDown(); g_mtUnit.endTestCase();
        g_mtUnit.initTestCase("test_privateMethods"); myClassTestingTestSuite.setUp(); myClassTestingTestSuite.test_privateMethods(); myClassTestingTestSuite.tearDown(); g_mtUnit.endTestCase();
        g_mtUnit.endTestSuite();
        delete myClassTestingTestSuite;

        //Auto generated tests for MyGlobalScopeTestSuite Class:
        MyGlobalScopeTestSuite* myGlobalScopeTestSuite = new MyGlobalScopeTestSuite();
        g_mtUnit.initTestSuite("MyGlobalScopeTestSuite");
        g_mtUnit.initTestCase("test_GetMA_shoudReturnSMA"); myGlobalScopeTestSuite.setUp(); myGlobalScopeTestSuite.test_GetMA_shoudReturnSMA(); myGlobalScopeTestSuite.tearDown(); g_mtUnit.endTestCase();
        g_mtUnit.initTestCase("test_GetMAArray_shoudReturnCoupleOfSMA"); myGlobalScopeTestSuite.setUp(); myGlobalScopeTestSuite.test_GetMAArray_shoudReturnCoupleOfSMA(); myGlobalScopeTestSuite.tearDown(); g_mtUnit.endTestCase();
        g_mtUnit.endTestSuite();
        delete myGlobalScopeTestSuite;

        //Auto generated tests for MyInheritedTestSuite Class:
        MyInheritedTestSuite* myInheritedTestSuite = new MyInheritedTestSuite();
        g_mtUnit.initTestSuite("MyInheritedTestSuite");
        g_mtUnit.initTestCase("test_publicInheritedMethods"); myInheritedTestSuite.setUp(); myInheritedTestSuite.test_publicInheritedMethods(); myInheritedTestSuite.tearDown(); g_mtUnit.endTestCase();
        g_mtUnit.initTestCase("test_protectedInheritedMethods"); myInheritedTestSuite.setUp(); myInheritedTestSuite.test_protectedInheritedMethods(); myInheritedTestSuite.tearDown(); g_mtUnit.endTestCase();
        g_mtUnit.initTestCase("test_privateInheritedMethods"); myInheritedTestSuite.setUp(); myInheritedTestSuite.test_privateInheritedMethods(); myInheritedTestSuite.tearDown(); g_mtUnit.endTestCase();
        g_mtUnit.endTestSuite();
        delete myInheritedTestSuite;
        g_mtUnit.endTests();

    }
};
//This file is auto generated!