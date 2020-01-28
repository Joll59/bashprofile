using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'deno' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'deno'
        for ($i = 1; $i -lt $commandElements.Count; $i++) {
            $element = $commandElements[$i]
            if ($element -isnot [StringConstantExpressionAst] -or
                $element.StringConstantType -ne [StringConstantType]::BareWord -or
                $element.Value.StartsWith('-')) {
                break
        }
        $element.Value
    }) -join ';'

    $completions = @(switch ($command) {
        'deno' {
            [CompletionResult]::new('-L', 'L', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('--log-level', 'log-level', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('bundle', 'bundle', [CompletionResultType]::ParameterValue, 'Bundle module and dependencies into single file')
            [CompletionResult]::new('completions', 'completions', [CompletionResultType]::ParameterValue, 'Generate shell completions')
            [CompletionResult]::new('eval', 'eval', [CompletionResultType]::ParameterValue, 'Eval script')
            [CompletionResult]::new('fetch', 'fetch', [CompletionResultType]::ParameterValue, 'Fetch the dependencies')
            [CompletionResult]::new('fmt', 'fmt', [CompletionResultType]::ParameterValue, 'Format files')
            [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Show info about cache or info related to source file')
            [CompletionResult]::new('install', 'install', [CompletionResultType]::ParameterValue, 'Install script as executable')
            [CompletionResult]::new('repl', 'repl', [CompletionResultType]::ParameterValue, 'Read Eval Print Loop')
            [CompletionResult]::new('run', 'run', [CompletionResultType]::ParameterValue, 'Run a program given a filename or url to the source code')
            [CompletionResult]::new('test', 'test', [CompletionResultType]::ParameterValue, 'Run tests')
            [CompletionResult]::new('types', 'types', [CompletionResultType]::ParameterValue, 'Print runtime TypeScript declarations')
            [CompletionResult]::new('xeval', 'xeval', [CompletionResultType]::ParameterValue, 'Eval a script on text segments from stdin')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Prints this message or the help of the given subcommand(s)')
            break
        }
        'deno;bundle' {
            [CompletionResult]::new('-L', 'L', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('--log-level', 'log-level', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'deno;completions' {
            [CompletionResult]::new('-L', 'L', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('--log-level', 'log-level', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'deno;eval' {
            [CompletionResult]::new('-L', 'L', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('--log-level', 'log-level', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'deno;fetch' {
            [CompletionResult]::new('-r', 'r', [CompletionResultType]::ParameterName, 'Reload source code cache (recompile TypeScript)')
            [CompletionResult]::new('--reload', 'reload', [CompletionResultType]::ParameterName, 'Reload source code cache (recompile TypeScript)')
            [CompletionResult]::new('--lock', 'lock', [CompletionResultType]::ParameterName, 'Check the specified lock file')
            [CompletionResult]::new('--importmap', 'importmap', [CompletionResultType]::ParameterName, 'Load import map file')
            [CompletionResult]::new('-c', 'c', [CompletionResultType]::ParameterName, 'Load tsconfig.json configuration file')
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Load tsconfig.json configuration file')
            [CompletionResult]::new('-L', 'L', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('--log-level', 'log-level', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('--lock-write', 'lock-write', [CompletionResultType]::ParameterName, 'Write lock file. Use with --lock.')
            [CompletionResult]::new('--no-remote', 'no-remote', [CompletionResultType]::ParameterName, 'Do not resolve remote modules')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'deno;fmt' {
            [CompletionResult]::new('--prettierrc', 'prettierrc', [CompletionResultType]::ParameterName, 'Specify the configuration file of the prettier.
  auto: Auto detect prettier configuration file in current working dir.
  disable: Disable load configuration file.
  FILE: Load specified prettier configuration file. support .json/.toml/.js/.ts file
 ')
            [CompletionResult]::new('--ignore-path', 'ignore-path', [CompletionResultType]::ParameterName, 'Path to a file containing patterns that describe files to ignore.
  auto: Auto detect .pretierignore file in current working dir.
  disable: Disable load .prettierignore file.
  FILE: Load specified prettier ignore file.
 ')
            [CompletionResult]::new('--print-width', 'print-width', [CompletionResultType]::ParameterName, 'Specify the line length that the printer will wrap on.')
            [CompletionResult]::new('--tab-width', 'tab-width', [CompletionResultType]::ParameterName, 'Specify the number of spaces per indentation-level.')
            [CompletionResult]::new('--quote-props', 'quote-props', [CompletionResultType]::ParameterName, 'Change when properties in objects are quoted.')
            [CompletionResult]::new('--arrow-parens', 'arrow-parens', [CompletionResultType]::ParameterName, 'Include parentheses around a sole arrow function parameter.')
            [CompletionResult]::new('--prose-wrap', 'prose-wrap', [CompletionResultType]::ParameterName, 'How to wrap prose.')
            [CompletionResult]::new('--end-of-line', 'end-of-line', [CompletionResultType]::ParameterName, 'Which end of line characters to apply.')
            [CompletionResult]::new('-L', 'L', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('--log-level', 'log-level', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('--check', 'check', [CompletionResultType]::ParameterName, 'Check if the source files are formatted.')
            [CompletionResult]::new('--stdout', 'stdout', [CompletionResultType]::ParameterName, 'Output formated code to stdout')
            [CompletionResult]::new('--use-tabs', 'use-tabs', [CompletionResultType]::ParameterName, 'Indent lines with tabs instead of spaces.')
            [CompletionResult]::new('--no-semi', 'no-semi', [CompletionResultType]::ParameterName, 'Print semicolons at the ends of statements.')
            [CompletionResult]::new('--single-quote', 'single-quote', [CompletionResultType]::ParameterName, 'Use single quotes instead of double quotes.')
            [CompletionResult]::new('--jsx-single-quote', 'jsx-single-quote', [CompletionResultType]::ParameterName, 'Use single quotes instead of double quotes in JSX.')
            [CompletionResult]::new('--jsx-bracket-same-line', 'jsx-bracket-same-line', [CompletionResultType]::ParameterName, 'Put the > of a multi-line JSX element at the end of the last line
instead of being alone on the next line (does not apply to self closing elements).')
            [CompletionResult]::new('--trailing-comma', 'trailing-comma', [CompletionResultType]::ParameterName, 'Print trailing commas wherever possible when multi-line.')
            [CompletionResult]::new('--no-bracket-spacing', 'no-bracket-spacing', [CompletionResultType]::ParameterName, 'Print spaces between brackets in object literals.')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'deno;info' {
            [CompletionResult]::new('-L', 'L', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('--log-level', 'log-level', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'deno;install' {
            [CompletionResult]::new('-d', 'd', [CompletionResultType]::ParameterName, 'Installation directory (defaults to $HOME/.deno/bin)')
            [CompletionResult]::new('--dir', 'dir', [CompletionResultType]::ParameterName, 'Installation directory (defaults to $HOME/.deno/bin)')
            [CompletionResult]::new('-L', 'L', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('--log-level', 'log-level', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'deno;repl' {
            [CompletionResult]::new('--v8-flags', 'v8-flags', [CompletionResultType]::ParameterName, 'Set V8 command line options. For help: --v8-flags=--help')
            [CompletionResult]::new('-L', 'L', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('--log-level', 'log-level', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'deno;run' {
            [CompletionResult]::new('--importmap', 'importmap', [CompletionResultType]::ParameterName, 'Load import map file')
            [CompletionResult]::new('-r', 'r', [CompletionResultType]::ParameterName, 'Reload source code cache (recompile TypeScript)')
            [CompletionResult]::new('--reload', 'reload', [CompletionResultType]::ParameterName, 'Reload source code cache (recompile TypeScript)')
            [CompletionResult]::new('-c', 'c', [CompletionResultType]::ParameterName, 'Load tsconfig.json configuration file')
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Load tsconfig.json configuration file')
            [CompletionResult]::new('--lock', 'lock', [CompletionResultType]::ParameterName, 'Check the specified lock file')
            [CompletionResult]::new('--v8-flags', 'v8-flags', [CompletionResultType]::ParameterName, 'Set V8 command line options. For help: --v8-flags=--help')
            [CompletionResult]::new('--allow-read', 'allow-read', [CompletionResultType]::ParameterName, 'Allow file system read access')
            [CompletionResult]::new('--allow-write', 'allow-write', [CompletionResultType]::ParameterName, 'Allow file system write access')
            [CompletionResult]::new('--allow-net', 'allow-net', [CompletionResultType]::ParameterName, 'Allow network access')
            [CompletionResult]::new('--seed', 'seed', [CompletionResultType]::ParameterName, 'Seed Math.random()')
            [CompletionResult]::new('-L', 'L', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('--log-level', 'log-level', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('--lock-write', 'lock-write', [CompletionResultType]::ParameterName, 'Write lock file. Use with --lock.')
            [CompletionResult]::new('--no-remote', 'no-remote', [CompletionResultType]::ParameterName, 'Do not resolve remote modules')
            [CompletionResult]::new('--allow-env', 'allow-env', [CompletionResultType]::ParameterName, 'Allow environment access')
            [CompletionResult]::new('--allow-run', 'allow-run', [CompletionResultType]::ParameterName, 'Allow running subprocesses')
            [CompletionResult]::new('--allow-plugin', 'allow-plugin', [CompletionResultType]::ParameterName, 'Allow loading plugins')
            [CompletionResult]::new('--allow-hrtime', 'allow-hrtime', [CompletionResultType]::ParameterName, 'Allow high resolution time measurement')
            [CompletionResult]::new('-A', 'A', [CompletionResultType]::ParameterName, 'Allow all permissions')
            [CompletionResult]::new('--allow-all', 'allow-all', [CompletionResultType]::ParameterName, 'Allow all permissions')
            [CompletionResult]::new('--cached-only', 'cached-only', [CompletionResultType]::ParameterName, 'Require that remote dependencies are already cached')
            [CompletionResult]::new('--current-thread', 'current-thread', [CompletionResultType]::ParameterName, 'Use tokio::runtime::current_thread')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'deno;test' {
            [CompletionResult]::new('--importmap', 'importmap', [CompletionResultType]::ParameterName, 'Load import map file')
            [CompletionResult]::new('-r', 'r', [CompletionResultType]::ParameterName, 'Reload source code cache (recompile TypeScript)')
            [CompletionResult]::new('--reload', 'reload', [CompletionResultType]::ParameterName, 'Reload source code cache (recompile TypeScript)')
            [CompletionResult]::new('-c', 'c', [CompletionResultType]::ParameterName, 'Load tsconfig.json configuration file')
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Load tsconfig.json configuration file')
            [CompletionResult]::new('--lock', 'lock', [CompletionResultType]::ParameterName, 'Check the specified lock file')
            [CompletionResult]::new('--v8-flags', 'v8-flags', [CompletionResultType]::ParameterName, 'Set V8 command line options. For help: --v8-flags=--help')
            [CompletionResult]::new('--allow-read', 'allow-read', [CompletionResultType]::ParameterName, 'Allow file system read access')
            [CompletionResult]::new('--allow-write', 'allow-write', [CompletionResultType]::ParameterName, 'Allow file system write access')
            [CompletionResult]::new('--allow-net', 'allow-net', [CompletionResultType]::ParameterName, 'Allow network access')
            [CompletionResult]::new('--seed', 'seed', [CompletionResultType]::ParameterName, 'Seed Math.random()')
            [CompletionResult]::new('-e', 'e', [CompletionResultType]::ParameterName, 'List of file names to exclude from run')
            [CompletionResult]::new('--exclude', 'exclude', [CompletionResultType]::ParameterName, 'List of file names to exclude from run')
            [CompletionResult]::new('-L', 'L', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('--log-level', 'log-level', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('--lock-write', 'lock-write', [CompletionResultType]::ParameterName, 'Write lock file. Use with --lock.')
            [CompletionResult]::new('--no-remote', 'no-remote', [CompletionResultType]::ParameterName, 'Do not resolve remote modules')
            [CompletionResult]::new('--allow-env', 'allow-env', [CompletionResultType]::ParameterName, 'Allow environment access')
            [CompletionResult]::new('--allow-run', 'allow-run', [CompletionResultType]::ParameterName, 'Allow running subprocesses')
            [CompletionResult]::new('--allow-plugin', 'allow-plugin', [CompletionResultType]::ParameterName, 'Allow loading plugins')
            [CompletionResult]::new('--allow-hrtime', 'allow-hrtime', [CompletionResultType]::ParameterName, 'Allow high resolution time measurement')
            [CompletionResult]::new('-A', 'A', [CompletionResultType]::ParameterName, 'Allow all permissions')
            [CompletionResult]::new('--allow-all', 'allow-all', [CompletionResultType]::ParameterName, 'Allow all permissions')
            [CompletionResult]::new('--cached-only', 'cached-only', [CompletionResultType]::ParameterName, 'Require that remote dependencies are already cached')
            [CompletionResult]::new('--current-thread', 'current-thread', [CompletionResultType]::ParameterName, 'Use tokio::runtime::current_thread')
            [CompletionResult]::new('-f', 'f', [CompletionResultType]::ParameterName, 'Stop on first error')
            [CompletionResult]::new('--failfast', 'failfast', [CompletionResultType]::ParameterName, 'Stop on first error')
            [CompletionResult]::new('-q', 'q', [CompletionResultType]::ParameterName, 'Don''t show output from test cases')
            [CompletionResult]::new('--quiet', 'quiet', [CompletionResultType]::ParameterName, 'Don''t show output from test cases')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'deno;types' {
            [CompletionResult]::new('-L', 'L', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('--log-level', 'log-level', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'deno;xeval' {
            [CompletionResult]::new('-I', 'I', [CompletionResultType]::ParameterName, 'Set variable name to be used in eval, defaults to $')
            [CompletionResult]::new('--replvar', 'replvar', [CompletionResultType]::ParameterName, 'Set variable name to be used in eval, defaults to $')
            [CompletionResult]::new('-d', 'd', [CompletionResultType]::ParameterName, 'Set delimiter, defaults to newline')
            [CompletionResult]::new('--delim', 'delim', [CompletionResultType]::ParameterName, 'Set delimiter, defaults to newline')
            [CompletionResult]::new('-L', 'L', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('--log-level', 'log-level', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'deno;help' {
            [CompletionResult]::new('-L', 'L', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('--log-level', 'log-level', [CompletionResultType]::ParameterName, 'Set log level')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
    })

    $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
        Sort-Object -Property ListItemText
}