-- Technical Trial Task for Tavernlight Games Software Developer role
-- by Carlos Martínez

-- Q2 - Fix or improve the implementation of the below method

-- 1- I have tabulated the code appropriately to increase readability.
-- 2- I have checked if every name is self-explanatory and follows the camelCase convention (for variables) or PascalCase convention (for functions). I am assuming this convention in also followed by the rest of the code.

-- First function
-- 1- Knowing what this method is supposed to do, I have changed its name to "PrintAllGuildNamesSmallerThan", as it's more fitting than just saying "small", since we can vary the input parameter for the size.
-- 2- The original method returned just one guild name. I have changed it to print all possible rows resulting from the query.
-- 3- Also, I have added a "prepare" statement before the query execution to increase security.
-- 4- I also check if the query execution is valid, just in case the query hasn't been successful or there were no guilds smaller than the memberCount.
-- 5- Now we can iterate through all possible result rows and print the name of the guilds.


-- function that prints the name of all the guilds that have less members than memberCount parameter
function PrintAllGuildNamesSmallerThan(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    -- prepare statement for security
    local statement = db.prepare(selectGuildQuery);
    local resultId = statement:execute(memberCount)

    -- check if there is a valid result
    if resultId then
        -- iterate through all possible rows
        repeat
            -- get next guild
            local row = resultId:fetchRow()
            -- check if it exists
            if row then
                -- get guild name
                local guildName = row["name"]
                -- print guild name
                print(guildName)
            end
        until not resultId:next()
        -- free resources
        db.free(resultId)
    else
        -- no guilds found or query execution error
        print(string.format("No guilds with less than %d members found, or query execution error", memberCount)
    end
end