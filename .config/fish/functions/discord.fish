function discord --description 'Launch Vesktop if available on the system, else Discord.'
    if type -q vesktop
        vesktop $argv
    else
        command discord $argv
    end
end
