function nv --wraps nvim 
    if [ (count $argv) -lt 1 ];
        if [ -d ./src/ ]; nvim ./src/
        else; nvim .
        end
    else; nvim $argv
    end
end

