var pwdStrength = function(password){

    function isLetter(string) 
    {
        return string.length === 1 && string.match(/[a-z]/i);
    }

    function countUnique(iterable)
    {
        return new Set(iterable).size;
    }

    var numbers = 0;
    var lowLetters = 0;
    var upperLetters = 0;
    var uniqueSymbols = 0;
    var symbols = [];
    for(i = 0; i < password.length; i++)
        if(!isNaN(Number(password[i])))
            numbers++;
        else if(isLetter(password[i]) && password[i] === password[i].toLowerCase())
            lowLetters++;
        else if(isLetter(password[i]) && password[i] === password[i].toUpperCase())
            upperLetters++;
        else 
            symbols[symbols.length] = password[i];
    uniqueSymbols = countUnique(symbols);

    if(numbers > $("#newPassword").val().length / 2)
        return "weak";
    else if(uniqueSymbols > 1 && lowLetters > 0 && upperLetters > 0)
        return "strong";
    else if(password.length !== 0)
        return "medium";
    else return "-";
};

