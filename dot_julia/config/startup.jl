using Revise
using TestEnv
using Infiltrator

if isinteractive()
    @eval using VimBindings

    function restart_repl()
        argv = Base.julia_cmd().exec
        opts = Base.JLOptions()
        if opts.nthreads != 0
            push!(argv, "--threads=$(opts.nthreads)")
        end
        push!(argv, "--interactive")
        push!(argv, "--eval")
        startup = """
            Base.ACTIVE_PROJECT[]=$(repr(Base.ACTIVE_PROJECT[]))
            Base.HOME_PROJECT[]=$(repr(Base.HOME_PROJECT[]))
            cd($(repr(pwd())))
        """
        push!(argv, startup)
        @ccall execv(argv[1]::Cstring, argv::Ref{Cstring})::Cint
    end
end

atreplinit() do repl
    @eval using OhMyREPL
    @eval using TestPicker
    @eval using RCall
end
