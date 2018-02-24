# README #

# MTUnit - A Unit Test framework for MetaTrader 5
This project consists in a powerful Unit Test Framework for MetaTrader 5.

It was originally based on this article: https:/www.mql5.com/ru/articles/1579

As you might know, MetaTrader does not provide any kind of tool for unit testing natively. And that is probably the reason you are here.

My goal here was to develop a tool to help me applying Test-Driven-Development in my Expert Advisors. A wise decision since my EAs will be dealing with MY PRECIOUS MONEY!

This project is a set of many tools that work together so that the whole process can be automated.
Let me summarize some features, then.

### First of all: The Unit Test
It contains basically all the common assert methods used in unit testing.

If you need something more specific, you just need to implement yourself following the examples.
The MTUnit executes all the existing test cases of all test suites present in the Test folder. It reports time spent, number of asserts and tests executed, and also messages whether a test passes or fails (really?).

The Unit Test itself is amazing but since it is not integrated with MetaEditor, it needs some manual procedures in order to work.
For example, for each test written, the following workflow should be used to obtain more complete output results:
testCaseInit(), setUp(), testCase(), tearDown(), testCaseDeInit().

Also, the TestSuite should be init and deInit once, and the Unit Test library need to be aware of which testing suites it should execute, being necessary to instantiate an object of each testSuite somewhere in the Unit Test.

Yes, you can just copy and paste and change the test names, so it's not a big deal after everything is set up...

But this is a lot of manual work and it is enough for many people quit unit testing.

There comes the second tool...

### 2º Tool: MTUnitTestsCompiler
This tool goes through all files in the Test folder and generates an output file (MTUnitAllTests.mqh) containing all declarations and initializations for all tests. This unique file is used by the Unit Test and you don't even need to touch it. The only thing you need to do is write your tests inside the Test folder.

But... Isn't it frustrating to have to execute this tool every time I write or modify a new test??? If you are questioning yourself about this, welcome to the club of the lazy ones! (Nice to meet you, I'm the president!).

Guess what? I've made two solutions for you...

The first one is the simplest one and probably will be all you need (or not, if you are ok in writing the setups for your tests manually).

* There is a Watcher mode that monitors any change inside the Test directory. To enter this mode, just double click the file mtUnitHelper.exe inside the Runners folder.

@note Important: If you are cool in using MetaEditor, it's fine, you are done here. But if you are not so happy with MetaEditor limitations, I suggest you to continue this reading.

The second solution is more intense... Let's talk about environment.

``` bash
The environment should be protected at any cost! Stop polluting and please recycle your trash!
```
No no no, not this kind of environment...
Here is the thing, I particularly do not like to use the MetaEditor, it seems to be very limited in some important aspects.

So, the solution was to set up Sublime Text 3 (http:/www.sublimetext.com) to open .mq5 and .mqh files, apply syntax highlight, build, run the tests and show the output.
In order to do that, some scripts are used in Sublime.

The first one is: sublime_mql5 (a very suggestive name, indeed)

The original version can be found on: https:/github.com/rodrigopandini/sublime_mql5

I've made some modifications because the feature "Go to definition" was not working as well as a few other minor issues.
The version I'm using right know is included inside the "Other" folder.
This plugin executes a .bat file during the build phase, this .bat file is responsible for executing the MTUnitTestsCompiler tool,as well as the following (and last) two tools I am going to explain next.

In order to run the tests, it is necessary to execute the MetaTerminal. MetaTerminal needs to know the simulation parameters we want to use and to do so, it asks for a config file containing such parameters. One of these parameters is the "Expert", which is the path to the Expert Advisor we are testing.
In order to update this Expert param, this config file should be updated with whatever Expert you are willing to test... And you don't want to bother in doing something like that, do you?

### 3º Tool: MTUnitEALinker
So I present you the MTUnitEALinker (good name, right? I'm very creative, I know that).

The only thing it does is update that param. Yes, simple as pie, but it was needed.
The configuration file used is called autoRunTest.ini.
@note You don't need to interact with this tool. It's called automatically in the build script on Sublime Text.

All done!

...

No it is not!
Did you forget about the output? You wanna see if your tests passed, isn't it?
There we go, last but not least, the final tool: 

### Final Tool: MTUnitLogger
There is a log file automatic generated by MetaTerminal, but its location is hell, and it varies depending on the account you are using. Mine, for example is 
``` bash
C:\Program Files\MetaTrader 5\Tester\Agent-127.0.0.1-3000\logs\yyyymmdd.log
```
And the worst, it updates the freaking name of the file every day.
Another little detail, every time you run an Expert Advisor, the log content is appended to this file, so if you basically run 100 times in a single day, your output is going to be huge and unnecessary.

So what MTUnitLogger does?
It hijacks this log file, and erases the original one! By doing this, we guarantee that the next time you run your EA, the log file will contain information related to the last run only. All you have to do is edit the file logFolderPath.ini and put the correct path where MetaTerminal is generating its logFile. You can do it!

Fair enough, but I still have one more thing to tell you.
During the hijack, MTUnitLogger also adds some colors to our beautiful green passing tests, and some red to our failing ones. Just like magic!
But this is only possible if another plugin is added to Sublime Text, otherwise Sublime can't interpret output colors. 

This wonderful plugin is called SublimeANSI, which you can find here: https:/github.com/aziz/SublimeANSI

### Other Thoughts
Now, finishing up. The basic file structure you should use should respect that this project is using when you clone it:
It follows the MQL file structure, which basically is:
* Experts -> Folder to put your EA and where the .ex5 file will be generated.
* Include -> Place the MTUnit files and all your EA headers.
* Test -> Put all your test files in here so that MTUnitTestsCompiler can generate the proper MTUnitAllTests.mqh file (that will be generated in the Include folder above)
* Other -> Contains all the pluggins I'm using right know.
* Runners -> The folder where mtUnitHelper.exe (which contains MTUnitTestsCompiler, MTUnitEALinker and MTUnitLogger) and the config files are placed.

If you have a special need, you can modify the scripts or rebuild the tools for your own needs.

I've created a separate git repository for it: https://github.com/rodrigoshaller/MTUnitHelper

On MTUnitHelper's git you can find more detailed information about each tool.

The source code of the automation tools is not included in this project because I didn't want to mix up things. Despite both the MTUnit and the automation tools are used together, you can use them for your own purposes and rewrite them as you need.

___

### Extra Tool
There's a special Build type that can generates Doxygen documentation automatically as well. You just need to install Doxygen and create a Doxyfile through its GUI interface and place this Doxyfile in your Project's root folder.

There's also another plugin called DoxyDoc and can be downloaded directly from the Package Manager in Sublime. This plugin makes our life easier while documenting our code, since it injects a comment snippet automatically when you type /** + Return key.
___

The final result can be seen below:
![preview](imgs/preview.gif)

Fun Fact: It took me more time to write this text than doing all of this stuff.

Anyway, it is up to you now. You can use whatever tool you want, or all of them if it suits you best.
Just let me know if you have any suggestions, critiques or doubts.

That's all for today. I hope you enjoy.

Cheers,

Rodrigo Haller (rodrigoshaller@gmail.com)

This project is made under GNU General Public License