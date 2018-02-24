/**
 * @file MyUnitTestEA.mq5
 * @author Rodrigo Haller
 * @date 09/02/2018
 * @brief This file represents an Expert Advisor capable of running
 * our Test Unit. It also demonstrates how to use it properly.
 */
#property copyright "Copyright © 2018, Rodrigo Haller"
#property link      "https://www.linkedin.com/in/rodrigohaller/"
#property version   "1.00"
#property strict

#include "../Include/MTUnit.mqh" 			//Includes the UnitTest class

/**
 * @brief Expert OnInit function
 * @details Call UT_OnInit() in your Expert's OnInit() method to run
 * the tests.
 * @return Expert return status
 */
int OnInit()
{
    UT_OnInit();
    return (INIT_SUCCEEDED);
}

/**
 * @brief Expert OnDeinit function
 * @details Call UT_OnDeInit() in your Expert's OnDeinit() method to
 * delete the UnitTest objects.
 */
void OnDeinit(const int reason)
{
    UT_OnDeinit();
}

/**
 * @brief Expert tick function *DISABLED*
 * @details Not commonly used, but if you have tests that should run
 * on each Tick, call UT_OnTick().
 * @warning Do not forget to set g_unitTestingOnTick to true
 * @note This option is disabled for now, since I don't see any use
 * for this. UnitTests should not rely on random data, that's why
 * mocking objects exist. So I don't see the point of testing during
 * ticks.
 */
void OnTick()
{
    UT_OnTick();
}

//Sample of Global Scope Methods

double getMA(int shift)
{
    return (iMA(NULL, 0, 13, shift, MODE_SMA, PRICE_CLOSE));
}
 
void getMAArray(const int &shifts[], double &mas[])
{
    for(int i = 0; i < ArraySize(shifts); i++)
    {
        mas[i] = getMA(shifts[i]);
    }
}