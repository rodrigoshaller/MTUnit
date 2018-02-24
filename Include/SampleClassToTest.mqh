/**
* @file SampleClassToTest.mqh
* @author Rodrigo Haller
* @date 18/02/2018
* @brief This file contains a sample class containing examples of
* a few methods that will be tested by the MTUnit.
*/

#property copyright "Copyright © 2018, Rodrigo Haller"
#property link      "https://www.linkedin.com/in/rodrigohaller/"
#property version   "1.00"
#property strict

class SampleClassToTest
{
public:
    SampleClassToTest() {}
    ~SampleClassToTest() {}
    bool samplePublicMethod()
    {
        return true;
    }

    static bool sampleStaticMethod()
    {
        return true;
    }

    bool samplePublicMethodToTestPrivateMethods()
    {
        return samplePrivateMethod();
    }

protected:
    bool sampleProtectedMethod()
    {
        return true;
    }

    bool sampleProtectedMethodToTestPrivateMethods()
    {
        return samplePrivateMethod();
    }

private:
    bool samplePrivateMethod()
    {
        return true;
    }    
};