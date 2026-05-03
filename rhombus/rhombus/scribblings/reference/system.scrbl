#lang rhombus/scribble/manual
@(import:
    "common.rhm" open
    meta_label:
      rhombus/measure
      rhombus/bytes)

@title(~tag: "system"){System Information and Control}

@doc(
  fun system.version() :: String
){

 Reports the running Rhombus version.

 See @rhombusmodname(rhombus/version) for version-number conversion and
 comparison utilities.

@examples(
  system.version()
)

}

@doc(
  fun system.racket_version() :: String
){

 Reports the host Racket version.

 See @rhombusmodname(rhombus/version) for version-number conversion and
 comparison utilities.

@examples(
  system.racket_version()
)

}

@doc(
  fun system.type() :: Symbol
){

 Report the host platform's general type: @rhombus(#'unix),
 @rhombus(#'windows), or @rhombus(#'macosx).

}

@doc(
  fun system.os() :: Symbol
){

 Report the host platform's operating system more specifically than
 @rhombus(system.type). For example, the result may be @rhombus(#'linux)
 or @rhombus(#'freebsd) instead of @rhombus(#'unix).

}

@doc(
  fun system.arch() :: Symbol
){

 Report the host platform's architecture. Possible results include
 @rhombus(#'x86_64), @rhombus(#'i386), @rhombus(#'aarch64),
 @rhombus(#'arm) (32-bit), and @rhombus(#'ppc) (32-bit).

}

@doc(
  fun system.word() :: Int
){

 Report the word size in bits for the host platform's architecture.
 Possible results currently are @rhombus(32) and @rhombus(64).

}

@doc(
  fun system.host() :: String
){

 Reports details of the host operating system in a platform-specific
 format.

}

@doc(
  fun system.target_machine() :: system.TargetMachineSymbol
  annot.macro 'system.TargetMachineSymbol'
){

 Reports the native compilation target machine for the host platform.
 Possible results include @rhombus(#'ta6le), @rhombus(#'tarm64osx), and
 @rhombus(#'ti3nt).

 The @rhombus(system.TargetMachineSymbol, ~annot) annotation is
 satisfied by a machine type symbol that are supported as a compilation
 target by the host Racket system, which may include a cross-compilation
 target machine.

}


@doc(
  fun system.so_suffix() :: Bytes
){

 Reports a file suffix conventionally used by the host operating system
 for @defterm{shared objects}, also known as @defterm{dynamically linked
  libraries}. Possible results include @rhombus(#".so"), @rhombus(#".dll"),
 and @rhombus(#".dylib").

}

@doc(
  fun system.locale_string_encoding() :: String
){

 A string for the current locale's encoding. This string is suitable for
 use as an encoding name with @rhombus(bytes.Converter).

}

@doc(
  fun system.language_and_country() :: String
){

 A string to identify the current user’s language and country.

 On Unix and Mac OS, the string is five characters: two lowercase ASCII
 letters for the language, an underscore, and two uppercase ASCII letters
 for the country. On Windows, the string can be arbitrarily long, but the
 language and country are in English (all ASCII letters or spaces)
 separated by an underscore.

 On Unix, the result is determined by checking the @tt{LC_ALL},
 @tt{LC_TYPE}, and @tt{LANG} environment variables, in that order (and
 the result is used if the environment variable’s value starts with two
 lowercase ASCII letters, an underscore, and two uppercase ASCII letters,
 followed by either nothing or a period). On Windows and Mac OS, the
 result is determined by system calls.

}

@doc(
  fun system.seconds() :: Int
  fun system.milliseconds() :: Flonum
){

 The @rhombus(system.seconds) reports the current time in seconds since
 @deftech{the epoch}, January 1, 1970 UTC, which is consistent with the
 @rhombus(filesystem.modify_seconds) function's result, for example. The
 @rhombus(system.milliseconds) function reports the same time with more
 precision, expressed in milliseconds (including fractional milliseconds)
 since the epoch.

 See also @rhombus(measure.cpu_milliseconds) and
 @rhombus(measure.real_milliseconds).

}


@doc(
  fun system.exit(v :: Any = #true) :: Void
){

 Calls the system exit handler, which normally exits the current
 process. If @rhombus(v) is a byte, then the byte is used as the
 process's exit code, otherwise @rhombus(0) is used as the exit code.

}

@doc(
  fun system.path(which :: system.PathSymbol) :: Path
  enum system.PathSymbol
  | home_dir
  | temp_dir
  | pref_dir
  | pref_file
  | addon_dir
  | host_addon_dir
  | cache_dir
  | doc_dir
  | desk_dir
  | sys_dir
  | exec_file
  | run_file
  | orig_dir
){

 Returns a system-specific path categorized by @rhombus(which):

@itemlist(

 @item{@as_indexed{@rhombus(#'home_dir)}: The current @deftech{user's
   home directory}.

  On all platforms, if the @as_indexed{@envvar{PLTUSERHOME}} environment
  variable is defined as an absolute path, then the path is used as
  the user's home directory.

  On Unix and Mac OS, when @envvar{PLTUSERHOME} does not apply, the
  user's home directory is determined by expanding the path @filepath{~},
  which is expanded by first checking for a @as_indexed{@envvar{HOME}}
  environment variable. If none is defined, the @as_indexed{@envvar{USER}}
  and @as_indexed{@envvar{LOGNAME}} environment variables are consulted
  (in that order) to find a user name, and then system files are consulted
  to locate the user's home directory.

  On Windows, when @envvar{PLTUSERHOME} does not apply, the user's home
  directory is the user-specific profile directory as determined by the
  Windows registry. If the registry cannot provide a directory for some
  reason, the value of the @as_indexed{@envvar{USERPROFILE}} environment
  variable is used instead, as long as it refers to a directory that
  exists. If @envvar{USERPROFILE} also fails, the directory is the one
  specified by the @as_indexed{@envvar{HOMEDRIVE}} and
  @as_indexed{@envvar{HOMEPATH}} environment variables. If those
  environment variables are not defined, or if the indicated directory
  still does not exist, the directory containing the current executable is
  used as the home directory.}

 @item{@as_indexed{@rhombus(#'pref_dir)}: The platform-standard
  directory for storing the current user's preferences. The preferences
  directory might not exist.

  On Unix, the preferences directory is normally the @filepath{racket}
  subdirectory of the path specified by the
  @as_indexed{@envvar{XDG_CONFIG_HOME}} environment variable, or it is
  @filepath{.config/racket} in the @tech{user's home directory} if
  @envvar{XDG_CONFIG_HOME} is not set to an absolute path or if
  @envvar{PLTUSERHOME} is set. Either way, if that directory does not
  exist but a @filepath{.racket} directory exists in the @tech{user's home
   directory}, then that directory is the preference directory, instead.

  On Windows, the preferences directory is @filepath{Racket} in the
  @tech{user's home directory} if determined by @envvar{PLTUSERHOME},
  otherwise in the user's application-data folder as specified by the
  Windows registry; the application-data folder is usually
  @filepath{Application Data} in the user's profile directory.

  On Mac OS, the preferences directory is @filepath{Library/Preferences}
  in the @tech{user's home directory}.}

 @item{@as_indexed{@rhombus(#'pref_file)}: A Racket-format file that
  contains a symbol-keyed association list of preference values. The
  file's directory path always matches the result returned for
  @rhombus(#'pref_dir). The file name is @filepath{racket-prefs.rktd} on
  Unix and Windows, and it is @filepath{org.racket-lang.prefs.rktd} on Mac
  OS. The file's directory might not exist.}

 @item{@as_indexed{@rhombus(#'temp_dir)}: The platform-standard
  directory for storing temporary files. On Unix and Mac OS, this is the
  directory specified by the @as_indexed{@envvar{TMPDIR}} environment
  variable, if it is defined, otherwise it is the first path that exists
  among @filepath{/var/tmp}, @filepath{/usr/tmp}, and @filepath{/tmp}. On
  Windows, the result is the directory specified by the
  @as_indexed{@envvar{TMP}} or @as_indexed{@envvar{TEMP}} environment
  variable, if it is defined, otherwise it is the current directory.}
 
 @item{@as_indexed{@rhombus(#'addon_dir)}: A directory for user-specific
  Racket configuration, packages, and extension. This directory is
  specified by the @as_indexed{@envvar{PLTADDONDIR}} environment variable,
  and it can be overridden by the @exec_flag{--addon} or @exec_flag{-a}
  command-line flag to Racket. If no environment variable or flag is
  specified, or if the value is not a legal path name, then this directory
  defaults to a platform-specific locations. The directory might not
  exist.

  On Unix, the default is normally the @filepath{racket} subdirectory of
  the path specified by @as_indexed{@envvar{XDG_DATA_HOME}}, or
  @filepath{.local/share/racket} in the @tech{user's home directory} if
  @envvar{XDG_CONFIG_HOME} is not set to an absolute path or if
  @envvar{PLTUSERHOME} is set. If that directory does not exists but a
  @filepath{.racket} directory exists in the user's home directory, that
  the @filepath{.racket} directory path is the default, instead.

  On Windows, the default is the same as the @rhombus(#'pref_dir) directory.

  On Mac OS, the default is @filepath{Library/Racket} within the
  @tech{user's home directory}.}

 @item{@as_indexed{@rhombus(#'host_addon_dir)}: Like
  @rhombus(#'addon_dir), but when cross-platform build mode has been
  selected, the result refers to a directory for the current system's
  installation, instead of for the target system.}

 @item{@as_indexed{@rhombus(#'cache_dir)}: A directory for storing
  user-specific caches. The directory might not exist.

  On Unix, the cache directory is normally the @filepath{racket}
  subdirectory of the path specified by
  @as_indexed{@envvar{XDG_CACHE_HOME}}, or @filepath{.cache/racket} in the
  @tech{user's home directory} if @envvar{XDG_CACHE_HOME} is not set to an
  absolute path or if @envvar{PLTUSERHOME} is set. If that directory does
  not exist but a @filepath{.racket} directory exists in the home
  directory, then the @filepath{.racket} directory is the cache directory,
  instead.

  On Windows, the cache directory is the same as the result returned for
  @rhombus(#'addon_dir).

  On Mac OS, the cache directory is @filepath{Library/Caches/Racket}
  within the @tech{user's home directory}.}

 @item{@as_indexed{@rhombus(#'doc_dir)}: The platform-standard directory
  for storing the current user's documents. On Unix, it's the @tech{user's
   home directory}. On Windows, it is the @tech{user's home directory} if
  determined by @envvar{PLTUSERHOME}, otherwise it is the user's documents
  folder as specified by the Windows registry; the documents folder is
  usually @filepath{My Documents} in the user's home directory. On Mac OS,
  it's the @filepath{Documents} directory in the @tech{user's home
   directory}.}

 @item{@as_indexed{@rhombus(#'desk_dir)}: The platform-standard
  directory for the current user's desktop. On Unix, it's the @tech{user's
   home directory}. On Windows, it is the @tech{user's home directory} if
  determined by @envvar{PLTUSERHOME}, otherwise it is the user's desktop
  folder as specified by the Windows registry; the desktop folder is
  usually @filepath{Desktop} in the user's home directory. On Mac OS, it
  is @filepath{Desktop} in the @tech{user's home directory}.}

 @item{@as_indexed{@rhombus(#'sys_dir)}: The directory containing the
  operating system for Windows. On Unix and Mac OS, the result is
  @rhombus(Path("/")).}

 @item{@as_indexed{@rhombus(#'exec_file)}: The path of the Racket
  executable as provided by the operating system for the current
  invocation. For some operating systems, the path can be relative.}

 @item{@as_indexed{@rhombus(#'run_file)}: The path of the current
  executable; this may be different from result for @rhombus(#'exec_file)
  because an alternate path was provided through a @exec_flag{--name} or
  @exec_flag{-N} command-line flag to the Racket executable, or because an
  embedding executable installed an alternate path.}
 
 @item{@as_indexed{@rhombus(#'orig_dir)}: The current directory at
  start-up, which can be useful in converting a relative-path result from
  @rhombus(system.path(#'exec_file)) or @rhombus(system.path(#'run_file))
  to a complete path.}

)

}
