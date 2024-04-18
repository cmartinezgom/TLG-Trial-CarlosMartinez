-- Technical Trial Task for Tavernlight Games Software Developer role
-- by Carlos Martínez

-- Q3 - Fix or improve the implementation of the below method

-- 1- I have tabulated the code appropriately to increase readability.
-- 2- I have checked if every name is self-explanatory and follows the camelCase convention (for variables) or PascalCase convention (for functions). I am assuming this convention in also followed by the rest of the code.

-- First function
-- 1- The name "do_sth_with_PlayerParty" is extremely vague isn't PascalCase. Changed it to "RemovePlayerFromParty".
-- 2- The parameter "memberName" wasn't camelCase.
-- 3- Ensured that the player exists.
-- 4- Added a bool as a return to know if the player was removed from the party.
-- 5- Check if the player was in a party or not. Assuming here that players can only be in one party at a time.
-- 6- Calling the returned members from the party "v" isn't descriptive enough, changed it to "members"
-- 7- Here there's a dilemma. We can just assume that the player is in the party, as we've get it from them.
--    This way we can skip searching again for the player in the party using the memberName parameter, and we could
--    also remove it from the function's signature.
--    However, we could use the "memberName" parameter to check if "playerId" was indeed from the same player, but feels redundant
--    and I don't know if the "memberName" is unique, while I can assume that "playerId" is.
--    So, I have removed the "memberName" parameter and the redundant for loop.



-- function that removes a player from their party
function RemovePlayerFromParty(playerId)
    -- get player from playerId
    player = Player(playerId)

    -- check if player is valid
    if player then
        -- get player's party
        local party = player:getParty()
        -- check if player has a valid party
        -- also, assuming players can only be in one party
        if party then
            -- player was in a party, try to remove them from it
            party:removeMember(player)
            return true
        else
            -- player wasn't in a party
            print(string.format("Player with %d id was not in a party", playerId)
            return false
        end
    else
        print(string.format("No Player with %d id found", playerId)
        return false
    end
end