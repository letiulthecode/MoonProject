--- Module for creating Coding projects
-- @script MoonProject
-- @author letiulthecode
-- @license MIT
-- @release 01/01/2021
local MoonProject = {}

MoonProject._VERSION = '0.4'
MoonProject._CHANGELOG = 'Tutorial updated, Made SetEnv and SetDynamicEnv, we preparing to remove BuildRun.'
MoonProject._LAST_UPDATE = '01/04/2021'

local exe = os.execute
local close = os.exit
local write = io.write
local remove = os.remove

---The data table contains data for a basic enviorment
--@table data
local data = {}

---The Dynamic Data table contains data for a dynamic enviorment
--@table dynamicdata
local dynamicdata = {}

---Insert a custom value in data table.
--@see data
function MoonProject.IncludeData(index, include)
   MoonProject.checknil(index, include)
   table.insert(data, index, include)
end

---Insert a custom value in dynamicdata table.
--@see dynamicdata
function MoonProject.IncludeDyData(index, include)
   MoonProject.checknil(index, include)
   table.insert(data, index, include)
end

--- Show information of Current version, changelog, etc
function MoonProject.Info()
   write('MoonProject Info\nVersion: '..MoonProject._VERSION..'\nLast Updated: '..MoonProject._LAST_UPDATE..'\nChangelog: '..MoonProject._CHANGELOG..'\n')
end
--- Basic Enviorment
--@section Enviorment
--@param Compiler
--@param SourceFile
--@param Flags
--@param OutputFile
function MoonProject.SetEnv(c, t, f, o)
   MoonProject.checknil(c, t, f, o)
   data[1] = c
   data[2] = t
   data[3] = f
   data[4] = o
   --- Just Build up the program,
   --@return Compiled File
   function MoonProject.Build()
      if not exe(data[1].." "..data[2].." "..data[3].." "..data[4]) then
         assert(false, "Project: Probably Compilation error, Check the error above\n")
      end
   end
   --- Run compiled file
   --@return Compiled File Result
   function MoonProject.Run()
      if not exe('\n./'..data[4]) then
         assert(false, '\nProject: Probably runtime error (or exit code of your code).\n')
      end
   end
   ---Update an output file
   --@return Updated file
   function MoonProject.Update()
      MoonProject.Clean(data[4])
      MoonProject.Build()
      write('File '..data[4]..' is now updated\n')
   end
   --- Build the source program and run.
   --- This is used for debugging
   --@return Compiled Code Result
   function MoonProject.BuildRun()
      write("MoonProject by Lethel(c) Version "..MoonProject._VERSION.."\n")
      write("\n\n1-Compiling...\n")
      if not exe("\n"..data[1].." "..data[2].." "..data[3].." "..data[4]) then
         assert(false, "Project: Probably Compilation error, Check the error above\n")
      else
         write("\nCompilaton success.")
      end
      write("\n\n2-Running...\n")
      write("Results:\n\n")
      if not exe("\n./"..data[4]) then
         assert(false, "Project: Unable to run file (or exit code of your code), Check First and/or Second Step.\n")    end
      write("\n\n_____________\n")
      write("\n\n3-Cleaning...\n")
      if not exe('rm '..data[4]) then
         write("Project WARN: The file already was deleted or name is incorrect.\n")
      else
       write("\nClear success.")
      end
      write("\n\nBuild & Run process completed without any error.\n")
   end
end
--- Dynamic Enviorments
--@section DynamicEnviorment
--@param Compiler
--@param SourceFile
function MoonProject.SetDynamicEnv(c, t)
   MoonProject.checknil(c, t)
   dynamicdata[1] = c
   dynamicdata[2] = t
   --- Build the program without flags and output files
   --@return Compiled File
   function MoonProject.BuildDynamic()
      write("MoonProject by Lethel(c) Version "..MoonProject._VERSION.."\n")
      write('\nBuilding...\n\n')
      if not exe(dynamicdata[1].." "..dynamicdata[2]) then
         assert(false, 'ERROR: Probably compilation error, check the error above.\n')
      else
         write('Building (dynamic mode) success\n')
      end
   end
   --- Build and run without flags and giving output filename
   --- This is used for debug like BuildRun
   --@return Compiled Code Result
   function MoonProject.BuildRunDynamic()
      write("MoonProject by Lethel(c) Version "..MoonProject._VERSION.."\n")
      write('\nBuilding...\n\n')
      if not exe(dynamicdata[1].." "..dynamicdata[2]) then
         assert(false, 'ERROR: Probably compilation error, check the error above.\n')
      end
      write('\nRunning...\n\n')
      write('Results:\n\n')
      if not exe('./'..dynamicdata[2]) then
         assert(false, 'Project: Unable to run file, Check First and/or Second Step.\n')
      end
      write('\nCleaning...\n\n')
      if not remove(dynamicdata[2]) then
        write("Project WARN: The file already was deleted or name is incorrect.\n")
      end
      write("\n\nBuild & Run (Dynamic mode) process completed without any error.\n")
   end
   ---Update an output file
   --@return Updated file
   function MoonProject.Update()
      MoonProject.Clean(dynamicdata[2])
      MoonProject.Build()
      write('File '..data[2]..' is now updated\n')
   end
   --- Run compiled file
   --@return Compiled File Result
   function MoonProject.Run()
      if not exe('\n./'..dynamicdata[2]) then
         assert(false, '\nProject: Probably runtime error (or exit code of your code).\n')
      end
   end
end

--- Check if an value is null or is a empty string
--- For advoid the permission is denied to open the output
--- file
-- @param Value
function MoonProject.checknil(...)
    if ... == nil then
      assert(false, "Project: Fields cannot be empty")
    elseif ... == "" then
      assert(false, "Project: Fields cannot be empty")
    elseif ... == ' ' then
      assert(false, "Project: Fields cannot be a space")
    end
end

--- remove/Delete the file on param 'file'
--@param File
--@return FIle Deleted
function MoonProject.Clean(f)
   MoonProject.checknil(f)
   if not exe('rm -r '..f) or remove(f) then
      write('Project WARN: File has already been deleted or dosent exist\n')
      close(2)
   end
end


--- Make an C file and test its out,
--- After running it will clean;
--@return "Hello World!"
function MoonProject.Test()
   write("Testing with test.c file...\n\n")
   local fi = io.open('./test.c', 'w')
   local env = os.getenv("PATH")
   fi:write('#include <stdio.h>\n\nint main() {\n printf("Hello World!");\n return 0;\n}')
   fi:close()
   write('Testing if gcc is installed...\n')
   if not env:gmatch('/usr/bin/gcc') then
      remove('test.c')
      assert(false, 'Project: gcc not installed, install it with "sudo apt install gcc"\n')
   else
      write('GCC installed and ready to test\n\n')
   end
   MoonProject.BuildRun()
   remove('test.c')
   write('Tested!\n')
end

--- MoonProject.new will create a new project
--- Returns nil if he dont reconigze the language.
--@param name of the project
--@param name of the language
--@return Project
function MoonProject.new(name, language)
   MoonProject.checknil(name, language)
    local function NewProject(command, moduleext)
        if language == command then
            write("Wait till project "..name.." be created... (It will be created in the current folder)\n")
            if not exe('mkdir ./'..name.." && cd "..name.." && mkdir src && cd src && touch main."..command.." && mkdir include && cd include && touch module."..moduleext.." && cd ../../..") then
               write("Project WARN: Folder "..name.." has already been created.\n")
               close(1)
            end
            write("Project "..name.." has been created\nHint: src folder is for your source code, and include folder are for modules for you use.\n")
            close(0)
        end
    end
    local function CustomNProject(nm, command, command2, mde, mde2)
        if language == nm then
        write("Wait till project "..name.." be created... (It will be created in the current folder)\n")
        if not exe('mkdir ./'..name.." && cd "..name.." && mkdir src && cd src && touch main."..command.."&& touch main."..command2.." && mkdir include && cd include && touch module."..mde.."&& touch module."..mde2.." && cd ../../..") then
           write("Project WARN: Folder "..name.." has already been created.\n")
           close(1)
        end
        write("Project "..name.." has been created\nHint: src folder is for your source code, and include folder are for modules for you use.\n")
        close(0)
        end
    end
    NewProject('lua', 'lua')
    NewProject('py', 'py')
    NewProject('go', 'go')
    NewProject('c', 'h')
    NewProject('cpp', 'hh')
    NewProject('java', 'java')
    NewProject('js', 'js')
    NewProject('ts', 'ts')

    CustomNProject('c/cpp', 'c', 'cpp', 'h', 'hh')
end

return MoonProject