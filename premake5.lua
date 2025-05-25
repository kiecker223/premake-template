workspace "CHANGEME"
    configurations { "Debug", "Release" }
    platforms { "x64" }
    warnings "Default"

    filter "platforms:x64"
      architecture "x86_64"
    filter {}
	
	filter "system:Windows"
	  defines { "WINDOWS_BUILD" }
	filter "system:Unix"
	  defines { "LINUX_BUILD" }
	filter {}
   
    filter "configurations:Debug"
      defines { "DEBUG" }

    filter "configurations:Release"
      defines { "RELEASE", "NDEBUG" }
      flags {
        "LinkTimeOptimization",
      }
      optimize "On"

    filter {"platforms:x64", "configurations:Release"}
      targetdir "Build/Release"
    filter {"platforms:x64", "configurations:Debug"}
      targetdir "Build/Debug"
    filter {}

    objdir "%{cfg.targetdir}/obj"

    symbols "FastLink"

    filter {"configurations:Release"}
      symbols "Full"
    filter {}

    flags {
      "MultiProcessorCompile",
      "StaticRuntime"
    }

    exceptionhandling "Off"
    cppdialect "C++17"
    language "C++"
    characterset "ASCII"
    startproject "BaneGame"

    vpaths {
      ["Lua"] = "**.lua"
    }

project "BuildFiles"
    kind "None"
    files {"**.lua"}

project("Regenerate premake")
    kind "Utility"
    prebuildcommands("%{prj.location}../Tools/premake5.exe --file=%{prj.location}../premake5.lua vs2022")
