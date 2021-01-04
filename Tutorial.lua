-- First thing you need its require MoonProject;
local MoonProject = require "MoonProject"
--Lets see the changelog:
MoonProject.Info()

--If you wanna test, use MoonProject.Test(), it will create an c file and compile it, after done it will clean it (gcc required)
MoonProject.Test()

-- MoonProject.new will make a new project, lets take c as example
MoonProject.new('MyProgram', 'c') --Parameters: Name and language
-- After it will create the applying folder:
-- MyProgram
-- ├── src
-- |   ├── include
-- |   |   └── main.h
-- └── └── main.c

--Now lets make our project work! use SetEnv or SetDynamicEnv (you cannot use both at same time)
MoonProject.SetEnv('gcc', 'MyProgram/src/main.c', '-o', 'main.out')
--Next thing we need its Build after coding, building an run without effort
--Imagine we have a file called Build.lua in src folder
    MoonProject.BuildRun()
--After it will run and compile and run, and even clean the output file after that!
--If you wanna just Build, Run or clean, you can use one of these functions:
    MoonProject.Build()
--Alternative for Build:
MoonProject.SetDynamicEnv('go build', '.')
    MoonProject.BuildDynamic()
--Lets back to normal ones!
    MoonProject.Run()
    MoonProject.Clean('myfile.out')
--If you programming language (like golang) to compile the file is dynamic, use BuildRunDynamic, it will just get the compiler and filename
MoonProject.SetDynamicEnv('go build', '.') 
    MoonProject.BuildRunDynamic()

--I need suggestion so please if you have a suggestion start a pull request
--Current objective: make an argparse and flag system
--This may very simple, but in future it will be different, it just the start of another project!